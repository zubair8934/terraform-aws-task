#1 : Create a VPC
resource "aws_vpc" "my_wp_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "My_WP_VPC"
  }
}