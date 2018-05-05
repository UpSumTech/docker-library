FROM sumanmukherjee03/ubuntu:16.04
LABEL nvm_version="v0.33.11"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default

RUN groupadd -g $NON_ROOT_GID -r $NON_ROOT_USER \
  && useradd -u $NON_ROOT_UID -d /home/$NON_ROOT_USER -s /bin/bash -m -r -g $NON_ROOT_USER $NON_ROOT_USER

USER $NON_ROOT_USER
WORKDIR /home/$NON_ROOT_USER

RUN set -ex; \
  echo "" > $HOME/.bashrc; \
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash; \
  echo 'export NVM_DIR="$HOME/.nvm"' >> /home/$NON_ROOT_USER/.bashrc; \
  echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> /home/$NON_ROOT_USER/.bashrc

WORKDIR /
USER root
