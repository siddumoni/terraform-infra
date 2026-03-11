# Terraform block
terraform {
  required_version = "~> 1.13.3"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.11.0"
    }
  }
}

# VERSION & PROVIDER CONSTRAINT #

/* How it works >>>

required_version:
    1. This enforces that the Terraform CLI you’re using must be 1.13.1 exactly.
    2. If you try running with 1.13.0 or 1.14.x, Terraform will fail with a version mismatch
    3. Same way, we can use multiple operators like !=, >, >=, <, <= and ~>

operator syntax:
    required_version = "!= 1.13.1"
    required_version = "> 1.13.1"
    required_version = ">= 1.13.1"
    required_provider = "< 1.13.1"
    required_provider = "<= 1.13.1"
    required_provider = "~> 1.13.1"
        Allows only the right-most version component to increment. Examples:
        ~> 1.0.4: Allows Terraform to install 1.0.5 and 1.0.10 but not 1.1.0.
        ~> 1.1: Allows Terraform to install 1.2 and 1.10 but not 2.0 */