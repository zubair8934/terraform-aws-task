# Creating security group my_wp_SG for wordpress server
resource "aws_security_group" "my_wp_SG" {
  description = "Allow ssh from anywhere and http traffic from load balancer sceurity group"
  vpc_id      = aws_vpc.my_wp_vpc.id
  name        = "my_wp_SG"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

  ingress {
    description     = "allow http from ALB security group"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.my_alb_SG.id]
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


# Creating security group my_wp_SG for Application Load Balancer
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


# create security group My-RDS-SG for the RDS mysql/aurora database
resource "aws_security_group" "My-RDS-SG" {
  name        = "database security group"
  description = "enable mysql/aurora access on port 3306 from my_wp_SG security group"
  vpc_id      = aws_vpc.my_wp_vpc.id

  ingress {
    description     = "mysql/aurora access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.my_wp_SG.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My-RDS-SG"
  }
}


# Creating security group my_efs_SG for EFS file system
resource "aws_security_group" "my_efs_SG" {
  description = "Allow NFS traffic from my_wp_SG security group"
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