terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

# vpc module

module "vpc_module" {
  source = "./Modules/vpc_module"

  vpc_cidr_block = "10.0.0.0/16"
  public_cidr_block = "10.0.1.0/24"
  
}

module "ec2_module" {
  source            = "./Modules/ec2_module"
  ami               = "ami-0d1b5a8c13042c939"
  instance_type     = "t2.micro"
  subnet_id         = module.vpc_module.public-id
  key_name          = "vm2"
  security_group_ids = [module.vpc_module.vpc_security_group_ids]
  
}

output "ec2_public_ip" {
  value = module.ec2_module.public_ip
}