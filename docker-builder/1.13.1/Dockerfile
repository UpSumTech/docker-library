FROM sumanmukherjee03/ubuntu:16.04
LABEL docker_version="1.13.1" \
  io.k8s.display-name="Docker Builder Base Image" \
  io.k8s.description="This is the base image that is used for building docker containers"

ENV DOCKER_SOCKET=/var/run/docker.sock

RUN set -ex; \
  apt-get install -y --no-install-recommends \
    "linux-headers-$(uname -r)" \
    linux-image-extra-virtual \
    docker.io

VOLUME $DOCKER_SOCKET

COPY ./entrypoint.sh /entrypoint.sh
COPY ./gitconfig /etc/gitconfig
COPY ./gitignore /etc/gitignore
ENTRYPOINT ["/entrypoint.sh"]
CMD []
