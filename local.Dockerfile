FROM mysql:8

ENV MYSQL_ROOT_PASSWORD pass
COPY ./app/scripts/db_app.sql /docker-entrypoint-initdb.d/db_app.sql
