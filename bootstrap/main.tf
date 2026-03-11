terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0"
    }
  }
}

# ─────────────────────────────────────────
# S3 BUCKET
# ─────────────────────────────────────────

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  # Prevents accidental deletion of the bucket
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.environment
    ManagedBy   = "Terraform Bootstrap"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Lifecycle rule — auto delete old state versions after 90 days
resource "aws_s3_bucket_lifecycle_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}

# ─────────────────────────────────────────
# DYNAMODB TABLE
# ─────────────────────────────────────────

resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"  # No capacity planning needed
  hash_key     = "LockID"           # Must be exactly "LockID"

  attribute {
    name = "LockID"
    type = "S"  # String type
  }

  # Prevents accidental deletion of the lock table
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "Terraform State Lock"
    Environment = var.environment
    ManagedBy   = "Terraform Bootstrap"
  }
}
