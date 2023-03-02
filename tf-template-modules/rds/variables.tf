variable "vpc_id" {
  description = "ID of the VPC"
}

variable "private_subnet_ids" {
  description = "IDs of the private subnets"
    type = list(string)
}

variable "db_subnet_group_name" {
    description = "Name of the DB subnet group"
}

variable "db_name" {
    description = "Name of the database"
    default = "wordpress"
}

variable "db_username" {
    description = "Username for the database"
    default = "wordpress"
}

variable "db_password" {
    description = "Password for the database"
}

variable "db_port" {
    description = "Port for the database"
    default = 3306
}

variable "db_instance_class" {
    description = "Instance class for the database"
    default = "db.t3.micro"
}

variable "db_engine" {
    description = "Database engine"
    default = "mysql"
}

variable "db_engine_version" {
    description = "Database engine version"
    default = "5.7"
}

variable "db_parameter_group_name" {
    description = "Name of the DB parameter group"  
}
