#6 : create IGW
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_wp_vpc.id
  tags = {
    Name = "my_igw"
  }
}

#7 : route Tables for public subnet
resource "aws_route_table" "my_public_RT" {
  vpc_id = aws_vpc.my_wp_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "my_public_RT"
  }
}


#8 : route table association public subnet 1
resource "aws_route_table_association" "Public1RTAssociation" {
  subnet_id      = aws_subnet.us_east_1a_pub.id
  route_table_id = aws_route_table.my_public_RT.id
}

#9 : route table association public subnet 2
resource "aws_route_table_association" "Public2RTAssociation" {
  subnet_id      = aws_subnet.us_east_1b_pub.id
  route_table_id = aws_route_table.my_public_RT.id
}