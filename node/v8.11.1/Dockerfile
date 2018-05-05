FROM sumanmukherjee03/nvm:v0.33.11
LABEL node_version="8.11.1"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default

USER $NON_ROOT_USER
WORKDIR /home/$NON_ROOT_USER

RUN set -ex; \
  source /.bash_profile && nvm install 8.11.1 \
    && nvm alias default v8.11.1; \
  npm install -g gulp grunt jshint typescript

WORKDIR /
USER root
