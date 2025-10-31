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
  description = "Bastion用のパブリックサブネットID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "config-manager・Webサーバ用のプライベートサブネットIDs（2つ）"
}

variable "web_sg_id" {
  type        = string
  description = "Webサーバに適用するセキュリティグループID"
}

variable "bastion_sg_id" {
  type        = string
  description = "Bastion HostのセキュリティグループID"
}

variable "config_manager_sg_id" {
  type        = string
  description = "config-managerのセキュリティグループID"
}

variable "target_group_arn" {
  type        = string
  description = "ALBのターゲットグループARN"
}