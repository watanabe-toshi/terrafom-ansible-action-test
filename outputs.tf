output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ansible_public_ip" {
  description = "ansible public IPv4"
  value       = module.instances.ansible_public_ip
}

output "ansible_public_dns" {
  description = "ansible public DNS"
  value       = module.instances.ansible_public_dns
}
