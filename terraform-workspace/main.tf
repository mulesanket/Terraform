module "network" {
  source     = "./modules/network"
  project    = var.project
  env        = local.env
  cidr_block = "10.${local.env == "prod" ? 0 : local.env == "staging" ? 20 : 40}.0.0/16"
}

module "ec2" {
  source          = "./modules/ec2"
  project         = var.project
  env             = local.env
  vpc_id          = module.network.vpc_id
  public_subnet_id= module.network.public_subnets[0]
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  ssh_key_name    = var.project  
}

module "rds" {  
  source             = "./modules/rds"
  project            = var.project
  env                = local.env
  private_subnet_ids = module.network.private_subnets
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_size   = var.db_instance_size
  db_engine          = var.db_engine
  db_engine_ver      = var.db_engine_ver
}
