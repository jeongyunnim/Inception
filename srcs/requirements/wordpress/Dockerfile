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

COPY ./tools/set_wp_config_file.sh /var/www/html/set_wp_config_file.sh
COPY ./tools/install_wp.sh /var/www/html/install_wp.sh

RUN chmod +x /var/www/html/set_wp_config_file.sh && \
    chmod 777 /var/www/html/install_wp.sh && \
    /bin/sh /var/www/html/set_wp_config_file.sh

EXPOSE 9000

CMD ["sh", "/var/www/html/install_wp.sh"]
