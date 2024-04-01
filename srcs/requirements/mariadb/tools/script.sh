#!/bin/bash

sed -i 's/bind-address = 127.0.0.1/bind-address=0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
service mysql start
mysql -u root <<EOF 2> /dev/null
    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
    CREATE USER IF NOT EXISTS $MYSQL_USER@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO $MYSQL_USER@'%';
    FLUSH PRIVILEGES;
EOF

mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOTPASSWORD';"

mysqladmin -u root -p$MYSQL_ROOTPASSWORD shutdown

mysqld_safe
