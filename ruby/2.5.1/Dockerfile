FROM sumanmukherjee03/rbenv:1.1.1
LABEL ruby_version="2.5.1"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default

USER $NON_ROOT_USER
WORKDIR /home/$NON_ROOT_USER

RUN set -ex; \
  echo 'gem: --no-rdoc --no-ri' >> /home/$NON_ROOT_USER/.gemrc; \
  source /.bash_profile && rbenv install 2.5.1; \
  source /.bash_profile && rbenv global 2.5.1; \
  source /.bash_profile && gem install bundler

WORKDIR /
USER root
