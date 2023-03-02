resource "aws_db_subnet_group" "my_db_subnet_group" {
    name = "my_db_subnet_group"
    subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

    tags = {
        Name = "my_db_subnet_group"
}
}

resource "aws_db_instance" "my_db_instance" {
    allocated_storage = 20
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t3.micro"
    name = "my_db_instance"
    username = "admin"
    password = "password"
    db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name

tags = {
    Name = "my_db_instance"
}
}