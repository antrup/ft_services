#!/bin/sh

sed -i s/'DB_SERVER_ADDRESS'/"$DB_SERVER"/ /www/phpmyadmin/config.inc.php
sed -i s/'PMA_DB_USER'/"$PMA_DB_USER"/ /www/phpmyadmin/config.inc.php
sed -i s/'PMA_DB_PASSWORD'/"$PMA_DB_PASSWORD"/ /www/phpmyadmin/config.inc.php
sed -i s/'IP_PMA'/"$IP_PMA"/ /www/phpmyadmin/config.inc.php
php-fpm7
nginx
