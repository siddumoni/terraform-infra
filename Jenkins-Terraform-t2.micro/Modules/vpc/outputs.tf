output "vpc_id" {
  value = aws_vpc.t2-micro-vpc.id
}

output "pub_subnet_id" {
  value = aws_subnet.t2-micro-pub_subnet.id
}

output "sg_id" {
  value = aws_security_group.t2-micro-sg.id
}