terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.26.0"
    }
 }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "vm4" {
   ami           = "ami-0f5fcdfbd140e4ab7"
   instance_type = "t2.micro"

   tags = {
     Name = "vm4"
   }
}

resource "aws_instance" "vm5" {
   ami           = "ami-0f5fcdfbd140e4ab7"
   instance_type = "t2.micro"

   tags = {
     Name = "vm5"
   }
}