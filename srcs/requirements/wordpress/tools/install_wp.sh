# !bin/sh

if [ ! -f "/var/www/html/wp-config.php" ]; then

/var/www/html/set_wp_config_file.sh

wp core download \
--locale=ko_KR \
--allow-root \
--path=$WP_PATH

wp core install \
--allow-root \
--path=${WP_PATH} \
--url=${WP_URL} \
--title=Jeseo\'s_Inception \
--admin_user=${WP_ADMIN} \
--admin_password=${WP_ADMIN_PASSWORD} \
--admin_email=${WP_ADMIN_EMAIL} \
--skip-email

wp user create ${WP_USER} ${WP_USER_EMAIL} \
--user_pass=${WP_USER_PASSWORD} \
--role=author \
--allow-root && \

chmod -R 777 /var/www/html/wp-content
fi

/usr/sbin/php-fpm81 -F