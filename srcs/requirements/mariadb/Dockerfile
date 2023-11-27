# syntax=docker/dockerfile:1

FROM alpine:3.17
RUN apk update && apk add mysql mysql-client &&\
    rm /var/cache/apk/*

RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf &&\
    sed -i "s|.*skip-networking.*|skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

COPY tools/wordpress_setup.sql /home/

# RUN /etc/init.d/mariadb setup &&\
#     mysql -u root < /home/wordpress_setup.sql

# ADD tools/run.sh /scripts/run.sh
# RUN mkdir /docker-entrypoint-initdb.d && \
#     mkdir /scripts/pre-exec.d && \
#     mkdir /scripts/pre-init.d && \
#     chmod -R 755 /scripts

EXPOSE 3306

CMD ["sh"]