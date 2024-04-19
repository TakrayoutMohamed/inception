#!/bin/bash

echo "
 server  {
    listen 443 ssl;
    ssl on;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_certificate $CERTS_;
    ssl_certificate_key $KEYS_;

    root /var/www/html;
    index index.php index.html index.htm;
    server_name $DOMAIN_NAME;
" > /etc/nginx/sites-enabled/default
echo '
    location ~ \.php$ {
        fastcgi_pass wordpress:9000;
        include snippets/fastcgi-php.conf;
        include fastcgi_params;
        include scgi_params;
        scgi_param HTTPS $https if_not_empty;
    }
    
    location / {
        try_files $uri $uri/ =404;
    }
} ' >> /etc/nginx/sites-enabled/default

exec "$@"
