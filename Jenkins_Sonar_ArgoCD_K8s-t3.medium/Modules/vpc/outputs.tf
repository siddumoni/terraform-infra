output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "pub_subnet_id" {
  value = aws_subnet.pub_subnet.id
}

output "sg_id" {
  value = aws_security_group.sg.id
}