#Postgres 9.3 in Ubuntu 12.04
FROM ubuntu:precise
MAINTAINER Armin Coralic docker@coralic.com

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y upgrade
RUN locale-gen en_US.UTF-8

RUN apt-get -y install wget

RUN wget --quiet --no-check-certificate -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list

RUN apt-get -y update
RUN LC_ALL=en_US.UTF-8 apt-get -y install postgresql-9.3 postgresql-contrib-9.3

RUN echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses = '*'" >> /etc/postgresql/9.3/main/postgresql.conf
RUN echo "port = 5432" >> /etc/postgresql/9.3/main/postgresql.conf

RUN service postgresql start && /bin/su postgres -c "psql postgres -c \"ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres'\"" && service postgresql stop

EXPOSE 5432

CMD /bin/su postgres -c '/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf' & /bin/bash
