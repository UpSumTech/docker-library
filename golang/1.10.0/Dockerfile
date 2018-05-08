FROM sumanmukherjee03/goenv:1.12.0
LABEL golang_version="1.10.0" \
  io.k8s.display-name="Golang Base Image" \
  io.k8s.description="This is the Golang base image that is used for building golang binaries"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default

USER $NON_ROOT_USER
WORKDIR /home/$NON_ROOT_USER

RUN set -ex; \
  source /.bash_profile && goenv install 1.10.0; \
  source /.bash_profile && goenv global 1.10.0; \
  source /.bash_profile && go env && echo && goenv root; \
  source /.bash_profile && go get -u github.com/golang/dep/cmd/dep github.com/mitchellh/gox \
    && command -v dep \
    && command -v gox

WORKDIR /
USER root
