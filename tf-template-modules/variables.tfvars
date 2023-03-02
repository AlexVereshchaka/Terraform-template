vpc_cidr_block = "10.0.0.0/16"

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

ami_id        = "ami-0c94855ba95c71c99"
instance_type = "t3.micro"
key_name      = "my-key-pair"
