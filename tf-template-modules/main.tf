provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc"
}

module "security_groups" {
  source = "./vpc"
}

module "load_balancer" {
  source = "./alb"
  vpc_id                  = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  web_security_group_id = module.vpc.security_group_ids
}

module "nat_gateway" {
  source = "./nat"
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids

}

module "database" {
  source = "./rds"
  db_parameter_group_name = "default.mysql5.7"
  vpc_id                  = module.vpc.vpc_id
  db_password        = "password" 
  private_subnet_ids = module.vpc.private_subnet_ids
  db_subnet_group_name    = "db_subnet_group"



}

module "ec2_instance" {
  source = "./rds"
  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnet_ids
  db_parameter_group_name = "default.mysql5.7" 
  db_subnet_group_name    = "db_subnet_group"
  db_password        = "password" 

}

terraform {
  backend "s3" {
    bucket = "tfstste-b13"
    key    = "wordpress/terraform.tfstate"
    region = "us-east-1"
  }
}
