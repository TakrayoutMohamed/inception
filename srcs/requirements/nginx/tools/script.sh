#!/bin/bash

echo "
 server  {
    listen 443 ssl;
    ssl_protocols TLSv1.3 ;
    ssl_certificate $CERTS_;
    ssl_certificate_key $KEYS_;

    root /var/www/$DOMAIN_NAME/wordpress;
    index index.php;
    server_name $DOMAIN_NAME;
" > /etc/nginx/sites-enabled/wordpress
echo '
    location ~ \.php$ {
        fastcgi_pass wordpress:9000; 
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        # include snippets/fastcgi-php.conf;
        include fastcgi_params;
    }
    
    location / {
        try_files $uri $uri/ =404;
    }
} ' >> /etc/nginx/sites-enabled/wordpress

exec "$@"
