# Terraform block

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}

# Provider block

provider "aws" {
  region = var.aws_ec2_instance_region
}