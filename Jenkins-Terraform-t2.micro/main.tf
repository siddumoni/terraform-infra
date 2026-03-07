terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

# vpc module

module "vpc" {
  source = "./Modules/vpc/"

  vpc_cidr_block = "10.0.0.0/16"
  pri_subnet_cidr_block = "10.0.2.0/24"
  pub_subnet_cidr_block  = "10.0.1.0/24"

}

# ec2 module

module "ec2" {
  source = "./Modules/ec2/"

  ami = "ami-02774d409be696d81"
  instance_type = "t2.micro"
  region = "ap-south-2"
  key_name = "mainkey"
  subnet_id = module.vpc.pub_subnet_id
  security_group_id = module.vpc.sg_id

}

output "ec2_public_ip" {
  value = module.ec2.ec2_public_ip
}
