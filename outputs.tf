# ALB DNS確認用
# 以下コマンド
# terraform output alb_dns_name
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "bastion_public_ip" {
  description = "Bastion public IPv4"
  value       = module.instances.bastion_public_ip
}

output "bastion_public_dns" {
  description = "Bastion public DNS"
  value       = module.instances.bastion_public_dns
}
