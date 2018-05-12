FROM ubuntu:16.04
LABEL os="ubuntu" \
  os_version="16.04" \
  author_name="Suman Mukherjee" \
  author_email="sumanmukherjee03@gmail.com" \
  io.k8s.display-name="Ubuntu Base Image" \
  io.k8s.description="This is the Ubuntu base image that is used for building other images"

ENV BUILD_DATA="/var/data/build" \
  DEBIAN_FRONTEND="noninteractive" \
  CONFIGURE_OPTS="--disable-install-doc" \
  MAKEFLAGS="-j$(($(nproc) + 1))"

RUN apt-key update \
  && apt-get -qq update \
  && chsh -s /bin/bash \
  && rm /bin/sh && ln -sf /bin/bash /bin/sh

RUN set -ex; \
  apt-get install -y --no-install-recommends \
    apt-utils \
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
    gnupg \
    rsync \
    g++ \
    jq; \
  apt-get autoremove -y \
    && apt-get clean -y; \
  mkdir -p $BUILD_DATA

RUN set -ex; \
  dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
  wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.10/gosu-$dpkgArch"; \
  wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.10/gosu-$dpkgArch.asc"; \
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
  gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
  rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
  chmod +x /usr/local/bin/gosu; \
  gosu nobody true

RUN set -ex; \
  echo '[ -f $HOME/.bashrc ] && . $HOME/.bashrc' >> /.bash_profile

COPY ./bash_utils.sh /usr/local/share/bash_utils.sh

STOPSIGNAL SIGTERM
