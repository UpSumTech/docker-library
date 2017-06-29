FROM sumanmukherjee03/ubuntu:14.04
MAINTAINER Suman Mukherjee <sumanmukherjee03@gmail.com>

RUN apt-get -qq update \
  && apt-get upgrade -y

RUN apt-get install -y \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline-dev \
  libreadline6-dev \
  libsqlite3-dev \
  sqlite3 \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  python-software-properties \
  python-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm3 \
  libgdbm-dev

RUN groupadd -r webapp \
  && useradd -d /home/webapp -s /bin/bash -m -r -g webapp webapp

USER webapp
WORKDIR /home/webapp
RUN echo "" > /home/webapp/.bashrc

RUN git clone https://github.com/sstephenson/rbenv.git /home/webapp/.rbenv \
  && cd /home/webapp/.rbenv \
  && git fetch \
  && git checkout v1.0.0

RUN git clone https://github.com/sstephenson/ruby-build.git /home/webapp/.rbenv/plugins/ruby-build \
  && git clone https://github.com/sstephenson/rbenv-gem-rehash.git /home/webapp/.rbenv/plugins/rbenv-gem-rehash

RUN echo 'export RBENV_ROOT="/home/webapp/.rbenv"' >> /home/webapp/.bashrc
RUN echo 'export PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"' >> /home/webapp/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> /home/webapp/.bashrc

WORKDIR /
USER root
