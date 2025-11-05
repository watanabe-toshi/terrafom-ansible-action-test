module "network" {
  source               = "./modules/network"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "security" {
  source = "./modules/security"

  vpc_id          = module.network.vpc_id
  ec2_sg_name     = "ec2"
  ansible_sg_name = "ansible"

  create_alb_sg = var.enable_alb   # ← ここをフラグに
  alb_sg_name   = "alb"
}

# --- ここから「ルール」を分離 ---

# 自端末 -> Ansible に SSH(22) を許可
resource "aws_vpc_security_group_ingress_rule" "ec2_from_ansible_ssh" {
  security_group_id            = module.security.ansible_sg_id
  cidr_ipv4                    = var.allowed_ip
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22
  description                  = "SSH from Ansible SG"
}

# Ansible -> Web Server に SSH(22) を許可
resource "aws_vpc_security_group_ingress_rule" "ec2_from_ansible_ssh" {
  security_group_id            = module.security.ec2_sg_id
  referenced_security_group_id = module.security.ansible_sg_id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22
  description                  = "SSH from Ansible SG"
}

# Web Server -> Ansible に 3128 を許可（必要な場合のみ）
resource "aws_vpc_security_group_ingress_rule" "ansible_from_ec2_proxy" {
  security_group_id            = module.security.ansible_sg_id
  referenced_security_group_id = module.security.ec2_sg_id
  ip_protocol                  = "tcp"
  from_port                    = 3128
  to_port                      = 3128
  description                  = "3128 from EC2 SG"
}

# ALB -> Web Server に HTTP(80) を許可
resource "aws_vpc_security_group_ingress_rule" "ec2_from_alb_http" {
  count                        = var.enable_alb ? 1 : 0   # ← module出力依存をやめる
  security_group_id            = module.security.ec2_sg_id
  referenced_security_group_id = module.security.alb_sg_id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  description                  = "HTTP from ALB SG"
}


module "alb" {
  source             = "./modules/alb"
  project_name       = var.project_name
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.public_subnet_ids
  alb_security_group = module.security.alb_sg_id
}

module "instances" {
  source               = "./modules/instances"
  project_name         = var.project_name
  ami_id               = var.ami_id
  instance_type        = "t3.micro"
  key_name             = var.key_name
  public_subnet_id     = module.network.public_subnet_ids[0]
  private_subnet_ids   = module.network.private_subnet_ids
  web_sg_id            = module.security.ec2_sg_id
  ansible_sg_id        = module.security.ansible_sg_id
  target_group_arn     = module.alb.target_group_arn
  iam_instance_profile = module.iam_role.instance_profile_name
}

module "iam_role" {
  source    = "./modules/iam_role"
  role_name = "${var.project_name}-ansible-role"
}