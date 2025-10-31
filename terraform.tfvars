###以下の変数を個別で設定していきます
#固有のリソース名
project_name = "watanababy"

#同一のアカウント内で複数作成する場合CIDRを変える
vpc_cidr              = "10.0.0.0/24"
public_subnet_cidrs   = ["10.0.0.0/28", "10.0.0.16/28"]
private_subnet_cidrs  = ["10.0.0.32/28", "10.0.0.48/28"]

# 接続元のグローバルIPを/32で入力
allowed_ip   = "11.22.333.444/32"
###ここまで###

key_name     = "my-key"
ami_id       = "ami-095af7cb7ddb447ef" 
availability_zones    = ["ap-northeast-1a", "ap-northeast-1c"]
service_name          = "com.amazonaws.ap-northeast-1.s3"