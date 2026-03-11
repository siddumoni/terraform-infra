output "vpc_id" {
  value = aws_vpc.vpc_module.id
}

output "vpc_security_group_ids" {
  value = aws_security_group.sg.id
}

output "public-id" {
  value = aws_subnet.public.id
}
