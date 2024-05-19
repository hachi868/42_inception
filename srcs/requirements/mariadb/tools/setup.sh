#!/bin/bash

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

echo "/// 0"

start_server() {
  echo "/// start_server 0"
  # MariaDBプロセスをバックグラウンドで起動
  mysqld &
  echo "/// start_server 1"

  # MariaDBサーバーが起動するまで待つ(max30秒)
  timeout=30
  timewait=0
  echo "/// start_server 2"
  while ! mysqladmin ping -h localhost --silent; do
    sleep 1
    ((timewait++))
    echo "/// timewait ${timewait}"
    if [ "${timewait}" -ge "${timeout}" ]; then
      echo "MariaDB server did not start within ${timeout} seconds."
      # MariaDBプロセスを探し出して終了
      pkill -f mysqld
      exit 1
    fi
    echo "MariaDB end if"
  done

  echo "MariaDB server started successfully."
}

shutdown_server() {
  mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

  # コマンドの実行結果を検証
  if [ $? -eq 0 ]; then
    echo "MariaDB has been stopped successfully."
  else
    echo "Failed to stop MariaDB."
    exit 1
  fi
}


echo "/// 1"

start_server

echo "/// 2"

# データベースが存在しない場合にのみ初期設定を実行
if ! mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "use ${MARIADB_DATABASE}"; then
  echo "/// init"
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
    CREATE USER IF NOT EXISTS ${MARIADB_USER}@'%' IDENTIFIED BY ${MARIADB_PASSWORD};
    GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO ${MARIADB_USER}@'%';
    FLUSH PRIVILEGES;
EOSQL
else
  echo "/// not init"
fi

if ! mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "use ${MARIADB_DATABASE}"; then
  echo "Database ${MARIADB_DATABASE} created successfully."
else
  echo "Failed to create database ${MARIADB_DATABASE}."
fi

echo "/// 3"

shutdown_server

echo "/// 4"

# Dockerfile CMDでフォアグラウンド起動
exec "$@"
