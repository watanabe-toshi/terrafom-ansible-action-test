module "network" {
  source               = "./modules/network"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "vpce_s3" {
  source          = "./modules/vpc_endpoints/s3"
  project_name    = var.project_name
  vpc_id          = module.network.vpc_id
  route_table_ids = module.network.private_route_table_ids
  service_name    = var.service_name
}

module "security" { 
  source               = "./modules/security" 
  project_name         = var.project_name
  vpc_id               = module.network.vpc_id 
  allowed_ip           = var.allowed_ip 
  }

module "alb" {
  source               = "./modules/alb"
  project_name         = var.project_name
  vpc_id               = module.network.vpc_id
  subnet_ids           = module.network.public_subnet_ids
  alb_security_group   = module.security.alb_sg_id
}

module "instances" {
  source                = "./modules/instances"
  project_name          = var.project_name
  ami_id                = var.ami_id
  instance_type         = "t3.micro"
  key_name              = var.key_name
  public_subnet_id      = module.network.public_subnet_ids[0]
  private_subnet_ids    = module.network.private_subnet_ids
  web_sg_id             = module.security.ec2_sg_id
  bastion_sg_id         = module.security.bastion_sg_id
  config_manager_sg_id  = module.security.config_manager_sg_id
  target_group_arn      = module.alb.target_group_arn
}