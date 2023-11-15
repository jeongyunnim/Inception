# syntax=docker/dockerfile:1

FROM alpine:3.17
RUN apk update && apk add nginx
COPY ./tools/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80 443
CMD ["nginx"]