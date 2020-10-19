FROM upsumtech/ubuntu:20.04
LABEL rbenv_version="1.1.2" \
  io.k8s.display-name="Rbenv Base Image" \
  io.k8s.description="This is the rbenv base image that is used for building other ruby based images"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID

RUN groupadd -g $NON_ROOT_GID $NON_ROOT_USER \
  && useradd -u $NON_ROOT_UID -d /home/$NON_ROOT_USER -s /bin/bash -m -r -g $NON_ROOT_USER $NON_ROOT_USER

RUN set -ex; \
  apt-get install -y --no-install-recommends \
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
    software-properties-common \
    python-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm6 \
    libgdbm-dev

USER $NON_ROOT_USER
WORKDIR /home/$NON_ROOT_USER

RUN set -ex; \
  echo "" > /home/$NON_ROOT_USER/.bashrc; \
  git clone https://github.com/sstephenson/rbenv.git /home/$NON_ROOT_USER/.rbenv \
    && cd /home/$NON_ROOT_USER/.rbenv \
    && git fetch \
    && git checkout v1.1.2; \
  git clone https://github.com/sstephenson/ruby-build.git /home/$NON_ROOT_USER/.rbenv/plugins/ruby-build; \
  echo 'export RBENV_ROOT="/home/$NON_ROOT_USER/.rbenv"' >> /home/$NON_ROOT_USER/.bashrc; \
  echo 'export PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"' >> /home/$NON_ROOT_USER/.bashrc; \
  echo 'eval "$(rbenv init -)"' >> /home/$NON_ROOT_USER/.bashrc

USER $NON_ROOT_USER
RUN set -ex; \
  source /home/$NON_ROOT_USER/.bashrc; \
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

WORKDIR /
USER root
