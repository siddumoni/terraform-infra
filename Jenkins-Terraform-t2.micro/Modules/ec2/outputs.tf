output "ec2_public_ip" {
  value = aws_instance.Jenkins.public_ip
}

output "ec2_public_ip-Slave" {
  value = aws_instance.Slave.public_ip
}