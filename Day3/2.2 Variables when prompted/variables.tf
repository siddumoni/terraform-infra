## Variables

variable "aws_ec2_instance_region" {
  description = "Name of the EC2 region in AWS"
  type = string
  #default = "us-east-2"               # If we dont include default, then terraform will prompt for the value during runtime
}

variable "aws_ec2_instance_count" {
    description = "Instance count"
    type = number
    #default = 2
}

variable "aws_ec2_instance_type" {
    description = "Instance type"
    type = string
    #default = "t2.micro"
}

variable "aws_ec2_ami_id" {
    description = "AMI ID"
    type = string
    #default = "ami-0634f3c109dcdc659"
}