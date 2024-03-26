#!/bin/bash

if [ ! -d "/etc/nginx/ssl/inception42.crt" ]; then
  echo "make crt"
  # SSL証明書と秘密鍵を保存するディレクトリを作成
  mkdir -p /etc/nginx/ssl

  # 自己署名SSL証明書と秘密鍵を生成
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
      -keyout /etc/nginx/ssl/inception42.key \
      -out /etc/nginx/ssl/inception42.crt \
      -subj "/C=JP/ST=Tokyo/L=city/O=42tokyo/CN=$DOMAIN_NAME"
fi
echo "make crt done"
exec "$@"