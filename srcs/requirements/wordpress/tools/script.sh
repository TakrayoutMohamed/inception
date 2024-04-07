#!/bin/bash

# sleep 7

sed -i 's/listen =.*/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf
mkdir  -p /var/www/html/wordpress
cd /var/www/html/wordpress
# download wp-cli : a command-line tool for managing wordpress installations 
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#make it executable than moving it to /usr/local/bin that it will be accessible by the terminal
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# download wordpress 
wp core download --allow-root
mv wp-config-sample.php wp-config.php

#configure wordpress

wp config set SERVER_PORT 3306 --allow-root
wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html/wordpress
wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html/wordpress
wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html/wordpress
wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html/wordpress

# INSTALL WORDPRESS 
wp core install --url=$DOMAIN_NAME --title=INCEPTION --admin_user=$WPADMIN_USER --admin_password=$WPADMIN_PASSWORD --admin_email=$WPADMIN_EMAIL --allow-root --path=/var/www/html/wordpress
wp user create $WPUSER $WPUSER_EMAIL --role=author --user_pass=$WPUSER_PASSWORD --allow-root --path=/var/www/html/wordpress

exec "$@"
