terraform {
  backend "s3" {
    bucket         = "terraform-state-siddu-1"
    key            = "Jenkins-Terraform-t2.micro/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}