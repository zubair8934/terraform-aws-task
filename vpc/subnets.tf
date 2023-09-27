#2: Create a public subnet 1
resource "aws_subnet" "us_east_1a_pub" {
  vpc_id                  = aws_vpc.my_wp_vpc.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "us_east_1a_pub"
  }
}

#3: Create a public subnet 2
resource "aws_subnet" "us_east_1b_pub" {
  vpc_id                  = aws_vpc.my_wp_vpc.id
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "us_east_1b_pub"
  }
}

#4 : create a private subnet 1
resource "aws_subnet" "us_east_1a_priv" {
  vpc_id                  = aws_vpc.my_wp_vpc.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "us_east_1a_priv"
  }
}

#5 : create a private subnet 2
resource "aws_subnet" "us_east_1b_priv" {
  vpc_id                  = aws_vpc.my_wp_vpc.id
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "us_east_1b_priv"
  }
}