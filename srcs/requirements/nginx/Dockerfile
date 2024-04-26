FROM debian:bullseye

RUN apt update && apt -y install nginx && apt install -y openssl 

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 30 -newkey rsa:2048 -out /etc/ssl/certs/nginx-selfsigned.crt -keyout /etc/ssl/private/nginx-selfsigned.key -subj "/C=MA/L=KHOURIBGA/OU=mohtakra/O=mohtakra.1337.ma/CN=*.mohtakra.com/UID=mohtakra1"

COPY tools/script.sh /tmp/

RUN chmod +x /tmp/script.sh

ENTRYPOINT ["/tmp/script.sh"]