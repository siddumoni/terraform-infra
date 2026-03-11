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

# Count meta argument
resource "aws_vpc" "new-vpc" {
  cidr_block       = "10.0.0.0/21"
  instance_tenancy = "default"
  count = 4

  tags = {
    Name = "new-vpc-${count.index}"
  }
}

/*

How it works >>>

    1. count = 4: tells Terraform to create 4 separate VPCs instead of one.

    2. Tags: each VPC gets a unique Name based on its index (0–3):

        VPC 0 → Name = new-vpc-0

        VPC 1 → Name = new-vpc-1

        VPC 2 → Name = new-vpc-2

        VPC 3 → Name = new-vpc-3
*/