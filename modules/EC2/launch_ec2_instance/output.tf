//This file is used to declare the output values that will be displayed after the resources are created

output "instance_id" {
  value = aws_instance.MyEC2Instance.id
}

output "instance_public_ip" {
  value = aws_instance.MyEC2Instance.public_ip
}

output "instance_private_ip" {
  value = aws_instance.MyEC2Instance.private_ip
}