output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "ansible_sg_id" {
  value = aws_security_group.ansible_sg.id
}
