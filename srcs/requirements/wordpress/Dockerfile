FROM debian:oldstable
RUN apt-get update && \
    apt-get install -y \
    sudo \
    mariadb-client \
    software-properties-common \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    curl \
    gnupg \
    unzip \
    wget

# GPG 鍵のダウンロード
RUN curl -fsSL https://packages.sury.org/php/apt.gpg -o /usr/share/keyrings/php.gpg
# PHP リポジトリの追加
RUN echo "deb [signed-by=/usr/share/keyrings/php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
    php8.2 \
    php8.2-fpm \
    php8.2-mysqli \
    php8.2-curl \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/www/html/wordpress/ && \
    mkdir -p /var/www/.wp-cli/cache/ && \
    mkdir -p /var/run/php/ && \
    # -o: 指定ファイルパスに保存 -S: エラー時詳細ログ -L: リダイレクト先にアクセス
#    curl -o /tmp/wordpress.zip -SL https://wordpress.org/latest.zip && \
#    # -d: 指定ディレクトリに展開
#    unzip /tmp/wordpress.zip -d /var/www/html/ && \
#    rm /tmp/wordpress.zip && \
    # 所有権変更 `(ユーザー名):` ユーザー名,グループ名を同じ名で設定 todo: root実行にしたのでいらないかも。
    chown -R www-data: /var/www/ && \
    chmod -R +x /var/www/ && \
    chown -R www-data: /var/run/php/ && \
    chmod -R +x /var/run/php/ && \
    curl -o /tmp/wp-cli.phar -SL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /tmp/wp-cli.phar && \
    mv /tmp/wp-cli.phar /usr/local/bin/wp

# Download and install WordPress, chown www-dataに所有権変更

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

# port設定はcompose.yml
#EXPOSE 9000

ENTRYPOINT ["sh", "/usr/local/bin/setup.sh"]

# Start php-fpm
# todo: php-fpm.confとの関係確認
CMD ["/usr/sbin/php-fpm8.2", "--nodaemonize"]
