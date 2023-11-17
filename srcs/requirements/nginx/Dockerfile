# syntax=docker/dockerfile:1

FROM alpine:3.17
RUN apk update && apk add nginx
COPY ./tools/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/default.conf /etc/nginx/http.d/default.conf
EXPOSE 80 443
# CMD ["nginx", "-g", "daemon off;"]
CMD ["sh"]