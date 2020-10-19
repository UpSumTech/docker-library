FROM upsumtech/node:v12.19.0
LABEL onbuild_app_type="node" \
  io.k8s.display-name="Node Onbuild Base Image" \
  io.k8s.description="This is the Node Onbuild base image that is used for building node applications"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID

RUN mkdir -p /opt/app/

EXPOSE 8989

ONBUILD ARG NON_ROOT_UID=1001
ONBUILD ARG NON_ROOT_GID=1001
ONBUILD ARG NON_ROOT_USER=default
ONBUILD ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ONBUILD ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID
ONBUILD COPY . /opt/app/current
ONBUILD RUN chown -R $NON_ROOT_UID:$NON_ROOT_GID /opt/app
ONBUILD USER $NON_ROOT_USER
ONBUILD WORKDIR /opt/app/current
ONBUILD RUN source /.bash_profile && npm install
