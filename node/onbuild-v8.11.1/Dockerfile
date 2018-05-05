FROM sumanmukherjee03/node:v8.11.1
LABEL onbuild_app_type="node" \
  io.k8s.display-name="Node Onbuild Base Image" \
  io.k8s.description="This is the Node Onbuild base image that is used for building node applications"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default

RUN mkdir -p /opt/app/

EXPOSE 8989

ONBUILD COPY . /opt/app/current
ONBUILD RUN chown -R $NON_ROOT_USER:$NON_ROOT_USER /opt/app
ONBUILD USER $NON_ROOT_USER
ONBUILD WORKDIR /opt/app/current
ONBUILD RUN source /.bash_profile && npm install
