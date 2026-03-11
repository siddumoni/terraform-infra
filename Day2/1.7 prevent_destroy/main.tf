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
    prevent_destroy = true          # prevent_destroy will prevent terraform from destroying the resource.
  }

  tags = {
    Name = "terra-vpc"
  }
}