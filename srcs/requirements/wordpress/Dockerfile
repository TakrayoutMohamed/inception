# base image
FROM    debian:bullseye

RUN apt update && apt install -y curl php php-curl php-mysql php7.4-fpm  sendmail

# /run/php/ to store the PHP pid  while it's running (php7.xxxx-fpm.pid)
RUN mkdir -p /run/php/

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

ENTRYPOINT [ "/tmp/script.sh" ]