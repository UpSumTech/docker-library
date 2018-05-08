FROM sumanmukherjee03/ubuntu:16.04
LABEL postgres_version="9.6" \
  io.k8s.display-name="Postgres Base Image" \
  io.k8s.description="This is the Postgres base image that is used for building postgres databases"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=postgres
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID

RUN groupadd -g $NON_ROOT_GID -r $NON_ROOT_USER \
  && useradd -u $NON_ROOT_UID -r -g $NON_ROOT_USER $NON_ROOT_USER

ENV POSTGRES_VERSION 9.6

RUN set -ex; \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list; \
  apt-get -qq update; \
  apt-get install -y --no-install-recommends \
    postgresql-common \
    postgresql-$POSTGRES_VERSION \
    postgresql-contrib-$POSTGRES_VERSION \
    libpq-dev; \
  rm -rf /var/run/postgresql \
    && mkdir -p /var/run/postgresql \
    && chown -R postgres:postgres /var/run/postgresql; \
  rm -rf /var/lib/postgresql \
    && mkdir -p /var/lib/postgresql/data \
    && chown -R postgres:postgres /var/lib/postgresql

COPY configuration /etc/postgresql/

ENV PATH=/usr/lib/postgresql/$POSTGRES_VERSION/bin:$PATH \
  PGDATA=/var/lib/postgresql/data \
  PGCONFIG=/etc/postgresql

VOLUME ["/var/lib/postgresql/data"]

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]
