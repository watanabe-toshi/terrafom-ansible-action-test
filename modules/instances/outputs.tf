output "bastion_public_ip" {
  description = "Bastion server public IPv4"
  value       = aws_instance.bastion.public_ip
}

# ついでにあると便利
output "bastion_public_dns" {
  description = "Bastion public DNS"
  value       = aws_instance.bastion.public_dns
}
