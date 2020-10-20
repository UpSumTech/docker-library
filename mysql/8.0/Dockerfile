FROM upsumtech/ubuntu:20.04
LABEL mysql_version="8.0" \
  io.k8s.display-name="Mysql Base Image" \
  io.k8s.description="This is the Mysql base image that is used for building mysql databases"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=mysql

RUN groupadd -g $NON_ROOT_GID -r $NON_ROOT_USER \
  && useradd -u $NON_ROOT_UID -r -g $NON_ROOT_USER $NON_ROOT_USER

ENV MYSQL_MAJOR_VERSION=8.0 \
  MYSQL_VERSION=8.0.22-1debian10 \
  MYSQLDATA=/var/lib/mysql

RUN set -ex; \
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "A4A9406876FCBD3C456770C88C718D3B5072E1F5"; \
  gpg --batch --export "A4A9406876FCBD3C456770C88C718D3B5072E1F5" > /etc/apt/trusted.gpg.d/nginx.gpg; \
  gpgconf --kill all; \
  rm -rf $GNUPGHOME; \
  apt-key update; \
  echo "deb http://repo.mysql.com/apt/debian/ buster mysql-${MYSQL_MAJOR_VERSION}" >> /etc/apt/sources.list.d/mysql.list; \
  apt-get -qq update; \
  apt-get install -y \
    mysql-community-client=$MYSQL_VERSION \
    mysql-community-server=$MYSQL_VERSION; \
  rm -rf /var/run/mysqld \
    && mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 1777 /var/run/mysqld; \
  rm -rf /var/lib/mysql \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql \
    && chmod 1777 /var/lib/mysql; \
  rm -rf /var/log/mysql \
    && mkdir -p /var/log/mysql \
    && chown -R mysql:mysql /var/log/mysql

COPY configuration/my.cnf /etc/mysql/my.cnf
COPY entrypoint.sh /entrypoint.sh
COPY ./initdb.d /initdb.d

VOLUME ["/var/lib/mysql"]
EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
