#! /usr/bin/env bash

set -e -o pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[[ -f utils.sh ]] && . utils.sh

IMAGES=( \
  "ubuntu:20.04" \
  "rbenv:1.1.2" \
  "ruby:2.7.2" \
  "rails:6.0.3.4" \
  "rails:onbuild-6.0.3.4" \
  "nvm:v0.36.0" \
  "node:v12.19.0" \
  "node:onbuild-v12.19.0" \
  "mysql:8.0" \
  "postgres:12.4" \
  "nginx:1.18.0" \
  "ambassador:1.0" \
  "goenv:latest" \
  "golang:1.14.0" \
  "golang:onbuild-1.14.0" \
  "artifact-volume:1.0" \
  "docker-builder:19.03.8"
)

main() {
  local image_and_version
  local image
  local version
  for image_and_version in "${IMAGES[@]}"; do
    image="$(echo $image_and_version | cut -d ':' -f1)"
    version="$(echo $image_and_version | cut -d ':' -f2)"
    echo;echo;echo ">>>>>>>>>>>>>>>>> Building $image:$version <<<<<<<<<<<<<<<<<<<<<<<"
    /usr/bin/env bash $ROOT_DIR/build.sh "$image" "$version"
    echo ">>>>>>>>>>>>>>>>>> Finished building $image:$version <<<<<<<<<<<<<<<<<<<<<<<"
    sleep 10;
  done
  echo; echo; echo "Successfully built and pushed all images"
}

[[ $BASH_SOURCE == $0 ]] && main "$@"
