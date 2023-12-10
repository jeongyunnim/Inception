# syntax=docker/dockerfile:1

FROM alpine:3.18

RUN apk update &&\
    apk --no-cache add php \
    php-fpm \
    php-phar \
    php-curl \
    php-mysqli \
    php-mbstring \
    dumb-init

RUN sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/php81/php-fpm.d/www.conf

WORKDIR /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    php wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/set_wp_config_file.sh /var/www/html/set_wp_config_file.sh
COPY ./tools/install_wp.sh /var/www/html/install_wp.sh

RUN chmod 777 /var/www/html/set_wp_config_file.sh && \
    chmod 777 /var/www/html/install_wp.sh

EXPOSE 9000

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/bin/sh", "/var/www/html/install_wp.sh"]
