# Creating security group my_wp_SG
resource "aws_security_group" "my_wp_SG" {
  description = "Allow ssh from anywhere and http from load balancer sceurity group"
  vpc_id      = aws_vpc.my_wp_vpc.id
  name        = "my_wp_SG"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

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
    Name = "my_wp_SG"
  }
}