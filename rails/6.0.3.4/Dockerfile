FROM upsumtech/ruby:2.7.2
LABEL rails_version="6.0.3.4" \
  io.k8s.display-name="Rails Base Image" \
  io.k8s.description="This is the Rails base image that is used for building rails applications"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID
ENV RAILS_VERSION=6.0.3.4

RUN set -ex; \
  apt-get install -y --no-install-recommends \
    sqlite3 \
    libsqlite3-dev \
    mysql-client \
    libmysqlclient-dev \
    postgresql-client \
    libpq-dev \
    chrpath \
    libpng-dev \
    libpng-tools \
    libbz2-dev \
    libglib2.0-dev \
    zlib1g-dev \
    libbz2-dev \
    libtiff5-dev \
    libjpeg-dev \
    libjpeg8-dev \
    libxft-dev \
    libfreetype6 \
    libfreetype6-dev \
    libfontconfig1 \
    libfontconfig1-dev \
    libx11-dev \
    libxext-dev \
    libicu-dev \
    flex \
    gperf \
    ghostscript \
    imagemagick \
    parallel \
    lsof \
    unzip \
    nodejs \
    npm; \
  npm install -g coffee-script; \
  npm install -g typescript; \
  ldconfig /usr/local/lib; \
  mkdir -p /opt/app \
    && mkdir -p /var/run/app \
    && chown -R $NON_ROOT_USER:$NON_ROOT_USER /var/run/app \
    && mkdir -p /var/log/app \
    && chown -R $NON_ROOT_USER:$NON_ROOT_USER /var/log/app

EXPOSE 3000

USER $NON_ROOT_USER

RUN source /.bash_profile && gem install rails --version $RAILS_VERSION

USER root
