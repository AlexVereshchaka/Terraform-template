variable "vpc_cidr_block" {
  description = "CIDR блок VPC"
}

variable "availability_zone" {
  
}
variable "subnet_cidr_block" {
  description = "CIDR блок приватной сети"
  type = string
}

variable "nlb_name" {
  description = "Имя Network Load Balancer"
}
variable "protocol" {
  
}
variable "target_type" {
  
}

variable "load_balancer_type" {
  
}
variable "nlb_internal" {
  description = "Внутренний ли NLB"
  type        = bool
  default     = false
}

variable "target_group_port" {
  description = "Порт, который прослушивает target group"
}

variable "target_group_protocol" {
  description = "Протокол, который использует target group"
}

variable "target_group_health_check_path" {
  description = "Путь до health check для target group"
}

variable "target_group_health_check_protocol" {
  description = "Протокол для health check"
}

variable "target_group_health_check_port" {
  description = "Порт для health check"
}

variable "target_group_health_check_interval" {
  description = "Интервал между health check проверками"
}

variable "target_group_health_check_timeout" {
  description = "Максимальное время ожидания health check"
}

variable "target_group_health_check_healthy_threshold" {
  description = "Количество успешных health check для помечания инстанса как здорового"
}

variable "target_group_health_check_unhealthy_threshold" {
  description = "Количество неуспешных health check для помечания инстанса как нездорового"
}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "private_subnet_id" {
  description = "ID приватной подсети"
}

variable "security_group_id" {
  description = "ID группы безопасности"
}

