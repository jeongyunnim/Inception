# syntax=docker/dockerfile:1

FROM alpine:3.17

RUN apk update &&\
    apk add php php-fpm php-phar php-curl php-mysqli &&\
    rm /var/cache/apk/*

WORKDIR /var/www/

RUN wget https://wordpress.org/latest.tar.gz &&\
    tar -xzvf latest.tar.gz &&\
    rm latest.tar.gz

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
    php wp-cli.phar &&\
    chmod +x wp-cli.phar &&\
    mv wp-cli.phar /usr/local/bin/wp

RUN wp core download --locale=ko_KR --allow-root --path=/var/www/html

COPY ./tools/wp-config.php /var/www/wordpress/wp-config.php

EXPOSE 9000

CMD ["sh", ""]
