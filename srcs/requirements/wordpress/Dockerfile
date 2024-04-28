# base image
FROM    debian:bullseye

RUN apt update && apt install -y php php-curl php-mysql && apt install -y php7.4-fpm && apt install -y curl && apt install -y sendmail

# /run/php/ to store the PHP pid  while it's running (php7.xxxx-fpm.pid)
RUN mkdir -p /run/php/

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

ENTRYPOINT [ "/tmp/script.sh" ]