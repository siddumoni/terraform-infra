resource "aws_vpc" "vpc_module" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "vpc_module"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_module.id

  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc_module.id
  cidr_block = var.public_cidr_block

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_module.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow SG inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_module.id

 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["192.168.1.2/32", aws_vpc.vpc_module.cidr_block]
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
   tags = {
    Name = "sg"
  }
}

