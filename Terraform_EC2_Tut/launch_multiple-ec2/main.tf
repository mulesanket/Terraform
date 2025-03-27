//This file is used to declare the resources that will be created

resource "aws_instance" "demo-instance" { 

  for_each = {
    instance1 = "Server1"
    instance2 = "Server2"
    instance3 = "Server3"
  }

  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.instance_keypair
  
  tags = {
    Name = each.value
  }
}
