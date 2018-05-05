FROM sumanmukherjee03/rails:5.2.0
LABEL onbuild_app_type="rails"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default

ONBUILD COPY . /opt/app/current
ONBUILD RUN chown -R $NON_ROOT_USER:$NON_ROOT_USER /opt/app
ONBUILD USER $NON_ROOT_USER
ONBUILD WORKDIR /opt/app/current
ONBUILD RUN source /.bash_profile && gem install passenger && bundle install
