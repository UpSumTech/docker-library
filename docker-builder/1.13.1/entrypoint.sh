#! /usr/bin/env bash

DOCKER_SOCKET="/var/run/docker.sock"

export MAIN_PID="$$"
die() {
  echo >&2 "ERROR >> $1"
  kill -s TERM "$MAIN_PID"
  exit 1
}

ok() {
  echo -n ''
}

validate() {
  command -v docker \
    || die "docker is not installed"
  ls -lah $DOCKER_SOCKET
  [[ -e $DOCKER_SOCKET ]] \
    || die "docker socket is not present"
  curl -ivs --unix-socket $DOCKER_SOCKET http://localhost/version \
    || die "cant communicate with the docker socket"
  ok
}

main() {
  validate
  docker images
}

[[ $BASH_SOURCE == $0 ]] && main "$@"
