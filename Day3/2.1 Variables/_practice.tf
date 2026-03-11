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
  region = var.vpc_region
}


# Create VPC

resource "aws_vpc" "siddu-vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = "siddu-vpc"
  }
}


## Variables

variable "vpc_cidr_block" {
  description = "CIDR block"
  type = string
  default = "10.0.0.0/19"
}

variable "instance_tenancy" {
    description = "Instance Tenancy"
    type = string
    default = "default"
}

variable "vpc_region" {
    description = "VPC Region"
    type = string
    default = "us-east-2"
}