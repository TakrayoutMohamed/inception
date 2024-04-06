#!/bin/bash
# download wp-cli : a command-line tool for managing wordpress installations 
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#make it executable than moving it to /usr/local/bin that it will be accessible by the terminal
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# download wordpress 
cd /var/www/html
wp core download --allow-root
mv wp-config-sample.php wp-config.php

#configure wordpress

wp config set SERVER_PORT 3306 --allow-root
wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html
wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html
wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html
wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html

# INSTALL WORDPRESS 
wp core install --url=$DOMAIN_NAME --title=INCEPTION --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root --path=/var/www/html
wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root --path=/var/www/html

exec "$@"
