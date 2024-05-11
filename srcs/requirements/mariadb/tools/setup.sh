#!/bin/bash

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

# MariaDBサーバーをバックグラウンドで起動
mysqld &

# MariaDBサーバーが起動するまで待つ
while ! mysqladmin ping -h localhost --silent; do
  sleep 1
done

# データベースが存在しない場合にのみ初期設定を実行
if ! mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "use ${MARIADB_DATABASE}"; then
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
  CREATE DATABASE IF NOT EXISTS "${MARIADB_DATABASE}";
  CREATE USER IF NOT EXISTS "${MARIADB_USER}"@"%" IDENTIFIED BY "${MARIADB_PASSWORD}";
  GRANT ALL PRIVILEGES ON "${MARIADB_DATABASE}".* TO "${MARIADB_USER}"@"%";
  FLUSH PRIVILEGES;
EOSQL
fi

# フォアグラウンドでサーバーを維持する
wait $!
