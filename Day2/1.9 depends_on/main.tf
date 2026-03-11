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

# Create S3 buckets
resource "aws_s3_bucket" "terra-bucket" {
  for_each = {                                      
    "dev" = "siddu-bucket-ld"                       
    "uat" = "siddu-bucket-ld"                       
    "prod" = "siddu-bucket-LD"
  }

  bucket = "${each.key}-${each.value}-created"      
  tags = {
    Name        = "${each.key}-created"             
    Environment = "${each.key}"                     
  }
}

# Create VPC with depends_on meta argument
resource "aws_vpc" "terra-vpc" {
  cidr_block       = "10.0.0.0/22"
  instance_tenancy = "default"
  depends_on = [ aws_s3_bucket.terra-bucket ]    # vpc resource will be created only if all s3 buckets "aws_s3_bucket.terra-bucket" are created
  tags = {
    Name = "terra-vpc"
  }
}

# Create an IAM user with depends_on meta argument
resource "aws_iam_user" "myname" {
  name = "siddu"
  depends_on = [ aws_vpc.terra-vpc ]    # iam user will be created only if vpc resource is created 
  tags = {
    tag-key = "myname"
  }
}