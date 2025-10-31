output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "config_manager_sg_id" {
  value = aws_security_group.config_manager_sg.id
}
