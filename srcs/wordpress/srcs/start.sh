

sed -i s/'DB_SERVER_ADDRESS'/"$DB_SERVER"/ /www/wp-config.php
sed -i s/'WP_DB_USER'/"$WP_DB_USER"/ /www/wp-config.php
sed -i s/'WP_DB_PASSWORD'/"$WP_DB_PASSWORD"/ /www/wp-config.php
php-fpm7
nginx
