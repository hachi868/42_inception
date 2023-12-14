FROM debian:oldstable

# Nginxと必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y \
    adminer && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/usr/share/adminer"]
