FROM upsumtech/ubuntu:20.04
LABEL docker_version="19.03.8" \
  io.k8s.display-name="Docker Builder Base Image" \
  io.k8s.description="This is the base image that is used for building docker containers"

ENV DOCKER_SOCKET=/var/run/docker.sock

RUN set -ex; \
  apt-get install -y --no-install-recommends \
    linux-headers-generic \
    linux-image-virtual \
    docker.io

VOLUME $DOCKER_SOCKET

COPY ./entrypoint.sh /entrypoint.sh
COPY ./gitconfig /etc/gitconfig
COPY ./gitignore /etc/gitignore
ENTRYPOINT ["/entrypoint.sh"]
CMD []
