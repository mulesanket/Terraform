variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type     = string
  sensitive = true
}

variable "db_instance_size" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_engine_ver" {
  type = string
}
