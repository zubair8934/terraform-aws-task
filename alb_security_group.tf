# Creating security group my_wp_SG
resource "aws_security_group" "my_alb_SG" {
  description = "Allow http from anywhere"
  vpc_id      = aws_vpc.my_wp_vpc.id
  name        = "my_alb_SG"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
  }

  egress {
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "my_alb_SG"
  }
}