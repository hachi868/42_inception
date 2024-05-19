#!/bin/bash

if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

start_server() {
  # MariaDBサーバー起動（フォアグラウンド）
  mysqld

  # MariaDBサーバーが起動するまで待つ(max30秒)
  timeout=30
  timewait=0
  while ! mysqladmin ping -h localhost --silent; do
    sleep 1
    ((timewait++))

    if [ "${timewait}" -ge "${timeout}" ]; then
      echo "MariaDB server did not start within ${timeout} seconds."
      # MariaDBプロセスを探し出して終了
      pkill -f mysqld
      exit 1
    fi
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

# 初期化が必要かチェックするため、起動=>DB確認、必要なら初期化=>shutdown
start_server()

# データベースが存在しない場合にのみ初期設定を実行
if ! mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "use ${MARIADB_DATABASE}"; then
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS "${MARIADB_DATABASE}";
    CREATE USER IF NOT EXISTS "${MARIADB_USER}"@"%" IDENTIFIED BY "${MARIADB_PASSWORD}";
    GRANT ALL PRIVILEGES ON "${MARIADB_DATABASE}".* TO "${MARIADB_USER}"@"%";
    FLUSH PRIVILEGES;
  EOSQL
fi

shutdown_server()

exec "$@"