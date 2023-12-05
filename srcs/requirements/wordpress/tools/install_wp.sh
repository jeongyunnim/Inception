# !bin/sh

/var/www/html/set_wp_config_file.sh

wp core download \
--locale=ko_KR \
--allow-root \
--path=$WP_PATH

wp core install \
--allow-root \
--path=${WP_PATH} \
--url=${WP_URL} \
--title=Inception \
--admin_user=${WP_DB_ADMIN} \
--admin_password=${WP_DB_ADMIN_PASSWORD} \
--admin_email=${WP_DB_ADMIN_EMAIL} \
--skip-email

wp user create ${WP_DB_USER} ${WP_DB_USER_EMAIL} \
--user_pass=${WP_DB_USER_PASSWORD} \
--role=author \
--allow-root && \

chmod -R 777 /var/www/html/wp-content

/usr/sbin/php-fpm81 -F