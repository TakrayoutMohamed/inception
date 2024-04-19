# base image
FROM    debian:buster
# RUN apt update -y && apt install -y php7.3 curl sendmail wget && apt install php7.3-fpm php7.3-cli php7.3-mysql php7.3-curl php7.3-json -y
RUN apt update && apt install -y php php-curl php-mysql && apt install -y php7.3-fpm && apt install -y curl && apt install -y sendmail

# RUN sed -i 's#listen = /run/php/php7.3-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/7.3/fpm/pool.d/www.conf

# /run/php/ to store session data, temporary files, or other types of data that is generated and used by PHP while it's running
RUN mkdir -p /run/php/

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

ENTRYPOINT [ "/tmp/script.sh" ]

CMD [ "php-fpm7.3", "-F" ]