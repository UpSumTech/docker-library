#! /usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

trap "cd $ROOT_DIR" TERM

[[ -f utils.sh ]] && . utils.sh

validate() {
  local image="$1"
  local version="$2"
  [[ ! -z $DOCKERHUB_USERNAME ]] \
    || die "Please have \$DOCKERHUB_USERNAME exported in your shell"
  [[ ! -z $DOCKERHUB_PASSWORD ]] \
    || die "Please have \$DOCKERHUB_PASSWORD exported in your shell cause you cant push the images otherwise"
  [[ -f "$HOME/.docker/config.json" ]] \
    || die "You dont have docker configured on this user"
  test ! -z "$(cat "$HOME/.docker/config.json" | jq -r '.auths | .[] | .auth')" \
    || die "You are not logged into dockerhub"
  [[ -d "$ROOT_DIR/$image/$version" ]] \
    || die "The image and version provided doesnt exist"
}

build_and_push() {
  local image="$1"
  local version="$2"
  cd "$ROOT_DIR/$image/$version"
  docker build -t $DOCKERHUB_USERNAME/$image:$version .
  docker push $DOCKERHUB_USERNAME/$image:$version
  ok
}

main() {
  local image="$1"
  local version="$2"
  validate "$@"
  chdir_and_exec build_and_push "$image" "$version"
}

[[ $BASH_SOURCE == $0 ]] && main "$@"
