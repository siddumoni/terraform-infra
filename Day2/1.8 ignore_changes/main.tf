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
  cidr_block       = "10.0.0.0/22"
  instance_tenancy = "default"

  lifecycle {                   # adding lifecycle rule
    ignore_changes = [ tags ]   # Tells Terraform: “If someone changes tags in the AWS console, don’t treat that as drift.”     
                                # This prevents Terraform from trying to reapply tags on every terraform plan/apply
  }

  tags = {
    Name = "terra-vpc"
  }
}