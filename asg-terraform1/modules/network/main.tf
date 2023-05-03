resource "aws_vpc" "main" {
  cidr_block = var.subnet_cidr_block
  /* tags = {
    Name = "vpc-main"
  } */
}

resource "aws_subnet" "private" {
  cidr_block = var.subnet_cidr_block
  vpc_id = aws_vpc.main.id
  availability_zone = var.availability_zone
  /* tags = {
    Name = "subnet-private"
  } */
}

resource "aws_security_group" "main" {
  name_prefix = "test"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /* tags = {
    Name = "sg-main"
  } */
}

resource "aws_lb" "main" {
  name               = var.nlb_name
  internal           = var.nlb_internal
  load_balancer_type = var.load_balancer_type

  subnet_mapping {
    subnet_id = aws_subnet.private.id
  }

  /* tags = {
    Name = var.tags
  } */
}

resource "aws_lb_target_group" "main" {
  name_prefix      = "test"
  port             = var.target_group_port
  protocol         = var.target_group_protocol
  target_type      = var.target_type
  vpc_id           = aws_vpc.main.id
  health_check {
    protocol = var.target_group_health_check_protocol
  }

  /* tags = {
    Name = var.tags
  } */
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.main.arn
    type             = "forward"
  }

  depends_on = [aws_lb_target_group.main]
}
