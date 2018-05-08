#! /usr/bin/env bash

set -e -o pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[[ -f utils.sh ]] && . utils.sh

IMAGES=( \
  "ubuntu:16.04" \
  "rbenv:1.1.1" \
  "ruby:2.5.1" \
  "rails:5.2.0" \
  "rails:onbuild-5.2.0" \
  "nvm:v0.33.11" \
  "node:v8.11.1" \
  "node:onbuild-v8.11.1" \
  "mysql:5.7" \
  "postgres:9.6" \
  "nginx:1.10" \
  "nginx:passenger-nginx-1.10" \
  "ambassador:1.0" \
  "goenv:1.12.0" \
  "golang:1.10.0" \
  "golang:onbuild-1.10.0" \
  "artifact-volume:1.0" \
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
    echo ">>>>>>>>>>>>>>>>> Finished building $image:$version <<<<<<<<<<<<<<<<<<<<<<<"
  done
  echo; echo; echo "Successfully built and pushed all images"
}

[[ $BASH_SOURCE == $0 ]] && main "$@"
