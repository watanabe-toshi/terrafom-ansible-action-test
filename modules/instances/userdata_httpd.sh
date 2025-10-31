#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "<h1>Apache Web Server running on $(hostname -f)</h1>" > /var/www/html/index.html
echo "ok" > /var/www/html/healthz