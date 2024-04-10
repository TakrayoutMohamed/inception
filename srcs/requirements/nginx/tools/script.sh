#!/bin/bash

echo "
 server  {
    listen 443 ssl;
    ssl_protocols TLSv1.2;
    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

    root /var/www/html;
    index index.php;
    server_name $DOMAIN_NAME;
" >> /etc/nginx/sites-enabled/default
echo '
    location ~ .php$ {
        try_files $uri =404;
        fastcgi_pass wordpress:9000; 
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
    
    location / {
        try_files $uri $uri/ =404;
    }
} ' >> /etc/nginx/sites-enabled/default

exec "$@"
