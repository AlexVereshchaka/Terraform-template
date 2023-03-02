resource "aws_lb" "my_lb" {
    name = "mylb"
    internal = false
    load_balancer_type = "application"
    subnets = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

tags = {
Name = "my_lb"
}
}

resource "aws_lb_target_group" "web_tg" {
    name_prefix = "webtg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.my_vpc.id

health_check {
    healthy_threshold = 2
    interval = 30
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 10
    unhealthy_threshold = 5
}

tags = {
    Name = "web_tg"
}
}

resource "aws_lb_listener" "web_listener" {
    load_balancer_arn = aws_lb.my_lb.arn
    port = "80"
    protocol = "HTTP"

default_action {
    target_group_arn = aws_lb_target_group.web_tg.arn
    type = "forward"
}
}
