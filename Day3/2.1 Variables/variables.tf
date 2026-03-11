## Variables

variable "aws_ec2_instance_region" {
  description = "Name of the EC2 region in AWS"
  type = string             # type can be string, number, boolean etc
  default = "us-east-2"     # default is the value we need to provide
}

variable "aws_ec2_instance_counts" {
    description = "Instance count"
    type = number
    default = 5
}

variable "aws_ec2_instance_type" {
    description = "Instance type"
    type = string
    default = "t2.micro"
}

variable "aws_ec2_ami_id" {
    description = "AMI ID"
    type = string
    default = "ami-0634f3c109dcdc659"
}