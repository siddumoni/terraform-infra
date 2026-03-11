# Terraform block

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.24.0"
    }
  }
}

# Provider block

provider "aws" {
  region = "us-east-2"
}

# Outputs the public IP of the EC2 instance created by this configuration
    # we have put [*] because instance count is 2 in the variables.tf file.

output "ec2_publicip" {
  value = aws_instance.new-ec2[*].public_ip
}

# Outputs the EC2 instance ID for reference or downstream automation

output "ec2_instanceid" {
  value = aws_instance.new-ec2[*].id
}
