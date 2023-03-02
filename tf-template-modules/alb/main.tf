resource "aws_lb" "alb" {
  name               = "web"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids

  security_groups = [
    var.web_security_group_id,
  ]

  tags = {
    Name = "web"
  }
}

resource "aws_lb_target_group" "web" {
  name_prefix        = "web-"
  port               = var.target_group_port
  protocol           = var.target_group_protocol
  vpc_id             = var.vpc_id
  target_type        = "instance"
  health_check {
    protocol = var.target_group_protocol
    port     = var.target_group_port
    path     = "/"
  }

  tags = {
    Name = "web"
  }
}

resource "aws_security_group_rule" "lb_ingress" {
  type        = "ingress"
  from_port   = var.target_group_port
  to_port     = var.target_group_port
  protocol    = var.target_group_protocol
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = var.web_security_group_id
}

resource "aws_security_group_rule" "web_ingress" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_lb.alb.security_groups[0]
}

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_ids[0]

  tags = {
    Name = "nat"
  }
}

resource "aws_route_table" "private" {
  count = length(var.private_subnet_ids)

  vpc_id = var.vpc_id

  tags = {
    Name = "private-${count.index}"
  }
}

resource "aws_route" "private_nat" {
  count = length(var.private_subnet_ids)

  route_table_id = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_ids)

  subnet_id      = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private[count.index].id
}
