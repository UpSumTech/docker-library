#! /usr/bin/env bash

[[ -f "/usr/local/share/bash_utils.sh" && ! $BASH_UTILS_SOURCED -eq 1 ]] && . "/usr/local/share/bash_utils.sh"

DOCKER_SOCKET="/var/run/docker.sock"
DOCKER_CONFIG="$HOME/.docker/config.json"

validate() {
  [[ "$(id -u)" == "0" ]] \
    || die "container is not running as root"
  command -v docker \
    || die "docker is not installed"
  [[ -e $DOCKER_SOCKET ]] \
    || die "docker socket is not present"
  curl -ivs --unix-socket $DOCKER_SOCKET http://localhost/version \
    || die "cant communicate with the docker socket"
  [[ -f "$DOCKER_CONFIG" ]] \
    || die "docker config not present"
  [[ ! -z "$(cat "$DOCKER_CONFIG" | jq -r ".auths | .[] | .auth")" ]] \
    || die "not logged into docker registry"
  ok
}

main() {
  log_current_state
  validate
  docker images
}

[[ $BASH_SOURCE == $0 ]] && main "$@"
