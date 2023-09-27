# Creating Nat Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.us_east_1a_pub.id
  depends_on    = [aws_internet_gateway.my_igw]

  tags = {
    Name = "my_nat_gw"
  }
}

# Add routes for VPC
resource "aws_route_table" "my_private_RT" {
  vpc_id = aws_vpc.my_wp_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gw.id
  }

  tags = {
    Name = "my_private_RT"
  }
}

# Creating route associations for private Subnets
resource "aws_route_table_association" "Private1RTAssociation" {
  subnet_id      = aws_subnet.us_east_1a_priv.id
  route_table_id = aws_route_table.my_private_RT.id
}

resource "aws_route_table_association" "Private2RTAssociation" {
  subnet_id      = aws_subnet.us_east_1b_priv.id
  route_table_id = aws_route_table.my_private_RT.id
}
