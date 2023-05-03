
variable "instance_type" {
}

variable "ami_id" {
}

variable "key_name" {
}

variable "subnet_id" {
}


variable "security_group_name" {
  
}

variable "instance_name" {
  
}
variable "tags" {
  type    = map(string)
  default = {}
}