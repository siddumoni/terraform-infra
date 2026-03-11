terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.24.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# 1. vpc

resource "aws_vpc" "vpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${var.client_name}-vpc1"
  }
}
# 2. igw

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${var.client_name}-igw1"
  }
}
# 3. public subnet

resource "aws_subnet" "pub_sub1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "${var.client_name}-pub_sub1"
  }
}
# 4. private subnet

resource "aws_subnet" "pri_sub1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "${var.client_name}-pri_sub1"
  }
}
# 5. public rt

resource "aws_route_table" "pub_rt1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "${var.client_name}-pub_rt1"
  }
}
# 6. private rt

resource "aws_route_table" "pri_rt1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "${var.client_name}-pri_rt1"
  }
}
# 7. public rt assoc

resource "aws_route_table_association" "pub_rt1_assoc" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.pub_rt1.id
}
# 8. private rt assoc

resource "aws_route_table_association" "pri_rt1_assoc" {
  subnet_id      = aws_subnet.pri_sub1.id
  route_table_id = aws_route_table.pri_rt1.id
}
# 9. security group

resource "aws_security_group" "sg1" {
  name        = "sg1"
  description = "Allow SG1 inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc1.id

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
    cidr_blocks      = ["192.168.1.5/32", aws_vpc.vpc1.cidr_block]
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
    Name = "${var.client_name}-sg1"
  }
}
# 10. web server

resource "aws_instance" "webserver1" {
  ami           = var.ec2_ami_id # Replace with a valid AMI ID for your region
  region        = var.region
  instance_type = var.aws_instance_type
  key_name      = var.key_name # Replace with an existing key pair name
  subnet_id     = aws_subnet.pub_sub1.id
  vpc_security_group_ids = [aws_security_group.sg1.id]
  associate_public_ip_address = true

  
  tags = {
    Name = "${var.client_name}-webserver1"
  }
}
# 11. db server

resource "aws_instance" "dbserver1" {
  ami           = var.ec2_ami_id # Replace with a valid AMI ID for your region
  region        = var.region
  instance_type = var.aws_instance_type
  key_name      = var.key_name # Replace with an existing key pair name
  subnet_id     = aws_subnet.pri_sub1.id
  vpc_security_group_ids = [aws_security_group.sg1.id]
  
  tags = {
    Name = "${var.client_name}-dbserver1"
  }
}
# 12. outputs

output "web_publicip" {
  value = aws_instance.webserver1.public_ip
}

output "web_privateip" {
  value = aws_instance.webserver1.private_ip
}

output "db_privateip" {
  value = aws_instance.dbserver1.private_ip
}

