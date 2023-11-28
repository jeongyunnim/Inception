# syntax=docker/dockerfile:1

FROM alpine:3.17

RUN apk update && \
    apk add nginx && \
    apk add openssl && \
    adduser -D wordpress && \
    rm /var/cache/apk/*


WORKDIR /etc/ssl/private/
RUN openssl genrsa -out wp.key 2048 &&\
    openssl req -new -key wp.key -out wp.crt \
    -subj "/C=KR/ST=State/L=City/O=42seoul/OU=Organizational Unit/CN=Common Name" &&\
    openssl x509 -req -days 1000 -in wp.crt -signkey wp.key -out wp.crt

COPY ./tools/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/default.conf /etc/nginx/http.d/default.conf
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
# CMD ["sh"]