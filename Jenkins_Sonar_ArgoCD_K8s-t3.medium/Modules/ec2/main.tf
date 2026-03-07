# ec2

resource "aws_instance" "Jenkins" {
  ami           = var.ami
  instance_type = var.instance_type
  region = var.region
  key_name = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.subnet_id

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name = "Jenkins"
  }
}