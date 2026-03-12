terraform {
  backend "s3" {
    bucket         = "terraform-state-siddu-1"
    key            = "Jenkins_Sonar_ArgoCD_K8s-t3.medium/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}