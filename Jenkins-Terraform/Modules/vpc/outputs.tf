output "vpc_id" {
  value = aws_vpc.Jenkins-vpc.id
}

output "pub_subnet_id" {
  value = aws_subnet.Jenkins-pub_subnet.id
}

output "sg_id" {
  value = aws_security_group.Jenkins-sg.id
}