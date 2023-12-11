#todo: DB接続確認

# wp-config.php の作成
wp config create --path=/var/www/html \
    --dbname="${MARIADB_DATABASE}" \
    --dbuser="${MARIADB_USER}" \
    --dbpass="${MARIADB_PASSWORD}" \
    --dbhost="${WORDPRESS_DB_HOST}" \
    --dbcharset="utf8mb4" \
    --dbcollate="utf8mb4_general_ci"

# WordPress データベースのインストール
wp core install --path=/var/www/html \
    --url="${DOMAIN_NAME}" \
    --title="${WORDPRESS_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}"