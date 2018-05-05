FROM sumanmukherjee03/ubuntu:16.04
LABEL go_version="1.10"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default

ENV PATH="/go/bin:/usr/lib/go-1.10/bin:$PATH" \
  GOPATH="/go"

RUN set -ex; \
  apt-get install -y --no-install-recommends \
    golang-1.10-go; \
  go env; \
  go get -u github.com/golang/dep/cmd/dep github.com/mitchellh/gox \
    && command -v dep \
    && command -v gox
