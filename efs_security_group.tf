# Creating security group my_wp_SG
resource "aws_security_group" "my_efs_SG" {
  description = "Allow http from anywhere"
  vpc_id      = aws_vpc.my_wp_vpc.id
  name        = "my_efs_SG"

  ingress {
    security_groups = [aws_security_group.my_wp_SG.id]
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
  }

  egress {
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "my_efs_SG"
  }
}