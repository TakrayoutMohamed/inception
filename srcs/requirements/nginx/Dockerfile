FROM debian:bullseye

RUN apt update && apt -y install nginx && apt install -y openssl 

RUN mkdir -p /etc/nginx/ssl

COPY tools/script.sh /tmp/

RUN chmod +x /tmp/script.sh

ENTRYPOINT ["/tmp/script.sh"]