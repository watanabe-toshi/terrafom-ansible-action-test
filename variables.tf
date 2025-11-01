variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ap-northeast-1"
}

# リソース名
variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
}

# SSHキーペア名（EC2全体で使う）
variable "key_name" {
  description = "EC2インスタンスで使用するSSHキーペア名"
  type        = string
}

# 自宅や会社など、許可するグローバルIP
variable "allowed_ip" {
  description = "許可されたグローバルIP"
  type        = string
}

# 使用するAMI（Amazon Linux 2など）
variable "ami_id" {
  description = "使用するAMIのID"
  type        = string
}

# VPCとサブネット構成
variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "パブリックサブネットのCIDRブロック一覧"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "プライベートサブネットのCIDRブロック一覧"
  type        = list(string)
}

variable "availability_zones" {
  description = "使用するAZの一覧（例: ap-northeast-1a など）"
  type        = list(string)
}

# EC2タイプ（必要に応じて変数化）
variable "instance_type" {
  description = "インスタンスのタイプ（例: t3.micro）"
  type        = string
  default     = "t3.micro"
}
