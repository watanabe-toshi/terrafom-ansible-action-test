output "ansible_public_ip" {
  description = "ansible public IPv4"
  value       = aws_instance.ansible.public_ip
}

output "ansible_public_dns" {
  description = "ansible public DNS"
  value       = aws_instance.ansible.public_dns
}