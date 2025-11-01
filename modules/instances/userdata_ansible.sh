#!/bin/bash
set -euo pipefail

# OS判定
. /etc/os-release || true
ID=${ID:-unknown}
VERSION_ID=${VERSION_ID:-unknown}

# パッケージマネージャ選択
if command -v dnf >/dev/null 2>&1; then
  PM="dnf"
else
  PM="yum"
fi

# システム更新
$PM -y update || true

# Ansible インストール（AL2 と AL2023 で分岐）
if [ "$ID" = "amzn" ] && [[ "$VERSION_ID" =~ ^2 ]]; then
  # Amazon Linux 2
  amazon-linux-extras enable ansible2 || true
  yum install -y ansible
else
  # Amazon Linux 2023 など
  # ansible か ansible-core のどちらかが入るように両方トライ
  dnf install -y ansible || dnf install -y ansible-core || true
fi

# プロキシ(squid)導入
$PM install -y squid

# 基本設定：deny all を無効化して allow all を追加（SGで外部からは塞ぐ前提）
SQUID_CONF="/etc/squid/squid.conf"
cp -a "$SQUID_CONF" "${SQUID_CONF}.bak.$(date +%s)"

# 既存の最終denyをコメントアウト
sed -i 's/^\s*http_access\s\+deny\s\+all/# &/' "$SQUID_CONF"
# allow all が無ければ追記
grep -q '^\s*http_access\s\+allow\s\+all' "$SQUID_CONF" || echo 'http_access allow all' >> "$SQUID_CONF"
# 念のためポートを明示
grep -q '^\s*http_port\s\+3128' "$SQUID_CONF" || echo 'http_port 3128' >> "$SQUID_CONF"

# 起動・自動起動
systemctl enable --now squid

# 目印
echo "squid ready on :3128" > /var/log/proxy-ready.log
