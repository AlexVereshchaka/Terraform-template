resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "db_subnet_group"
  }
}

resource "aws_db_instance" "db" {
  identifier             = "wordpress"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  port                   = var.db_port
  vpc_security_group_ids = [module.security_groups.rds_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  parameter_group_name   = var.db_parameter_group_name

  tags = {
    Name = "wordpress"
  }
}

resource "aws_security_group_rule" "db_ingress" {
  type        = "ingress"
  from_port   = var.db_port
  to_port     = var.db_port
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.security_groups.rds_security_group_id
}
