variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "ALB にアタッチするサブネットのリスト（通常はパブリック）"
  type        = list(string)
}

variable "alb_security_group" {
  description = "ALBに関連付けるセキュリティグループID"
  type        = string
}