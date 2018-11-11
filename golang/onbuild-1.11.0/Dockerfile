FROM sumanmukherjee03/golang:1.11.0
LABEL onbuild_app_type="golang" \
  io.k8s.display-name="Golang Onbuild Base Image for golang 1.11.0" \
  io.k8s.description="This is the Golang onbuild base image that is used for building golang binaries with golang 1.11.0"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
COPY entrypoint.sh /entrypoint.sh
RUN set -ex; \
  chown $NON_ROOT_USER:$NON_ROOT_USER /entrypoint.sh

ONBUILD ARG NON_ROOT_UID=1001
ONBUILD ARG NON_ROOT_GID=1001
ONBUILD ARG NON_ROOT_USER=default
ONBUILD ARG GITHUB_USERNAME
ONBUILD ARG REPO_NAME
ONBUILD ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ONBUILD ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID
ONBUILD ENV PROJECT=$REPO_NAME
ONBUILD ENV ARTIFACT_VOLUME_DIR /var/data/build

ONBUILD RUN set -ex; \
  mkdir -p /home/$NON_ROOT_USER/go/src/$GITHUB_USERNAME/$REPO_NAME && \
  chown -R $NON_ROOT_USER:$NON_ROOT_USER /home/$NON_ROOT_USER/go/src/$GITHUB_USERNAME/$REPO_NAME; \
  mkdir -p $ARTIFACT_VOLUME_DIR && \
  chown -R $NON_ROOT_USER:$NON_ROOT_USER $ARTIFACT_VOLUME_DIR
ONBUILD COPY . /home/$NON_ROOT_USER/go/src/$GITHUB_USERNAME/$REPO_NAME
ONBUILD RUN chown -R $NON_ROOT_USER:$NON_ROOT_USER /home/$NON_ROOT_USER/go/src/$GITHUB_USERNAME/$REPO_NAME
ONBUILD USER $NON_ROOT_USER
ONBUILD WORKDIR /home/$NON_ROOT_USER/go/src/$GITHUB_USERNAME/$REPO_NAME
ONBUILD RUN set -ex; \
  . /.bash_profile && dep ensure

ENTRYPOINT ["/entrypoint.sh"]
