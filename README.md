# terrafom-ansible-action-test

## 概要
ansible実行環境をTerraformで構築し、Github-actionsでデプロイするためのソース

作成されるリソースは以下
VPC

subnet(pub/pri)

InternetGateWay

RouteTable

EC2→Ansible実行サーバ1台(pub) Webサーバ2台(pri)

※Ansible実行サーバにはsuqidのインストール

webサーバにはdnf.confの書き換えをuserdataで実行

SecurituGroup

ApplicationLoadBalancer

TargetGroup

## 実行方法
Actions→画面左ペインより Terraform Apply/Destroyを選択

画面右ペイン　Run workflowを選択　

それぞれ以下を入力

OIDCのARNを記述

個別で連携

apply or destroyのどちらかを選択

作成時はapply

削除時はdestroy

ユニークなリソース名を記述

他と被らない命名(苗字推奨)

VPCのアドレスレンジを記述

他と被らない範囲で/24で(当日連携)

パブリックのサブネットをJSON arrayで

アドレスレンジをJSONの範囲指定で

プライベートのサブネットをJSON arrayで

アドレスレンジをJSONの範囲指定で

端末のグローバルIPを記述

実行元のグローバルIP

TF_STATE_BUCKET: tfstateの保管先のS3を指定

個別で連携

TF_LOCK_TABLE: tfstateの保管先のDynamoDBテーブル名を指定

個別で連携

TF_STATE_KEY: tfstateキーを入力

ユニークな名前/terraform.tfstate

上記を入力し Run Workflowを選択
