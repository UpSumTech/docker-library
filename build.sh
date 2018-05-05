#! /usr/bin/env bash

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REGISTRY_OWNER=sumanmukherjee03

trap "cd $ROOT_DIR" TERM

err() {
  echo >&2 "Error : $@"
  exit 1
}

main() {
  local image="$1"
  local version="$2"
  [[ -d "$ROOT_DIR/$image/$version" ]] \
    || err "The image and version provided doesnt exist"
  pushd .
  cd "$ROOT_DIR/$image/$version"
  docker build -t $REGISTRY_OWNER/$image:$version .
  popd
}

[[ $BASH_SOURCE == $0 ]] && main "$@"
