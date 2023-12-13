#!/bin/bash

#until mariadb -h"${WORDPRESS_DB_HOST}" -u${MARIADB_USER} -p"${MARIADB_PASSWORD}" -e 'SELECT 1;' > /dev/null 2>&1; do
#    echo 'Waiting for the database server...'
#    sleep 1
#done

while ! mariadb -h"${WORDPRESS_DB_HOST}" -u"${MARIADB_USER}" -p"${MARIADB_PASSWORD}" "${MARIADB_DATABASE}" --silent; do
    echo 'Waiting for the database server...'
    sleep 1
done
#sudo -u www-data wp --info
# wp-config.php の作成
# shellcheck disable=SC2164
#cd /var/www/html/wordpress/
#pwd
#id www-data
#sudo -u www-data wp core check-update --path="/var/www/html/wordpress"

if [ ! -f "/var/www/html/wordpress/wp-config.php" ]; then
sudo -u www-data wp core download --locale=ja --path=/var/www/html/wordpress/
chmod -R 755 /var/www/html/wordpress/
# todo:cd,かつ--path指定しないと動かない
# shellcheck disable=SC2164
cd /var/www/html/wordpress/
echo "config run"
wp config create --path=/var/www/html/wordpress/ \
    --dbname="${MARIADB_DATABASE}" \
    --dbuser="${MARIADB_USER}" \
    --dbpass="${MARIADB_PASSWORD}" \
    --dbhost="${WORDPRESS_DB_HOST}" \
    --dbcharset="utf8mb4" \
    --dbcollate="utf8mb4_general_ci" \
    --allow-root

## WordPress データベースのインストール
wp core install --path=/var/www/html/wordpress/ \
    --url="${DOMAIN_NAME}" \
    --title="${WORDPRESS_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
    --skip-email \
    --allow-root
fi