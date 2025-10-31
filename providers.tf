terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # or "6.18.0" 固定
    }
  }
}

provider "aws" {
  region = var.aws_region
}
