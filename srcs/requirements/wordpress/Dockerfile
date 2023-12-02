# syntax=docker/dockerfile:1

FROM alpine:3.17

RUN apk update &&\
    apk --no-cache add php php-fpm php-phar php-curl php-mysqli


RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/php81/php-fpm.d/www.conf

WORKDIR /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
    php wp-cli.phar &&\
    chmod +x wp-cli.phar &&\
    mv wp-cli.phar /usr/local/bin/wp

ADD ./tools/set_wp_config_file.sh /var/www/html/set_wp_config_file.sh
ADD ./tools/install_wp.sh /var/www/html/install_wp.sh

RUN chmod +x /var/www/html/set_wp_config_file.sh && \
    /bin/sh /var/www/html/set_wp_config_file.sh

RUN chmod +x /var/www/html/install_wp.sh && \
    /bin/sh /var/www/html/install_wp.sh

# RUN wp core download --locale=ko_KR --allow-root --path=/var/www/html
# RUN wp core install --allow-root \
#     --path=${WP_PATH} \
#     --url=${WP_URL} \
#     --title=Inception \
#     --admin_user=${WP_DB_ADMIN} \
#     --admin_password=${WP_DB_ADMIN_PASSWORD} \
#     --admin_email=${WP_DB_ADMIN_EMAIL} \
#     --skip-email
# RUN wp user create ${WP_DB_USER} ${WP_DB_USER_EMAIL} \
#     --user_pass=${WP_DB_USER_PASSWORD} \
#     --role=author \
#     --allow-root && \
#     chmod -R 777 /var/www/html/wp-content

# RUN echo "<?php phpinfo();?>" > /var/www/html/test.php

EXPOSE 9000

CMD ["/usr/sbin/php-fpm81", "-F"]
# CMD ["sh"]
