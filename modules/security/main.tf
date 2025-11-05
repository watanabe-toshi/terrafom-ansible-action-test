# SG本体だけ作る（インラインの相互参照ルールはNG）
resource "aws_security_group" "ec2" {
  name        = var.ec2_sg_name
  description = "EC2 SG"
  vpc_id      = var.vpc_id

  # 必要ならデフォルトegressを開放（好みで調整）
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }
}

resource "aws_security_group" "ansible" {
  name        = var.ansible_sg_name
  description = "Ansible SG"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }
}

# （使っていれば）ALB用
resource "aws_security_group" "alb" {
  count       = var.create_alb_sg ? 1 : 0
  name        = var.alb_sg_name
  description = "ALB SG"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }
}
