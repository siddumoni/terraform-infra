# Create EC2 instance

resource "aws_instance" "new-ec2" {
  ami           = var.aws_ec2_ami_id        # Here we are using var.value for describing the varibales
  instance_type = var.aws_ec2_instance_type
  count = var.aws_ec2_instance_count

  tags = {
    Name = "new-ec2"
  }
}