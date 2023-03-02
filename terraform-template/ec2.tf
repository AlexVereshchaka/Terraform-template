resource "aws_instance" "my_ec2_instance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_subnet_1.id
  key_name               = "my_key_pair"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  

  tags = {
    Name = "my_ec2_instance"
  }
}
resource "aws_eip_association" "my_eip_assoc" {
  instance_id   = aws_instance.my_ec2_instance.id
  allocation_id = aws_eip.my_eip.id
}