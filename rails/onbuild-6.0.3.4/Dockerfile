FROM upsumtech/rails:6.0.3.4
LABEL onbuild_app_type="rails" \
  io.k8s.display-name="Rails Onbuild Base Image" \
  io.k8s.description="This is the Rails Onbuild base image that is used for building rails applications"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID

ONBUILD ARG NON_ROOT_UID=1001
ONBUILD ARG NON_ROOT_GID=1001
ONBUILD ARG NON_ROOT_USER=default
ONBUILD ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ONBUILD ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID
ONBUILD COPY . /opt/app/current
ONBUILD RUN chown -R $NON_ROOT_UID:$NON_ROOT_GID /opt/app
ONBUILD USER $NON_ROOT_USER
ONBUILD WORKDIR /opt/app/current
ONBUILD RUN source /.bash_profile && gem install passenger && bundle install
