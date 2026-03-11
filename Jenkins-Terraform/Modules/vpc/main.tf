# vpc 

resource "aws_vpc" "Jenkins-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "Jenkins-vpc"
  }
}

# public subnet

resource "aws_subnet" "Jenkins-pub_subnet" {
  vpc_id     = aws_vpc.Jenkins-vpc.id
  cidr_block = var.pub_subnet_cidr_block

  tags = {
    Name = "Jenkins-pub_subnet"
  }
}

# private subnet

resource "aws_subnet" "Jenkins-pri_subnet" {
  vpc_id     = aws_vpc.Jenkins-vpc.id
  cidr_block = var.pri_subnet_cidr_block

  tags = {
    Name = "Jenkins-pri_subnet"
  }
}

# igw

resource "aws_internet_gateway" "Jenkins-igw" {
  vpc_id = aws_vpc.Jenkins-vpc.id

  tags = {
    Name = "Jenkins-igw"
  }
}

# public rt

resource "aws_route_table" "Jenkins-public_rt" {
  vpc_id = aws_vpc.Jenkins-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Jenkins-igw.id
  }

  tags = {
    Name = "Jenkins-public_rt"
  }
}

# public rt assoc

resource "aws_route_table_association" "Jenkins-public_rt_assoc" {
  subnet_id      = aws_subnet.Jenkins-pub_subnet.id
  route_table_id = aws_route_table.Jenkins-public_rt.id
}

# security group

resource "aws_security_group" "Jenkins-sg" {
  name        = "SG"
  description = "Allow SG inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Jenkins-vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {                         # for jenkins
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {                         # for sonarqube
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # ✅ Allow ICMP (ping) within same SG
  ingress {
    description = "ICMP within SG"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    self        = true
  }

  tags = {
    Name = "Jenkins-sg"
  }
}
