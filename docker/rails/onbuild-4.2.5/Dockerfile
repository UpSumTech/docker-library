FROM sumanmukherjee03/rails:4.2.5
MAINTAINER Suman Mukherjee <sumanmukherjee03@gmail.com>

RUN apt-get -qq update \
  && apt-get install -y --no-install-recommends \
    mysql-client \
    libmysqlclient-dev \
    postgresql-client \
    libpq-dev

RUN apt-get -qq update \
  && apt-get install -y --no-install-recommends \
    chrpath \
    libpng-dev \
    libpng12-dev \
    libbz2-dev \
    libglib2.0-dev \
    zlib1g-dev \
    libbz2-dev \
    libtiff4-dev \
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
    realpath

RUN apt-get -qq update \
  && apt-get install -y --no-install-recommends \
    nodejs \
    npm

RUN npm install -g coffee-script

RUN ldconfig /usr/local/lib

RUN mkdir -p /opt/app \
  && mkdir -p /var/run/app \
  && chown -R webapp:webapp /var/run/app \
  && mkdir -p /var/log/app \
  && chown -R webapp:webapp /var/log/app

EXPOSE 3000

ONBUILD ADD . /opt/app/current

ONBUILD RUN chown -R webapp:webapp /opt/app
