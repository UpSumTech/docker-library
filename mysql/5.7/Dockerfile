FROM upsumtech/ubuntu:20.04
LABEL mysql_version="5.7" \
  io.k8s.display-name="Mysql Base Image" \
  io.k8s.description="This is the Mysql base image that is used for building mysql databases"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=mysql

RUN groupadd -g $NON_ROOT_GID -r $NON_ROOT_USER \
  && useradd -u $NON_ROOT_UID -r -g $NON_ROOT_USER $NON_ROOT_USER

ENV MYSQL_VERSION=5.7 \
  MYSQLDATA=/var/lib/mysql

RUN set -ex; \
  curl -o "mysql-${MYSQL_VERSION}.deb" -SL 'http://dev.mysql.com/get/mysql-apt-config_0.3.2-1ubuntu14.04_all.deb' \
    && dpkg -i "mysql-${MYSQL_VERSION}.deb"; \
  apt-get install -y mysql-server; \
  rm -rf /var/run/mysqld \
    && mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld; \
  rm -rf /var/lib/mysql \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql; \
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
