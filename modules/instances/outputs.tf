output "bastion_public_ip" {
  description = "Bastion public IPv4"
  value       = aws_instance.bastion.public_ip
}

output "bastion_public_dns" {
  description = "Bastion public DNS"
  value       = aws_instance.bastion.public_dns
}