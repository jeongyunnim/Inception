# syntax=docker/dockerfile:1

FROM alpine:3.17

RUN apk update && \
    apk --no-cache add nginx \
    openssl && \
    adduser -D wordpress

WORKDIR /etc/ssl/private/
RUN openssl genrsa -out jeseo.42.fr.key 2048 &&\
    openssl req -new -key jeseo.42.fr.key -out jeseo.42.fr.crt \
    -subj "/C=KR/ST=Seoul/L=Gaepodong/O=42seoul/OU=Cadet/CN=jeseo.42.kr" &&\
    openssl x509 -req -days 1000 -in jeseo.42.fr.crt -signkey jeseo.42.fr.key -out jeseo.42.fr.crt
RUN mkdir -p /var/www/html

COPY ./tools/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/default.conf /etc/nginx/http.d/default.conf
COPY ./tools/index.html /var/www/html/

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
# CMD ["sh"]