output "ec2_public_ip" {
  value = aws_instance.Jenkins.public_ip
}
