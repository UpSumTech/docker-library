FROM sumanmukherjee03/ubuntu:16.04
LABEL goenv_version="1.12.0" \
  io.k8s.display-name="Goenv Base Image" \
  io.k8s.description="This is the Goenv base image that is used for building golang images"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID

RUN groupadd -g $NON_ROOT_GID $NON_ROOT_USER \
  && useradd -u $NON_ROOT_UID -d /home/$NON_ROOT_USER -s /bin/bash -m -r -g $NON_ROOT_USER $NON_ROOT_USER

ENV PATH="/go/bin:/usr/lib/go-1.10/bin:$PATH" \
  GOPATH="/go"

USER $NON_ROOT_USER
WORKDIR /home/$NON_ROOT_USER

RUN set -ex; \
  echo "" > /home/$NON_ROOT_USER/.bashrc; \
  git clone https://github.com/syndbg/goenv.git /home/$NON_ROOT_USER/.goenv; \
  cd /home/$NON_ROOT_USER/.goenv && git checkout 1.12.0 && cd /home/$NON_ROOT_USER; \
  echo 'export GOPATH="$HOME/go"' >> /home/$NON_ROOT_USER/.bashrc; \
  echo 'export GOENV_ROOT="$HOME/.goenv"' >> /home/$NON_ROOT_USER/.bashrc; \
  echo 'export PATH="$GOENV_ROOT/bin:$GOPATH/bin:$PATH"' >> /home/$NON_ROOT_USER/.bashrc; \
  echo 'eval "$(goenv init -)"' >> /home/$NON_ROOT_USER/.bashrc

WORKDIR /
USER root
