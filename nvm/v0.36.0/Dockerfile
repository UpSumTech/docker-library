FROM upsumtech/ubuntu:20.04
LABEL nvm_version="v0.36.0" \
  io.k8s.display-name="Nvm Base Image" \
  io.k8s.description="This is the Nvm base image that is used for building other node images"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID
ENV NVM_VERSION=v0.36.0

RUN groupadd -g $NON_ROOT_GID -r $NON_ROOT_USER \
  && useradd -u $NON_ROOT_UID -d /home/$NON_ROOT_USER -s /bin/bash -m -r -g $NON_ROOT_USER $NON_ROOT_USER

USER $NON_ROOT_USER
WORKDIR /home/$NON_ROOT_USER

RUN set -ex; \
  echo "" > $HOME/.bashrc; \
  curl -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash; \
  echo 'export NVM_DIR="$HOME/.nvm"' >> /home/$NON_ROOT_USER/.bashrc; \
  echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> /home/$NON_ROOT_USER/.bashrc; \
  echo '[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"' >> /home/$NON_ROOT_USER/.bashrc

WORKDIR /
USER root
