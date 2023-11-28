# syntax=docker/dockerfile:1

FROM alpine:3.17

RUN apk update &&\
    apk add php-fpm &&\
    rm /var/cache/apk/*

WORKDIR /var/www/

RUN wget https://wordpress.org/latest.tar.gz &&\
    tar -xzvf latest.tar.gz &&\
    rm latest.tar.gz

COPY ./tools/wp-config.php /var/www/wordpress/wp-config.php

EXPOSE 3306

CMD ["/usr/sbin/php-fpm81"]
