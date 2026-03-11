terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.25.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "siddu1" {
  ami           = "ami-0d1b5a8c13042c939"
  instance_type = "t2.micro"
  ebs_block_device {
    device_name = "/dev/sda1"
    delete_on_termination = true
    volume_size = 8
  }

  tags = {
    Name = "siddu1"
  }
}

# resource "aws_vpc" "vpc1" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"

#   tags = {
#     Name = "siddu-vpc1"
#   }
# }