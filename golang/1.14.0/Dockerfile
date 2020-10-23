FROM upsumtech/goenv:latest
LABEL golang_version="1.14.0" \
  io.k8s.display-name="Golang Base Image" \
  io.k8s.description="This is the Golang base image that is used for building golang binaries"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID
ENV GO_VERSION=1.14.0

USER $NON_ROOT_USER
WORKDIR /home/$NON_ROOT_USER

ENV PATH="/home/$NON_ROOT_USER/go/$GO_VERSION/bin:$PATH"

RUN set -ex; \
  source /.bash_profile; \
  goenv install $GO_VERSION; \
  goenv global $GO_VERSION; \
  goenv root; \
  go env; \
  go get -u github.com/golang/dep/cmd/dep github.com/mitchellh/gox; \
  command -v dep; \
  command -v gox

WORKDIR /
USER root
