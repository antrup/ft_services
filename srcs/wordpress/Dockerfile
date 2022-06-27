FROM alpine:latest

RUN apk update \
&& apk add nginx php7 php7-cli php7-phar php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-session

ADD srcs srcs

ENV PHP_FPM_USER="www" \
PHP_FPM_GROUP="www" \
PHP_FPM_LISTEN_MODE="0660" \
PHP_MEMORY_LIMIT="512M" \
PHP_MAX_UPLOAD="50M" \
PHP_MAX_FILE_UPLOAD="200" \
PHP_MAX_POST="100M" \
PHP_DISPLAY_ERRORS="On" \
PHP_DISPLAY_STARTUP_ERRORS="On" \
PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR" \
PHP_CGI_FIX_PATHINFO=0 \
DB_SERVER='localhost' \
WP_DB_USER='wordpress_user' \
WP_DB_PASSWORD='password'

RUN adduser -D -g $PHP_FPM_USER $PHP_FPM_GROUP \
&& mkdir /www \
&& chown -R $PHP_FPM_USER:$PHP_FPM_GROUP /var/lib/nginx \
&& chown -R $PHP_FPM_USER:$PHP_FPM_GROUP /www

RUN wget https://wordpress.org/latest.tar.gz \
&& tar xvf latest.tar.gz \
&& mv wordpress/* /www \
&& cp srcs/wp-config.php /www 

RUN mkdir /etc/nginx/ssl \
&& cp srcs/toni-serv.42.pem /etc/nginx/ssl \
&& cp srcs/toni-serv.42.np.key /etc/nginx/ssl

RUN cp srcs/nginx.conf /etc/nginx \
&& sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf \
&& sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf \
&& sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.d/www.conf \
&& sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf \
&& sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf \
&& sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.d/www.conf #uncommenting line \
&& sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php7/php.ini \
&& sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php7/php.ini \
&& sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php7/php.ini \
&& sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini \
&& sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php7/php.ini \
&& sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini \
&& sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini \
&& sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php7/php.ini

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp

EXPOSE 5050
EXPOSE 9090

ENTRYPOINT chmod +x /srcs/start.sh \
&& /srcs/start.sh
