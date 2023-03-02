output "nat_eip" {
  description = "Public IP of theNAT gateway"
  value = aws_eip.nat.public_ip
}

output "nat_gateway_id" {
    description = "ID of the NAT gateway"
    value = aws_nat_gateway.nat.id
}
