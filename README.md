# terraform-ansible-action-test

## 📝 概要
TerraformでAnsible実行環境を構築し、GitHub Actionsを用いて自動デプロイを行うリポジトリです。

Ansibleのハンズオンについては以下を参照ください
https://github.com/stsuda218/test-ansible

構築されるリソース一覧:

| リソース | 内容 |
|---|---|
| VPC | カスタムVPC |
| Subnet | Public / Private |
| Internet Gateway | Public Subnet向け |
| Route Table | ルーティング設定 |
| Security Group | アクセス制御 |
| EC2 | Ansible実行サーバ ×1（Public）<br>Webサーバ ×2（Private） |
| Application Load Balancer | Public ALB |
| Target Group | Private Webサーバを登録 |
| IAM Role | EC2インスタンスに付与 |

### 🛠 補足
- Ansible実行サーバには`userdata` による `suqid` のインストール
- Webサーバは `userdata` による `dnf.conf` 書き換えを実行
  
---

## 🚀 実行方法 (GitHub Actions)
1. GitHub Actions > 左ペインより **Terraform Apply/Destroy** を選択
2. 右側で **Run workflow** をクリック
3. 以下の値を入力して実行

| 入力項目 | 内容 |
|---|---|
| OIDC ARN | IAMで発行した OIDCのARN |
| 操作モード | `apply` または `destroy` |
| リソース名 | ユニークな名前（推奨：苗字） |
| VPC CIDR | `/24` でユニークな範囲（当日指定） |
| Public Subnet | JSON ArrayでCIDR指定 |
| Private Subnet | JSON ArrayでCIDR指定 |
| Your Global IP | 実行端末のグローバルIP |
| TF_STATE_BUCKET | tfstate格納用 S3バケット |
| TF_LOCK_TABLE | ロック用 DynamoDBテーブル名 |
| TF_STATE_KEY | `ユニーク名/terraform.tfstate` |

JSON Arrayの入力例:

```json
["10.0.1.0/28", "10.0.2.0/28"]
