# Main VPC Block
resource "aws_vpc" "MyVpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "MyVPC"
  }
}

# Public Subnet Block
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.MyVpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "subnet-1"
  }
}

# Private Subnet Block
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.MyVpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2a"
  tags = {
    Name = "subnet-2"
  }
}

# Internetgateway Block
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.MyVpc.id
  tags = {
    "Name" = "IG-1"
  }
}

resource "aws_route_table" "RT_1" {
  vpc_id = aws_vpc.MyVpc.id
  tags = {
    "Name" = "RT-1"
  }
}
resource "aws_route_table" "RT_2" {
  vpc_id = aws_vpc.MyVpc.id
  tags = {
    "Name" = "RT-2"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.RT_1.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.RT_2.id
}

# Internet getway Block
resource "aws_route" "route_igw" {
  route_table_id         = aws_route_table.RT_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IG.id
  depends_on             = [aws_route_table.RT_1]
}