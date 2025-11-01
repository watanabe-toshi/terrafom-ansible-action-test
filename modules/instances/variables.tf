variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
}

variable "ami_id" {
  type        = string
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  description = "EC2インスタンスのタイプ"
}

variable "key_name" {
  type        = string
  description = "SSHキーペア名"
}

variable "public_subnet_id" {
  type        = string
  description = "ansible用のパブリックサブネットID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "config-manager・Webサーバ用のプライベートサブネットIDs（2つ）"
}

variable "web_sg_id" {
  type        = string
  description = "Webサーバに適用するセキュリティグループID"
}

variable "ansible_sg_id" {
  type        = string
  description = "ansible HostのセキュリティグループID"
}

variable "target_group_arn" {
  type        = string
  description = "ALBのターゲットグループARN"
}

variable "iam_instance_profile" {
  type = string
}