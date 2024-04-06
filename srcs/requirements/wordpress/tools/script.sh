#!/bin/bash

cat /tmp/nginx.conf > /etc/nginx/sites-enabled/default
touch /var/www/html/index.html
echo '<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Hello, alvares!</title>
</head>
<body>
    <h1>Hello, alvares!</h1>
    <p>We have just configured our Nginx web server on Ubuntu Server!</p>
</body>
</html>' > index.html

exec "$@"
