#!/bin/bash

# sleep 8

# download wp-cli : a command-line tool for managing wordpress installations 
curl -LO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

mkdir -p /var/www/html
chown -R www-data:www-data /var/www/
chmod -R 755 /var/www/
chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp
# download wordpress 
cd /var/www/html
wp core download --allow-root --path=/var/www/html

# apt install zip -y
# cd /var/www/
# wget https://wordpress.org/latest.tar.gz
# tar -xzvf latest.tar.gz
# mv wordpress/* /var/www/html/
# rm -rf latest.tar.gz wordpress 
# mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
# cd /var/www/html
# wp config set SERVER_PORT 3306 --allow-root
# wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/
# wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/
# wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/
# wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/


#configure wordpress
mv wp-config-sample.php wp-config.php 
curl -s https://api.wordpress.org/secret-key/1.1/salt/
sed -i 's#listen = /run/php/php7.3-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/7.3/fpm/pool.d/www.conf

wp config set SERVER_PORT 3306 --allow-root

wp config set DB_NAME $MYSQL_DATABASE --allow-root
wp config set DB_USER $MYSQL_USER --allow-root
wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root
wp config set DB_HOST 'mariadb' --allow-root

# INSTALL WORDPRESS 
wp core install --url=$DOMAIN_NAME --locale=en_US --title=$SITE_TITLE --admin_user=$WPADMIN_USER --admin_password=$WPADMIN_PASSWORD --admin_email=$WPADMIN_EMAIL --allow-root
wp user create $WPUSER $WPUSER_EMAIL --role=author --user_pass=$WPUSER_PASSWORD --allow-root

exec "$@"
