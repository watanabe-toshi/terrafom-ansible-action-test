#!/bin/bash
set -euo pipefail

# 1) アップデート
dnf -y update

# 2) Ansible（AL2023は ansible か ansible-core）
dnf install -y ansible || dnf install -y ansible-core

# 3) squid を導入
dnf install -y squid

# 4) squid を最小設定
SQUID_CONF="/etc/squid/squid.conf"
cp -a "$SQUID_CONF" "${SQUID_CONF}.bak.$(date +%s)"

# 最終denyをコメントアウトして allow を入れる（SGで外部からは遮断する前提）
sed -i 's/^\s*http_access\s\+deny\s\+all/# &/' "$SQUID_CONF"
grep -q '^\s*http_access\s\+allow\s\+all' "$SQUID_CONF" || echo 'http_access allow all' >> "$SQUID_CONF"
grep -q '^\s*http_port\s\+3128' "$SQUID_CONF" || echo 'http_port 3128' >> "$SQUID_CONF"

systemctl enable --now squid
echo "squid ready on :3128" > /var/log/proxy-ready.log
