//This is Terraform 

provider "aws" {
  region = "ap-south-1"
}

provider "vault" {
  address          = "http://3.108.44.4:8200"
}

data "vault_kv_secret_v2" "awsdata" {
  mount = "kv"
  name  = "aws-credentials"
}

resource "aws_instance" "vault-instance" {
  ami           = "0e35ddab05955cf57"
  instance_type = "t2.micro"
  tags = {
    Secret = data.vault_kv_secret_v2.awsdata.data["username"]
  }
}