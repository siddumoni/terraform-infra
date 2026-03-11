##############################################
# Terraform Backend Configuration (S3)
# - Stores the terraform.tfstate file remotely in S3.
# - Enables state locking, versioning, and team collaboration.
# - This backend block affects Terraform itself, not AWS resources.
# - No resources reference this; Terraform uses it internally.
##############################################
terraform {
  backend "s3" {
    bucket       = "my-org-terraform-state"
    key          = "envs/prod/us-east-2/terraform.tfstate"  # per-env/per-region key
    region       = "us-east-2"
    encrypt      = true
    # use_lockfile enables S3-native locking (Terraform 1.11+). 
    # Optionally use dynamodb_table = "tf-lock-table" if you prefer DynamoDB locking.
    use_lockfile = true
    #dynamodb_table = "tf-lock-table"
    #kms_key_id = "arn:aws:kms:..."  # optional: force SSE-KMS encryption
  }
}

