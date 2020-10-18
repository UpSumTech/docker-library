FROM upsumtech/nvm:v0.33.11
LABEL node_version="8.11.1" \
  io.k8s.display-name="Node Base Image" \
  io.k8s.description="This is the Node base image that is used for building node applications"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID

USER $NON_ROOT_USER
WORKDIR /home/$NON_ROOT_USER

RUN set -ex; \
  source /.bash_profile && nvm install 8.11.1 \
    && nvm alias default v8.11.1; \
  npm install -g gulp grunt jshint typescript

WORKDIR /
USER root
