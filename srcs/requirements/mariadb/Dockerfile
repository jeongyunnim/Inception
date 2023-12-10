# syntax=docker/dockerfile:1

FROM alpine:3.18

RUN apk update && apk add --no-cache mysql mysql-client

RUN mkdir /var/run/mysqld && \
    chmod 755 /var/run/mysqld && \
    sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf &&\
    sed -i "s|.*skip-networking.*|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf

COPY tools/set.sh /home/

RUN chmod 755 /home/set.sh

ENTRYPOINT ["/bin/sh", "/home/set.sh"]
