## Creates a public route table
resource "aws_route_table" "my_public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = aws_vpc.my_vpc.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "luqman-tf-public-rtb"
  }

}

## Creates a private route table for az1
resource "aws_route_table" "my_private_route_table_az1" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = aws_vpc.my_vpc.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "luqman-tf-private-rtb-az1"
  }

}

## Creates a private route table for az2
resource "aws_route_table" "my_private_route_table_az2" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = aws_vpc.my_vpc.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "luqman-tf-private-rtb-az2"
  }

}

## Associate public route table to first and second public subnet
resource "aws_route_table_association" "first_public_assoc" {
  subnet_id      = aws_subnet.my_public_subnet_az1.id
  route_table_id = aws_route_table.my_public_route_table.id
}

resource "aws_route_table_association" "second_public_assoc" {
  subnet_id      = aws_subnet.my_public_subnet_az2.id
  route_table_id = aws_route_table.my_public_route_table.id
}

## Associate private route table to the private subnets accordingly
resource "aws_route_table_association" "first_private_assoc" {
  subnet_id      = aws_subnet.my_private_subnet_az1.id
  route_table_id = aws_route_table.my_private_route_table_az1.id
}

resource "aws_route_table_association" "second_private_assoc" {
  subnet_id      = aws_subnet.my_private_subnet_az2.id
  route_table_id = aws_route_table.my_private_route_table_az2.id
}