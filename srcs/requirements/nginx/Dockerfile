# syntax=docker/dockerfile:1

FROM alpine:3.18

ARG SSL_PATH=/etc/ssl/private

RUN apk update && \
    apk --no-cache add nginx \
    openssl \
    dumb-init && \
    adduser -D jeseo

RUN openssl genrsa -out ${SSL_PATH}/jeseo.42.fr.key 2048 && \
    openssl req -new -key ${SSL_PATH}/jeseo.42.fr.key -out ${SSL_PATH}/jeseo.42.fr.crt \
    -subj "/C=KR/ST=Seoul/L=Gaepodong/O=42seoul/OU=Cadet/CN=jeseo.42.kr" && \
    openssl x509 -req -days 1000 -in ${SSL_PATH}/jeseo.42.fr.crt -signkey ${SSL_PATH}/jeseo.42.fr.key -out ${SSL_PATH}/jeseo.42.fr.crt && \
    chown -R nginx ${SSL_PATH}

WORKDIR /var/www/html

COPY ./tools/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/default.conf /etc/nginx/http.d/default.conf

EXPOSE 80 443
ENTRYPOINT ["/usr/bin/dumb-init", "--", "nginx", "-g", "daemon off;"]