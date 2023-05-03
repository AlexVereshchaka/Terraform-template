variable "asg_name" {
  type        = string
  description = "Name of the Auto Scaling Group"
}



variable "elb_name" {
  type        = string
  description = "Name of the Elastic Load Balancer"
}

variable "min_size" {
  type        = number
  default     = 2
  description = "Minimum number of instances in the Auto Scaling Group"
}

variable "max_size" {
  type        = number
  default     = 4
  description = "Maximum number of instances in the Auto Scaling Group"
}

variable "desired_capacity" {
  type        = number
  default     = 2
  description = "Desired capacity of the Auto Scaling Group"
}

variable "vpc_zone_identifier" {
  
}

variable "subnet_ids" {
  
}

variable "aws_lb_target_group" {
  
}
# Launch template module

variable "instance_type" {
  type = string
}





variable "ami_ids" {
  type = list(string)
}

variable "security_group" {
  
}

variable "target_group_arn" {
  
}