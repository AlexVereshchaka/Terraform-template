output "aws_subnet_id" {
  value = aws_subnet.private.id
}

output "aws_security_group" {
  value = aws_security_group.main.id
}

output "target_group_arn" {
  value = aws_lb_target_group.main.arn
}

output "aws_vpc_id" {
  value = aws_vpc.main.id
}

output "aws_nlb" {
  value = aws_lb.main.name
}

output "subnet_ids" {
  value = aws_subnet.private.id
}