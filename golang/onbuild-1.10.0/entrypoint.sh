#! /usr/bin/env bash

set -ex -o pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[[ -f /usr/local/share/bash_utils.sh && $BASH_UTILS_SOURCED -neq 1 ]] && . /usr/local/share/bash_utils.sh

validate() {
  [[ ! -z "$EXPECTED_NON_ROOT_UID" ]] \
    || die "non root user not provided for running the container"
  [[ ! -z "$PROJECT" ]] \
    || die "repo name not provided to build the container"
  [[ -d "$ARTIFACT_VOLUME_DIR" ]] \
    || die "artifact volume dir not present to put the build artifacts in"
  [[ $(id -u) -eq 0 ]] \
    && die "container should not run as root"
  [[ $(id -u) -eq $EXPECTED_NON_ROOT_UID ]] \
      || die "user execing the container is not the non root user expected"
  . /.bash_profile && command -v gox \
      || die "gox not in the path"
  . /.bash_profile && command -v dep \
      || die "dep not in the path"
  ok
}

build_and_package() {
  echo "Starting to build binaries"
  . /.bash_profile \
    && CGO_ENABLED=0 gox -osarch='linux/amd64 linux/386 darwin/amd64 darwin/386' -rebuild -tags='netgo' -ldflags='-w -extldflags "-static"'
  echo "Starting to build package"
  mv ${PROJECT}_linux_386 $ARTIFACT_VOLUME_DIR
  mv ${PROJECT}_linux_amd64 $ARTIFACT_VOLUME_DIR
  mv ${PROJECT}_darwin_386 $ARTIFACT_VOLUME_DIR
  mv ${PROJECT}_darwin_amd64 $ARTIFACT_VOLUME_DIR
  cd $ARTIFACT_VOLUME_DIR
  tar czf $PROJECT.tar.gz *
  rm ${PROJECT}_linux_386 $PROJECT_darwin_386 ${PROJECT}_linux_amd64 $PROJECT_darwin_amd64
  echo "Done building the package"
  ok
}

main() {
  log_current_state
  validate
  chdir_and_exec build_and_package
  ok
}

[[ $BASH_SOURCE == $0 ]] && main
