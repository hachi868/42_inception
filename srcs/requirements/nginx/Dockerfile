FROM debian:oldstable

# Nginxと必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y \
    nginx \
    openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Nginxのデフォルト設定を削除
#RUN rm /etc/nginx/sites-enabled/default

# SSL証明書と秘密鍵のディレクトリを作成
RUN mkdir -p /etc/nginx/ssl

# 仮の自己署名証明書と秘密鍵を生成（本番環境では適切な証明書を使用する）
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=JP/ST=Tokyo/L=city/O=42tokyo/CN=$DOMAIN_NAME" \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt

# ポート443を公開
EXPOSE 443

# Nginxをフォアグラウンドで実行
CMD ["nginx", "-g", "daemon off;"]
