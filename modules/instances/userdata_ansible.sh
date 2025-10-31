#!/bin/bash
# システム更新
yum update -y

# EPELリポジトリ有効化（Amazon Linux 2）
amazon-linux-extras enable ansible2
yum install -y ansible

# バージョン確認ログ出力
ansible --version > /var/log/ansible-version.log

#botoインストール
yum install python-pip
pip install boto