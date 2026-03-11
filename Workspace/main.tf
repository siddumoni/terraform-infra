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

resource "aws_instance" "Server1" {
  ami           = "ami-0d1b5a8c13042c939"
  instance_type = terraform.workspace == "prod" ? "t3.medium" : "t2.micro"
  

  tags = {
    Name = "${terraform.workspace}-Server"
  }
}