FROM upsumtech/ubuntu:20.04
LABEL postgres_version="12.4" \
  io.k8s.display-name="Postgres Base Image" \
  io.k8s.description="This is the Postgres base image that is used for building postgres databases"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=postgres
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID

RUN groupadd -g $NON_ROOT_GID -r $NON_ROOT_USER \
  && useradd -u $NON_ROOT_UID -r -g $NON_ROOT_USER $NON_ROOT_USER

ENV POSTGRES_MAJOR_VERSION 12
ENV POSTGRES_VERSION 12.4-1.pgdg20.04+1

RUN set -ex; \
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8"; \
  gpg --batch --export "B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8" > /etc/apt/trusted.gpg.d/postgres.gpg; \
  gpgconf --kill all; \
  rm -rf $GNUPGHOME; \
  apt-key update; \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main $POSTGRES_MAJOR_VERSION" > /etc/apt/sources.list.d/pgdg.list; \
  apt-get -qq update; \
  apt-get install -y --no-install-recommends postgresql-common; \
  sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf; \
  apt-get install -y --no-install-recommends \
    postgresql-$POSTGRES_MAJOR_VERSION=$POSTGRES_VERSION \
    postgresql-contrib \
    postgresql-12-cron \
    postgresql-12-ip4r \
    postgresql-12-jsquery \
    postgresql-12-pg-track-settings \
    postgresql-12-pgpcre\
    libpq-dev; \
  rm -rf /var/run/postgresql \
    && mkdir -p /var/run/postgresql \
    && chown -R postgres:postgres /var/run/postgresql; \
  rm -rf /var/lib/postgresql \
    && mkdir -p /var/lib/postgresql/data \
    && chown -R postgres:postgres /var/lib/postgresql

COPY configuration /etc/postgresql/

ENV PATH=/usr/lib/postgresql/$POSTGRES_MAJOR_VERSION/bin:$PATH \
  PGDATA=/var/lib/postgresql/data \
  PGCONFIG=/etc/postgresql

VOLUME ["/var/lib/postgresql/data"]

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]
