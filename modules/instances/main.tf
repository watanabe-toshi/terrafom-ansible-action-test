# Web server 1
resource "aws_instance" "web1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[0]
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name
  user_data_replace_on_change = true

  tags = { 
    Name  = "web-${var.project_name}-01" 
    Group = "Web"
    Owner = var.project_name
  }
}

# Web server 2
resource "aws_instance" "web2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[1]
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name
  user_data_replace_on_change = true

  tags = { 
    Name  = "web-${var.project_name}-02" 
    Group = "Web"
    Owner = var.project_name
  }
}

# ALBへのターゲット登録
resource "aws_lb_target_group_attachment" "web1" {
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web2" {
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.web2.id
  port             = 80
}

# Ansible Host
resource "aws_instance" "ansible" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.ansible_sg_id]
  key_name                    = var.key_name
  user_data                   = file("${path.module}/userdata_ansible.sh")
  user_data_replace_on_change = true
  iam_instance_profile        = var.iam_instance_profile

  tags = { 
    Name = "${var.project_name}-ansible" 
    Group = "Ansible"
    Owner = var.project_name
    }
}