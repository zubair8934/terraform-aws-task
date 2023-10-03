
# Creating Target Group
resource "aws_lb_target_group" "My-Wp-TG" {
  health_check {
    interval            = 120
    path                = "/"
    protocol            = "HTTP"
    timeout             = 60
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }

  name             = "My-Wp-TG"
  port             = 80
  protocol         = "HTTP"
  target_type      = "instance"
  vpc_id           = aws_vpc.my_wp_vpc.id
  protocol_version = "HTTP1"

  tags = {
    Name = "My-Wp-TG"
  }

}


# Creating ALB

resource "aws_lb" "My-Wp-ALB" {
  name               = "My-Wp-ALB"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.my_alb_SG.id}"]
  subnets = [
    aws_subnet.us_east_1a_pub.id,
    aws_subnet.us_east_1b_pub.id,
  ]

  tags = {
    Name = "My-Wp-ALB"
  }

}

#Creating Listener
resource "aws_lb_listener" "My_Wp_ALB_Listener" {
  load_balancer_arn = aws_lb.My-Wp-ALB.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.My-Wp-TG.arn
    type             = "forward"
  }
}


# Attaching target group with ALB
resource "aws_lb_target_group_attachment" "ec2_attach" {
  count            = length(aws_instance.my_wp_instance)
  target_group_arn = aws_lb_target_group.My-Wp-TG.arn
  target_id        = aws_instance.my_wp_instance[count.index].id

}