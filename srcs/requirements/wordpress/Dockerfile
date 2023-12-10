FROM debian:oldstable
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    curl \
    gnupg \
    unzip \
    wget

# Ondřej SurýのPHPリポジトリを追加
RUN curl -fsSL https://packages.sury.org/php/apt.gpg | apt-key add - \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

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
      mkdir -p /var/www/html && \
      mkdir -p /run/php/ && \
      curl -o /tmp/wordpress.zip -SL https://wordpress.org/latest.zip && \
      unzip /tmp/wordpress.zip -d /var/www/html/ && \
      rm /tmp/wordpress.zip && \
      chown -R www-data:www-data /var/www/html/

# Download and install WordPress, chown www-dataに所有権変更
# Todo: wpはDLしておきたい。

# Configure php-fpm to listen on a socket
RUN sed -i -e 's/;listen.owner = www-data/listen.owner = www-data/' \
    -e 's/;listen.group = www-data/listen.group = www-data/' \
    -e 's/;listen.mode = 0660/listen.mode = 0660/' \
    -e 's/;listen = 127.0.0.1:9000/listen =　9000/' \
    /etc/php/8.2/fpm/pool.d/www.conf

# port設定はcompose.yml
#EXPOSE 9000

# Start php-fpm
CMD ["php-fpm8.2", "--nodaemonize"]
