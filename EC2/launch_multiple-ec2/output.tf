//This file is used to declare the output values that will be displayed after the resources are created

output "instance_id" {
  value = [for instance in aws_instance.demo-instance : instance.id] 
}

output "instance_public_ip" {
  value = [for instance in aws_instance.demo-instance : instance.public_ip] 
}
