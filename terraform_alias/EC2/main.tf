# EC2 Instance
resource "aws_instance" "mumbai_ec2" {
  provider                    = aws.mumbai
  ami                         = var.mumbai_ami_id
  instance_type               = var.mumbai_instance_type
  key_name                    = var.mumbai_key_name
  associate_public_ip_address = true

  tags = {
    Name = "mumbai-ec2"
  }
}

resource "aws_instance" "virginia_ec2" {
  provider                    = aws.virginia
  ami                         = var.virginia_ami_id
  instance_type               = var.virginia_instance_type
  key_name                    = var.virginia_key_name
  associate_public_ip_address = true

  tags = {
    Name = "virginia-ec2"
  }
}

resource "aws_instance" "virginia_manual_aws_ec2" {
  provider                    = aws.virginia
  ami                         = var.virginia_ami_id
  instance_type               = var.virginia_manual_instance_type
  key_name                    = var.virginia_key_name
  associate_public_ip_address = true

  tags = {
    Name = "virginia_manual_aws_ec2"
  }
}
