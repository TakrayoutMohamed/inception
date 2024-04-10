#!/bin/bash

cat /tmp/nginx.conf > /etc/nginx/sites-enabled/default
touch /var/www/html/index.html
echo  "<h1>Hello, alvares!</h1>"  > index.html

exec "$@"
