#! /usr/bin/env bash

set -e -o pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export MAIN_PID="$$"
die() {
  echo >&2 "ERROR >> $1"
  kill -s TERM "$MAIN_PID"
  exit 1
}

ok() {
  echo -n ''
}

chdir_and_exec() {
  local result
  local fn="$1"
  shift 1
  pushd .
  result=$(eval "$(declare -F "$fn")" "$@")
  popd
  echo "$result"
}

log_user_and_group() {
  echo "User id : $(id -u)"
  echo "Group id : $(id -g)"
  echo "User name : $(id -un)"
  echo "Group name : $(id -gn)"
  ok
}

log_env_vars() {
  printenv
  ok
}

log_current_state() {
  log_user_and_group
  log_env_vars
  ok
}

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
  ok
}

build_and_package() {
  . /.bash_profile \
    && CGO_ENABLED=0 gox -osarch='linux/amd64 linux/386 darwin/amd64 darwin/386' -rebuild -tags='netgo' -ldflags='-w -extldflags "-static"' \
    && mv ${PROJECT}_linux_386 $ARTIFACT_VOLUME_DIR \
    && mv ${PROJECT}_linux_amd64 $ARTIFACT_VOLUME_DIR \
    && mv ${PROJECT}_darwin_386 $ARTIFACT_VOLUME_DIR \
    && mv ${PROJECT}_darwin_amd64 $ARTIFACT_VOLUME_DIR \
    && cd $ARTIFACT_VOLUME_DIR \
    && tar czf $PROJECT.tar.gz * \
    && rm ${PROJECT}_linux_386 $PROJECT_darwin_386 ${PROJECT}_linux_amd64 $PROJECT_darwin_amd64 \
    || die "build and package did not successfully complete"
  ok
}

main() {
  log_current_state
  validate
  chdir_and_exec build_and_package
  ok
}

[[ $BASH_SOURCE == $0 ]] && main
