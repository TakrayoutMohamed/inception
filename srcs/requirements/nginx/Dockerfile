FROM debian:buster

RUN apt update && apt-get install nginx -y  && apt-get install openssl -y

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/ssl/certs/nginx-selfsigned.crt -keyout /etc/ssl/private/nginx-selfsigned.key -subj "/C=MA/L=KHOURIBGA/O=mohtakra.1337.ma/CN=mohtakra/UID=mohtakra"

# COPY conf/nginx.conf /tmp/
COPY tools/script.sh /tmp/

RUN chmod +x /tmp/script.sh

ENTRYPOINT ["/tmp/script.sh"]

CMD [ "nginx", "-g", "daemon off;" ]