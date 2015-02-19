FROM ubuntu:12.04
ENV REFRESHED_AT 2015-29-01 13:56

RUN apt-get update
RUN apt-get install -y nano
RUN apt-get install -y postgresql libpq-dev
RUN echo "kernel.shmmax = 104857600" >> /etc/sysctl.conf
USER postgres
RUN echo "host all  all    0.0.0.0/0  trust" >> /etc/postgresql/9.1/main/pg_hba.conf
#RUN echo "host all all ::1/128 trust" >> /etc/postgresql/9.1/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.1/main/postgresql.conf
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER firmaexpress WITH SUPERUSER PASSWORD 'F1rm43xpr3$$';" &&\
    createdb -O firmaexpress firmaexpress_development
EXPOSE 5432
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
CMD ["/usr/lib/postgresql/9.1/bin/postgres", "-D", "/var/lib/postgresql/9.1/main", "-c", "config_file=/etc/postgresql/9.1/main/postgresql.conf"]
#/usr/lib/postgresql/9.1/bin/postgres -D /var/lib/postgresql/9.1/main -c config_file=/etc/postgresql/9.1/main/postgresql.conf