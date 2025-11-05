variable "vpc_id" {
  type = string
}

variable "ec2_sg_name" {
  type    = string
  default = "ec2"
}

variable "ansible_sg_name" {
  type    = string
  default = "ansible"
}

variable "create_alb_sg" {
  type    = bool
  default = true
}

variable "alb_sg_name" {
  type    = string
  default = "alb"
}
