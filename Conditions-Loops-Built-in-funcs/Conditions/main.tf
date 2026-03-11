#########################################################
# 🔧 Terraform + AWS Provider Version Lock
#########################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"     # Pin version to avoid future breaking changes
    }
  }
}

#########################################################
# 🌍 Provider Configuration (Which AWS region to use)
#########################################################
provider "aws" {
  region = "us-east-2"       # Ohio Region
}

#########################################################
# 🎛️ Environment Variable (Controls instance sizing)
# 👉 Value can be: dev / uat / prod (based on how we set it)
#########################################################
variable "environment" {
  default = "uat"            # Current choice. Try changing to "dev" or "prod"
}

#########################################################
# 🧠 Conditional Logic Explanation (Ternary Operator)
#
# ➤ Syntax:
#       condition ? value_if_true : value_if_false
#
# ➤ Example:
#       var.environment == "dev" ? "t2.micro" : "t3.medium"
#
# ✔ If environment = dev → use t2.micro
# ✖ If not dev → use t3.medium
#########################################################

#########################################################
# 🖥️ EC2 Instance Created Based on Environment
# - Instance size changes automatically using the condition
#########################################################
resource "aws_instance" "cond-server1" {
  ami = "ami-0d1b5a8c13042c939"

  # 🏷️ Conditional EC2 sizing
  instance_type = var.environment == "dev" ? "t2.micro" : "t3.medium"

  # 🧩 Another way (optional):
  # instance_type = var.environment == "dev" ? "t2.micro" : var.environment == "uat" ? "t3.micro" : "t3.medium"
        #    If environment = dev, use t2.micro
        #      else if environment = uat, use t3.micro
        #         else use t3.medium (maybe for prod)

  tags = {
    Name        = "cond-server1"
    Environment = "${var.environment}-terraform"
  }
}
