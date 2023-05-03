provider "aws" {
  region = "us-west-1"
}

module "ec2" {
  source              = "./modules/ec2"
  instance_name       = "Name"
  ami_id              = "ami-0c55b159cbfafe1f0"
  instance_type       = "t2.micro"
  key_name            = "my-key"
  subnet_id           = "subnet-abc123"
  security_group_name = "my-security-group"

  tags = {
    Name = "MyEC2Instance"
  }
}
module "network" {
  source = "./modules/network"
  #NLB
  nlb_name           = "my-nlb"
  private_subnet_id  = module.network.aws_subnet_id
  security_group_id  = module.network.aws_security_group
  protocol           = "TCP"
  load_balancer_type = "network"

  #VPC
  vpc_cidr_block    = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  subnet_cidr_block = "10.0.1.0/24"

  #Target Group
  target_group_port                             = 80
  target_group_protocol                         = "TCP"
  target_group_health_check_path                = "/health"
  target_group_health_check_protocol            = "TCP"
  target_group_health_check_port                = 80
  target_group_health_check_interval            = 30
  target_group_health_check_timeout             = 5
  target_group_health_check_healthy_threshold   = 3
  target_group_health_check_unhealthy_threshold = 3
  target_type                                   = "instance"
  nlb_internal                                  = true

  /* tags = {
      Name = "nlb-main"
  } */
}

module "cloudwatch-alarms" {
  source = "./modules/cloudwatch-alarms"

  alarm_name_high    = "HighCPUUsage"
  aws_instance_id = module.ec2.aws_instance_id
  alarm_threshold    = 80
  period             = "60"
  metric_name        = "CPUUtilization"
  evaluation_periods = 2
  threshold = 50
  comparison_operator_l = "LessThanThreshold"
  comparison_operator_h = "GreaterThanThreshold"
  namespace          = "AWS/EC2"
  alarm_actions = module.lambda_function.alarm_actions
}

module "lambda_function" {
  source = "./modules/lambda"
  function_name = "server_redirect_lambda"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  alarm_name_high = "high-alarm"
  vpc_subnet_ids = module.network.aws_subnet_id
  security_group_ids = module.network.aws_security_group
  nlb_dns_name = module.network.aws_nlb
  /* asg_name = module.auto_scaling_group.asg_name */
  /* target_instance_id = module.auto_scaling_group.target_instance_id */
  alarm_name = [module.cloudwatch-alarms.aws_cloudwatch_metric_alarm_high, module.cloudwatch-alarms.aws_cloudwatch_metric_alarm_low]
  /* region = var.region */
}


module "autoscaling" {
  source = "./modules/asg"
  asg_name         = "my-asg"
  elb_name         = module.network.aws_nlb
  min_size         = 1
  max_size         = 2
  desired_capacity = 1
  instance_type = "t3.micro"
  ami_ids = ["ami-0453f67283fbdec39", "ami-0a830948c354b21a5", "ami-00f136ac48acf2618"]
  aws_lb_target_group = module.network.target_group_arn
  subnet_ids = module.network.subnet_ids
  target_group_arn = module.network.target_group_arn
  vpc_zone_identifier = module.network.subnet_ids
  security_group = module.network.aws_security_group
}



