terraform {
  backend "s3" {
    bucket         = "terraform-state-siddu-1"
    key            = "Jenkins-Terraform/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}