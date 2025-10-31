# ALB DNS確認用
# 以下コマンド
# terraform output alb_dns_name
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}