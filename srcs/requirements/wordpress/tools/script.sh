#!/bin/bash

# sleep 8

# download wp-cli : a command-line tool for managing wordpress installations 
curl -LO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

mkdir -p /var/www/html
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# download wordpress 
cd /var/www/html
wp core download --allow-root

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
sed -i '36 s/\/run\/php\/php7.3-fpm.sock/9000/' /etc/php/7.3/fpm/pool.d/www.conf

wp config set SERVER_PORT 3306 --allow-root

wp config set DB_NAME $MYSQL_DATABASE --allow-root
wp config set DB_USER $MYSQL_USER --allow-root
wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root
wp config set DB_HOST 'mariadb' --allow-root
# wp config set FORCE_SSL_ADMIN 'false' --allow-root
# # The instruction "wp config set WP_CACHE 'true'" is a command that sets the value of the WP_CACHE constant in the WordPress configuration file to "true".
# # This constant controls whether caching is enabled in WordPress or not.
# wp config set WP_CACHE 'true' --allow-root

# INSTALL WORDPRESS 
wp core install --url=$DOMAIN_NAME --title="tst Website" --admin_user=$WPADMIN_USER --admin_password=$WPADMIN_PASSWORD --admin_email=$WPADMIN_EMAIL --allow-root
wp user create $WPUSER $WPUSER_EMAIL --role=author --user_pass=$WPUSER_PASSWORD --allow-root

exec "$@"
