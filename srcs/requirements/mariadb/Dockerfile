FROM debian:bullseye

RUN apt update && apt install mariadb-server -y

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

ENTRYPOINT ["./tmp/script.sh"]

# CMD ["mysqld_safe"]