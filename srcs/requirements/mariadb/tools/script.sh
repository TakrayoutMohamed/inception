#!/bin/bash

service mysql start

sed -i 's/bind-address = 127.0.0.1/bind-address=0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

mysql -u root -p$MYSQL_ROOTPASSWORD -e "create database if not exists $MYSQL_DATABASE;"

mysql -u root -p$MYSQL_ROOTPASSWORD -e "create user if not exists '$MYSQL_USER'@'%' identified by $MYSQL_PASSWORD;"

mysql -u root -p$MYSQL_ROOTPASSWORD -e "grant all privileges on $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"

mysql -u root -p$MYSQL_ROOTPASSWORD -e "flush privileges;"

mysql -u root -p$MYSQL_ROOTPASSWORD -e "alter user 'root'@'localhost' identified by $MYSQL_ROOTPASSWORD';"

kill 'cat /var/run/mysqld/mysqld.pid'

exec "$@"
# echo "the password is [w] ";
