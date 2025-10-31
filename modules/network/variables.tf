variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "パブリックサブネットのCIDRブロック"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "プライベートサブネットのCIDRブロック"
  type        = list(string)
}

variable "availability_zones" {
  description = "使用するアベイラビリティゾーン（例: ap-northeast-1a, 1c）"
  type        = list(string)
}