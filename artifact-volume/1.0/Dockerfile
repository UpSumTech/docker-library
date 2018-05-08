FROM sumanmukherjee03/ubuntu:16.04
LABEL artifact_volume_version="1.0" \
  io.k8s.display-name="Artifact Volume Base Image" \
  io.k8s.description="This is the base image that is used for storing build artifacts and keep the container up and running so that you can download the build artifact"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID

ENV EXPOSED_PORT=8787
ENV ARTIFACT_VOLUME_DIR=/var/data/build

RUN groupadd -g $NON_ROOT_GID $NON_ROOT_USER \
  && useradd -u $NON_ROOT_UID -d /home/$NON_ROOT_USER -s /bin/bash -m -r -g $NON_ROOT_USER $NON_ROOT_USER

RUN set -ex; \
  apt-get install -y --no-install-recommends netcat

VOLUME $ARTIFACT_VOLUME_DIR
EXPOSE $EXPOSED_PORT/tcp

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD []

STOPSIGNAL SIGTERM
