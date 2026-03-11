# Terraform block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.12.0"
    }
  }
}

# Provider block
provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "terra-vpc" {
  cidr_block       = "10.0.0.0/17"  # for example, make changes in the CIDR block
  instance_tenancy = "default"
  lifecycle {                       # added lifecycle rule
    create_before_destroy = true    # it will create the new vpc with the changes and then destroy the old vpc
  }

  tags = {
    Name = "terra-vpc"
  }
}