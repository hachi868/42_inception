FROM debian:oldstable

#ARG DOMAIN_NAME

# Nginxと必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y \
    nginx \
    openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Nginxのデフォルト設定を削除
RUN rm /etc/nginx/sites-enabled/default

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh
ENTRYPOINT ["/usr/local/bin/setup.sh"]

# Nginxをフォアグラウンドで実行
CMD ["nginx", "-g", "daemon off;"]
