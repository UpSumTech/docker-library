#! /usr/bin/env bash

[[ -f /usr/local/share/bash_utils.sh && $BASH_UTILS_SOURCED -neq 1 ]] && . /usr/local/share/bash_utils.sh

DOCKER_SOCKET="/var/run/docker.sock"

validate() {
  command -v docker \
    || die "docker is not installed"
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
