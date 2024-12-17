#VPC
resource "aws_vpc" "three_tier_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "three_tier_vpc"
  }
}

#public Subnets
#Web_tier
resource "aws_subnet" "pub_sub_1" {
  vpc_id                  = aws_vpc.three_tier_vpc.id
  cidr_block              = "10.0.0.0/28"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub_sub_1"
  }
}
resource "aws_subnet" "pub_sub_2" {
  vpc_id                  = aws_vpc.three_tier_vpc.id
  cidr_block              = "10.0.0.16/28"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub_sub_2"
  }
}


#Private Subnets
#App_tier
resource "aws_subnet" "privat_sub_1" {
  vpc_id                  = aws_vpc.three_tier_vpc.id
  cidr_block              = "10.0.0.32/28"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "privat_sub_1"
  }
}
resource "aws_subnet" "privat_sub_2" {
  vpc_id                  = aws_vpc.three_tier_vpc.id
  cidr_block              = "10.0.0.48/28"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "privat_sub_2"
  }
}

#Database_tier
resource "aws_subnet" "privat_sub_3" {
  vpc_id                  = aws_vpc.three_tier_vpc.id
  cidr_block              = "10.0.0.64/28"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "privat_sub_3"
  }
}
resource "aws_subnet" "privat_sub_4" {
  vpc_id                  = aws_vpc.three_tier_vpc.id
  cidr_block              = "10.0.0.80/28"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "privat_sub_4"
  }
}


#Internet Gateway
resource "aws_internet_gateway" "three_tier_IG" {
  tags = {
    Name = "three_tier_IG"
  }
  vpc_id = aws_vpc.three_tier_vpc.id
}

#NAT Gateway
resource "aws_nat_gateway" "three_tier_nat_gateway_01" {
  allocation_id = aws_eip.three_tier_nat_eip.id
  subnet_id     = aws_subnet.pub_sub_1.id
  tags = {
    Name = "three_tier_nat_gateway_01"
  }
  depends_on = [aws_internet_gateway.three_tier_IG]
}


#Route Table

#Web_tier Route Table
resource "aws_route_table" "three_tier_web_RT" {
  vpc_id = aws_vpc.three_tier_vpc.id
  tags = {
    Name = "three_tier_web_RT"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three_tier_IG.id
  }
}

#App_tier Route Table
resource "aws_route_table" "three_tier_app_RT" {
  vpc_id = aws_vpc.three_tier_vpc.id
  tags = {
    Name = "three_tier_app_RT"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.three_tier_nat_gateway_01.id
  }
}

#Route table associatiation

#Route to public subnets
resource "aws_route_table_association" "three_tier_web_RT_pub_sub_1" {
  subnet_id      = aws_subnet.pub_sub_1.id
  route_table_id = aws_route_table.three_tier_web_RT.id
}
resource "aws_route_table_association" "three_tier_web_RT_pub_sub_2" {
  subnet_id      = aws_subnet.pub_sub_2.id
  route_table_id = aws_route_table.three_tier_web_RT.id
}

#Route to private subnets
resource "aws_route_table_association" "three_tier_app_RT_private_sub_1" {
  subnet_id      = aws_subnet.privat_sub_1.id
  route_table_id = aws_route_table.three_tier_app_RT.id
}
resource "aws_route_table_association" "three_tier_app_RT_private_sub_2" {
  subnet_id      = aws_subnet.privat_sub_2.id
  route_table_id = aws_route_table.three_tier_app_RT.id
}
resource "aws_route_table_association" "three_tier_app_RT_private_sub_3" {
  subnet_id      = aws_subnet.privat_sub_3.id
  route_table_id = aws_route_table.three_tier_app_RT.id
}
resource "aws_route_table_association" "three_tier_app_RT_private_sub_4" {
  subnet_id      = aws_subnet.privat_sub_4.id
  route_table_id = aws_route_table.three_tier_app_RT.id
}


#Create Elastic Id For Nat Gateway
resource "aws_eip" "three_tier_nat_eip" {
  tags = {
    Name = "three_tier_nat_eip"
  }
}
