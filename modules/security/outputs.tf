output "ec2_sg_id" {
  value       = aws_security_group.ec2.id
  description = "Security Group ID for EC2"
}

output "ansible_sg_id" {
  value       = aws_security_group.ansible.id
  description = "Security Group ID for Ansible"
}

output "alb_sg_id" {
  value       = try(aws_security_group.alb[0].id, null)
  description = "Security Group ID for ALB (nullable)"
}
