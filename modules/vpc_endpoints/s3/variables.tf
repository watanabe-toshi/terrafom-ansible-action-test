variable "project_name" {
  type        = string
  description = "リソース名 prefix"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "route_table_ids" {
  type        = list(string)
  description = "紐づけるルートテーブルID（通常は private）"
}

variable "service_name" {
  type        = string
  description = "S3 VPCE の service name (例: com.amazonaws.ap-northeast-1.s3)"
}

