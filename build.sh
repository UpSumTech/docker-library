#! /usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

trap "cd $ROOT_DIR" TERM

err() {
  echo >&2 "Error : $@"
  exit 1
}

validate() {
  local image="$1"
  local version="$2"
  [[ ! -z $DOCKERHUB_USERNAME ]] \
    || err "Please have \$DOCKERHUB_USERNAME exported in your shell"
  [[ ! -z $DOCKERHUB_PASSWORD ]] \
    || err "Please have \$DOCKERHUB_PASSWORD exported in your shell cause you cant push the images otherwise"
  [[ -f "$HOME/.docker/config.json" ]] \
    || err "You dont have docker configured on this user"
  test ! -z "$(cat "$HOME/.docker/config.json" | jq -r '.auths | .[] | .auth')" \
    || err "You are not logged into dockerhub"
  [[ -d "$ROOT_DIR/$image/$version" ]] \
    || err "The image and version provided doesnt exist"
}

main() {
  validate "$@"
  local image="$1"
  local version="$2"
  pushd .
  cd "$ROOT_DIR/$image/$version"
  docker build -t $DOCKERHUB_USERNAME/$image:$version .
  popd
}

[[ $BASH_SOURCE == $0 ]] && main "$@"
