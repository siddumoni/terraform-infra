variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
  default     = "terraform-state-siddu-1"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "terraform-lock"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "shared"
}