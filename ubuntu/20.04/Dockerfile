FROM ubuntu:20.04
LABEL os="ubuntu" \
  os_version="20.04" \
  author_name="Suman Mukherjee" \
  author_email="sumanmukherjee03@gmail.com" \
  io.k8s.display-name="Ubuntu Base Image" \
  io.k8s.description="This is the Ubuntu base image that is used for building other images"

ENV BUILD_DATA="/var/data/build" \
  DEBIAN_FRONTEND="noninteractive" \
  CONFIGURE_OPTS="--disable-install-doc" \
  MAKEFLAGS="-j$(($(nproc) + 1))"

RUN set -ex; \
  apt-get -qq update; \
  apt-get install -y --no-install-recommends gnupg2; \
  apt-key update; \
  apt update; \
  chsh -s /bin/bash; \
  rm /bin/sh; \
  ln -sf /bin/bash /bin/sh; \
  apt-get install -y --no-install-recommends locales; \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

RUN set -ex; \
  apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    ca-certificates \
    apt-transport-https \
    gcc \
    git \
    git-core \
    tar \
    zip \
    unzip \
    autoconf \
    make \
    cmake \
    automake \
    curl \
    wget \
    perl \
    pkg-config \
    libtool \
    libaio1 \
    python \
    dirmngr \
    rsync \
    jq \
    g++; \
  apt-get autoremove -y; \
  apt-get clean -y; \
  mkdir -p $BUILD_DATA

ENV GOSU_VERSION 1.12
RUN set -ex; \
  dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
  wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
  wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
  gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
  gpgconf --kill all; \
  rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
  chmod +x /usr/local/bin/gosu; \
  gosu --version; \
  gosu nobody true

COPY ./bash_utils.sh /usr/local/share/bash_utils.sh

RUN set -ex; \
  echo '[ -f $HOME/.bashrc ] && . $HOME/.bashrc' >> /.bash_profile

STOPSIGNAL SIGTERM
