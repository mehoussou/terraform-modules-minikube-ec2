# Create a Kubernetes VPC
resource "aws_vpc" "k8s_vpc" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "Kubernetes VPC"
  }
}

# Create IGW for Kubernetes VPC
resource "aws_internet_gateway" "k8s_igw" {
  vpc_id = aws_vpc.k8s_vpc.id
  tags = {
    Name = "Kubernetes IGW"
  }
}

# Create a custom public Route Table for Kubernetes
resource "aws_route_table" "k8s_rt_public" {
  vpc_id = aws_vpc.k8s_vpc.id
  tags = {
    Name = "Kubernetes Public Route Table"
  }
}

# Create a custom private Route Table for Kubernetes
resource "aws_route_table" "k8s_rt_private" {
  vpc_id = aws_vpc.k8s_vpc.id
  tags = {
    Name = "Kubernetes Private Route Table"
  }
}

# Associate Kubernetes public Route Table with Kubernetes VPC
resource "aws_main_route_table_association" "k8s_rt_assoc" {
  vpc_id         = aws_vpc.k8s_vpc.id
  route_table_id = aws_route_table.k8s_rt_public.id
}

# Create route to Kubernetes IGW for public traffic
resource "aws_route" "k8s_route_to_igw" {
  route_table_id         = aws_route_table.k8s_rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.k8s_igw.id
}

# Create a public subnet in AZ a
resource "aws_subnet" "k8s_subnet_public_a" {
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = "172.16.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Kubernetes Public Subnet A"
  }
}

# Create a public subnet in AZ b
resource "aws_subnet" "k8s_subnet_public_b" {
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = "172.16.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Kubernetes Public Subnet B"
  }
}

# Create a public subnet in AZ c
resource "aws_subnet" "k8s_subnet_public_c" {
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = "172.16.2.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "Kubernetes Public Subnet C"
  }
}

# Create a private subnet in AZ a
resource "aws_subnet" "k8s_subnet_private_a" {
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = "172.16.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Kubernetes Private Subnet A"
  }
}

# Create a private subnet in AZ b
resource "aws_subnet" "k8s_subnet_private_b" {
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = "172.16.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Kubernetes Private Subnet B"
  }
}

# Create a public subnet in AZ f
resource "aws_subnet" "k8s_subnet_private_c" {
  vpc_id                  = aws_vpc.k8s_vpc.id
  cidr_block              = "172.16.5.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "Kubernetes Private Subnet C"
  }
}

# Associate Subnet A with Kubernetes public Route Table
resource "aws_route_table_association" "k8s_sn_rt_assoc_a" {
  subnet_id      = aws_subnet.k8s_subnet_public_a.id
  route_table_id = aws_route_table.k8s_rt_public.id
}

# Associate Subnet B with Kubernetes public Route Table
resource "aws_route_table_association" "k8s_sn_rt_assoc_b" {
  subnet_id      = aws_subnet.k8s_subnet_public_b.id
  route_table_id = aws_route_table.k8s_rt_public.id
}

# Associate Subnet C with Kubernetes public Route Table
resource "aws_route_table_association" "k8s_sn_rt_assoc_c" {
  subnet_id      = aws_subnet.k8s_subnet_public_c.id
  route_table_id = aws_route_table.k8s_rt_public.id
}

# Associate Subnet A with Kubernetes private Route Table
resource "aws_route_table_association" "k8s_sn_rt_pvt_assoc_a" {
  subnet_id      = aws_subnet.k8s_subnet_private_a.id
  route_table_id = aws_route_table.k8s_rt_private.id
}

# Associate Subnet E with Kubernetes private Route Table
resource "aws_route_table_association" "k8s_sn_rt_pvt_assoc_b" {
  subnet_id      = aws_subnet.k8s_subnet_private_b.id
  route_table_id = aws_route_table.k8s_rt_private.id
}

# Associate Subnet C with Kubernetes private Route Table
resource "aws_route_table_association" "k8s_sn_rt_pvt_assoc_c" {
  subnet_id      = aws_subnet.k8s_subnet_private_c.id
  route_table_id = aws_route_table.k8s_rt_private.id
}

# Create Kubernetes Security Group to allow HTTP traffic
resource "aws_security_group" "k8s_sg_http" {
  name        = "Kubernetes Allow HTTP"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.k8s_vpc.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Kubernetes Allow HTTP"
  }
}

# Create Kubernetes Security Group to allow SSH traffic
resource "aws_security_group" "k8s_sg_ssh" {
  name        = "Kubernetes Allow SSH"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.k8s_vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["24.8.139.111/32"]
  }

  egress {
    description = "All all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Kubernetes Allow SSH"
  }
}