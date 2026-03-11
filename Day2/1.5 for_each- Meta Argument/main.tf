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

# for_each meta argument
resource "aws_s3_bucket" "terra-bucket" {
  for_each = {                                      # Using for_each meta argument with key value pair as variable
    "dev" = "siddu-bucket-ld"                       # keys are "dev, uat & prod"
    "uat" = "siddu-bucket-ld"                       # values are "siddu-bucket-ld"
    "prod" = "siddu-bucket-ld"
  }

  bucket = "${each.key}-${each.value}-created"      # subtituting variables in the string >> dev-siddu-bucket-ld-created will be the bucket name
  tags = {
    Name        = "${each.key}-created"             # dev-created, uat-created, prod-created
    Environment = "${each.key}"                     # dev, uat, prod
  }
}