# base image
FROM    debian:bullseye

RUN apt update && apt install -y php php-curl php-mysql && apt install -y php7.4-fpm && apt install -y curl && apt install -y sendmail

# /run/php/ to store session data, temporary files, or other types of data that is generated and used by PHP while it's running
RUN mkdir -p /run/php/

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

ENTRYPOINT [ "/tmp/script.sh" ]