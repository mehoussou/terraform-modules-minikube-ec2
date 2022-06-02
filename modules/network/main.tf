# Create a Custom VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env} VPC"
  }
}

# Create IGW for Custom VPC
resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "${var.env} IGW"
  }
}

# Create a custom public Route Table 
resource "aws_route_table" "custom_rt_public" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "${var.env} Public Route Table"
  }
}

# Create a custom private Route Table
resource "aws_route_table" "custom_rt_private" {
  vpc_id = aws_vpc.custom_vpc.id
  tags = {
    Name = "${var.env} Private Route Table"
  }
}

# Associate custom public Route Table with custom VPC
resource "aws_main_route_table_association" "custom_rt_assoc" {
  vpc_id         = aws_vpc.custom_vpc.id
  route_table_id = aws_route_table.custom_rt_public.id
}

# Create route to custom IGW for public traffic
resource "aws_route" "custom_route_to_igw" {
  route_table_id         = aws_route_table.custom_rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.custom_igw.id
}

# Create a public subnet in AZ a
resource "aws_subnet" "custom_subnet_public_a" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public-subnet-cidr-a
  availability_zone       = var.az-a
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env} Public Subnet A"
  }
}

# Create a public subnet in AZ b
resource "aws_subnet" "custom_subnet_public_b" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public-subnet-cidr-b
  availability_zone       = var.az-b
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env} Public Subnet B"
  }
}

# Create a public subnet in AZ c
resource "aws_subnet" "custom_subnet_public_c" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public-subnet-cidr-c
  availability_zone       = var.az-c
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env} Public Subnet C"
  }
}

# Create a private subnet in AZ a
resource "aws_subnet" "custom_subnet_private_a" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.private-subnet-cidr-a
  availability_zone       = var.az-a
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env} Private Subnet A"
  }
}

# Create a private subnet in AZ b
resource "aws_subnet" "custom_subnet_private_b" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.private-subnet-cidr-b
  availability_zone       = var.az-b
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env} Private Subnet B"
  }
}

# Create a public subnet in AZ f
resource "aws_subnet" "custom_subnet_private_c" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.private-subnet-cidr-c
  availability_zone       = var.az-c
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env} Private Subnet C"
  }
}

# Associate Subnet A with custom public Route Table
resource "aws_route_table_association" "custom_sn_rt_assoc_a" {
  subnet_id      = aws_subnet.custom_subnet_public_a.id
  route_table_id = aws_route_table.custom_rt_public.id
}

# Associate Subnet B with custom public Route Table
resource "aws_route_table_association" "custom_sn_rt_assoc_b" {
  subnet_id      = aws_subnet.custom_subnet_public_b.id
  route_table_id = aws_route_table.custom_rt_public.id
}

# Associate Subnet C with custom public Route Table
resource "aws_route_table_association" "custom_sn_rt_assoc_c" {
  subnet_id      = aws_subnet.custom_subnet_public_c.id
  route_table_id = aws_route_table.custom_rt_public.id
}

# Associate Subnet A with custom private Route Table
resource "aws_route_table_association" "custom_sn_rt_pvt_assoc_a" {
  subnet_id      = aws_subnet.custom_subnet_private_a.id
  route_table_id = aws_route_table.custom_rt_private.id
}

# Associate Subnet B with custom private Route Table
resource "aws_route_table_association" "custom_sn_rt_pvt_assoc_b" {
  subnet_id      = aws_subnet.custom_subnet_private_b.id
  route_table_id = aws_route_table.custom_rt_private.id
}

# Associate Subnet C with custom private Route Table
resource "aws_route_table_association" "custom_sn_rt_pvt_assoc_c" {
  subnet_id      = aws_subnet.custom_subnet_private_c.id
  route_table_id = aws_route_table.custom_rt_private.id
}

output "custom_vpc_id" {
  value = aws_vpc.custom_vpc.id
}