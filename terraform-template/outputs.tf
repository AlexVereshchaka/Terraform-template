output "lb_dns_name" {
value = aws_lb.my_lb.dns_name
}

output "rds_endpoint" {
value = aws_db_instance.my_db_instance.endpoint
}
