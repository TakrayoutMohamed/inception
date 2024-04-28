#!/bin/bash

openssl req -x509 -nodes -days 30 -newkey rsa:2048 -out $CERTS_ -keyout $KEYS_ -subj "/C=MA/L=KHOURIBGA/UID=mohtakra"

echo "
 server  {
    listen 443 ssl;
    ssl_protocols TLSv1.2;
    ssl_certificate $CERTS_;
    ssl_certificate_key $KEYS_;

    root /var/www/html;
    index index.php index.html index.htm;
    server_name $DOMAIN_NAME;
" > /etc/nginx/sites-enabled/default
echo '
    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        fastcgi_pass wordpress:9000;
        include snippets/fastcgi-php.conf;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
    
} ' >> /etc/nginx/sites-enabled/default

nginx -t

service nginx stop

nginx -g "daemon off;"
