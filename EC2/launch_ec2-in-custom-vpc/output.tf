//This file is used to declare the output values that will be displayed after the resources are created

output "vpc_id" {
  value = aws_vpc.mymumbai_vpc.id
}

output "subnet_id" {
  value = aws_subnet.mymumbai_subnet.id
}

output "instance_public_ip" {
  value = aws_instance.my_mumbai_instance.public_ip
}

output "instance_private_ip" {
  value = aws_instance.my_mumbai_instance.private_ip
}

output "instance_id" {
  value = aws_instance.my_mumbai_instance.id
}


