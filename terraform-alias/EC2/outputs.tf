output "mumbai_instance_public_ip" {
  value = aws_instance.mumbai_ec2.public_ip
}

output "virginia_instance_public_ip" {
  value = aws_instance.virginia_ec2.public_ip
}