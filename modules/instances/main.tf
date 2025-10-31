# Webサーバ1
resource "aws_instance" "web1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[0]
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name
  user_data              = file("${path.module}/userdata_httpd.sh")
  user_data_replace_on_change = true

  tags = { Name = "${var.project_name}-web-server-1" }
}

# Webサーバ2
resource "aws_instance" "web2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[1]
  vpc_security_group_ids = [var.web_sg_id]
  key_name               = var.key_name
  user_data              = file("${path.module}/userdata_httpd.sh")
  user_data_replace_on_change = true

  tags = { Name = "${var.project_name}-web-server-2" }
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

# Bastion Host
resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.bastion_sg_id]
  key_name                    = var.key_name

  tags = { Name = "${var.project_name}-bastion-host" }
}

# config-manager（Ansible）
resource "aws_instance" "config_manager" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_ids[0]
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.config_manager_sg_id]
  key_name                    = var.key_name
  user_data              = file("${path.module}/userdata_ansible.sh")
  user_data_replace_on_change = true

  tags = { Name = "${var.project_name}-config-manager" }
}