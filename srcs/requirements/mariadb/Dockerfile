# syntax=docker/dockerfile:1

FROM alpine:3.17

ENV MYSQL_ROOT_PASSWORD=rootwordpress
ENV MYSQL_PASSWORD=wordpress
ENV MYSQL_DATABASE=wp_db
ENV MYSQL_USER=wordpress_user

RUN apk --no-cache update && apk add mysql mysql-client

RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf &&\
    sed -i "s|.*skip-networking.*|skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

COPY tools/wordpress_setup.sql /home/
# RUN /etc/init.d/mariadb setup &&\
#     mysql -u root < /home/wordpress_setup.sql

COPY tools/set.sh /home/

RUN chmod 755 /home/set.sh

EXPOSE 3306

CMD ["sh", "/home/set.sh"]
# CMD ["mysqld", "-u", "mysql"]
# CMD ["sh"]