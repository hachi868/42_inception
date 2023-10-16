FROM debian:oldstable
RUN apt-get update && apt-get install -y nginx

# Nginxの設定ファイルをカスタマイズ（必要に応じて）
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# Nginxをバックグラウンドで実行
CMD ["nginx", "-g", "daemon off;"]