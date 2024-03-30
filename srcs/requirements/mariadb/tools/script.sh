#!/bin/bash

service mysql start

sed -i 's/bind-address = 127.0.0.1/bind-address=0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

mysql -u root -p$MYSQL_ROOTPASSWORD -e "create database if not exists $MYSQL_DATABASE;"

mysql -u root -p$MYSQL_ROOTPASSWORD -e "create user if not exists $MYSQL_USER@'%' identified by $MYSQL_PASSWORD;"

mysql -u root -p$MYSQL_ROOTPASSWORD -e "grant all privileges on ${MYSQL_DATABASE}.* TO $MYSQL_USER@'%';"

mysql -u root -p$MYSQL_ROOTPASSWORD -e "flush privileges;"

mysql -u root -p$MYSQL_ROOTPASSWORD -e "alter user 'root'@'localhost' identified by '$MYSQL_ROOTPASSWORD';"

kill 'cat /var/run/mysqld/mysqld.pid'

echo "the symbole means {$@}";
exec "$@"



# mysqld_safe &

# sleep 3

# mariadb -u root <<EOF
# CREATE DATABASE $DB_NAME;
# CREATE USER $MARIA_DB_USER@'%' IDENTIFIED BY '$MARIA_DB_USER_PASSWORD';
# GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO $MARIA_DB_USER@'%';
# FLUSH PRIVILEGES;
# EOF

# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIA_DB_ROOT_PASSWORD';"

# mysqladmin -u root -p$MARIA_DB_ROOT_PASSWORD shutdown

# mysqld_safe