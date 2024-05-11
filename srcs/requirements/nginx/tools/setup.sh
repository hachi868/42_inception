#!/bin/bash

# define
SSL_DIR="/etc/nginx/ssl"
KEY_FILE="${SSL_DIR}/inception42.key"
CERT_FILE="${SSL_DIR}/inception42.crt"

# SSL証明書と秘密鍵の保存先ディレクトリがなければ作成
mkdir -p "${SSL_DIR}"

# 証明書


# 証明書がなければ作成
if [ ! -f "${KEY_FILE}" ] || [ ! -f "${CERT_FILE}" ]; then
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
      -keyout /etc/nginx/ssl/inception42.key \
      -out /etc/nginx/ssl/inception42.crt \
      -subj "/C=JP/ST=Tokyo/L=city/O=42tokyo/CN=${DOMAIN_NAME}"
fi
exec "$@"