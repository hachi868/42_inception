#!/bin/bash

# SSL証明書と秘密鍵の保存先ディレクトリがなければ作成
mkdir -p /etc/nginx/ssl

# 証明書がなければ作成
if [ ! -f "/etc/nginx/ssl/inception42.crt" ]; then
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
      -keyout /etc/nginx/ssl/inception42.key \
      -out /etc/nginx/ssl/inception42.crt \
      -subj "/C=JP/ST=Tokyo/L=city/O=42tokyo/CN=$DOMAIN_NAME"
fi
exec "$@"