# ALB DNS確認用
# 以下コマンド
# terraform output alb_dns_name
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "bastion_public_ip" {
  description = "Bastion server public IPv4"
  value       = aws_instance.bastion.public_ip
}

output "bastion_public_dns" {
  description = "Bastion public DNS"
  value       = aws_instance.bastion.public_dns
}
