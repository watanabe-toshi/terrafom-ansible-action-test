variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "allowed_ip" {
  type = string
}