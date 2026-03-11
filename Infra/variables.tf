# variable block

variable "region" {
  default = "us-east-2"
}

variable "aws_instance_type" {
  default = "t2.micro"
}

variable "client_name" {
  default = "devops"
}

variable "ec2_ami_id" {
    default = "ami-0d1b5a8c13042c939"
}

variable "key_name" {
  default = "mainkey"
}
