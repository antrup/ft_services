#!/bin/sh
	
if [ ! -d /var/lib/mysql/mysql ]; then
	echo "Mariadb configuration in progress ..."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql >> /dev/null
	nohup mysqld --user=mysql >/dev/null 2>&1 &
	sleep 10
	sed -i s/'PMA_DB_PASSWORD'/"$PMA_DB_PASSWORD"/ /srcs/create_pa_tables.sql
	sed -i s/'PMA_DB_USER'/"$PMA_DB_USER"/ /srcs/create_pa_tables.sql
	sed -i s/'WP_DB_PASSWORD'/"$WP_DB_PASSWORD"/ /srcs/create_wp_tables.sql
	sed -i s/'WP_DB_USER'/"$WP_DB_USER"/ /srcs/create_wp_tables.sql
	sed -i s/'TG_DB_PASSWORD'/"$TG_DB_PASSWORD"/ /srcs/secure_init.sql
	sed -i s/'ROOT_DB_PASSWORD'/"$ROOT_DB_PASSWORD"/ /srcs/secure_init.sql
	mariadb < /srcs/create_pa_tables.sql
	mariadb < /srcs/create_wp_tables.sql
	mariadb < /srcs/secure_init.sql
	kill $!
	sleep 5
	echo "Mariadb configuration done"
fi

mysqld --user=mysql
