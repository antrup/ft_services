FROM alpine:latest

ENV PMA_DB_PASSWORD='password' \
PMA_DB_USER='pma' \
WP_DB_PASSWORD='password' \
WP_DB_USER='wordpress_user' \
TG_DB_PASSWORD='password' \
ROOT_DB_PASSWORD='password'


RUN apk update \
&& apk add mariadb mariadb-client 

ADD srcs srcs

RUN mkdir /run/mysqld \
&& chown -R mysql:mysql /run/mysqld \
&& sed -i "s/skip-networking/#skip-networking/"  /etc/my.cnf.d/mariadb-server.cnf \
&& sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf \
&& chmod +x srcs/init.sh

ENTRYPOINT ["srcs/init.sh"]

EXPOSE 3306

VOLUME ["/var/lib/mysql"]
