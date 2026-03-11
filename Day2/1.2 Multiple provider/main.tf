# Terraform block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.11.0"
    }
  }
}

# Provider 1
provider "aws" {
  region = "us-east-2"
  alias = "east-2"
}

resource "aws_vpc" "East-2-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  provider = aws.east-2

  tags = {
    Name = "East-2-VPC"
  }
}

# Provider  2
provider "aws" {
  region = "us-east-1"
  alias = "east-1"
}

resource "aws_vpc" "East-1-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  provider = aws.east-1

  tags = {
    Name = "East-1-VPC"
  }
}

/* How it works >>>

    1. Configures two AWS providers with aliases
        aws.east-2 → points to region us-east-2 (Ohio).
        aws.east-1 → points to region us-east-1 (N. Virginia).

    2. Creates a VPC in us-east-2
        Managed via the aws.east-2 provider.

    3. Creates a VPC in us-east-1
        Managed via the aws.east-1 provider.
*/