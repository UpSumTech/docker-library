#!/bin/bash
# Utility functions that can be sourced in other bash scripts

fullSrcDir() {
  echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
}

err() {
  echo "Error : $@" >/dev/stderr
  exit 1
}

splitWord() {
  local line="$2"
  local old_IFS="$IFS"
  IFS="$1"
  echo -n ${line}
  IFS="$old_IFS"
}

searchArray() {
  local testStr="$1"
  local array=( "${@:2}" )
  local i=1;

  for str in "${array[@]}"; do
    if [ "$str" = "$testStr" ]; then
      echo $i
      return
    else
      ((i++))
    fi
  done

  echo "-1"
}

require() {
  case "$1" in
    Class)
      source "$( fullSrcDir )/class.sh"
      Class
      Class:required
      ;;
    PathManager)
      source "$( fullSrcDir )/path-manager.sh"
      PathManager
      PathManager:required
      ;;
    Boot2DockerManager)
      source "$( fullSrcDir )/boot2docker-manager.sh"
      Boot2DockerManager
      Boot2DockerManager:required
      ;;
    DockerManager)
      source "$( fullSrcDir )/docker-manager.sh"
      DockerManager
      DockerManager:required
      ;;
    DockerContainerManager)
      source "$( fullSrcDir )/docker-container-manager.sh"
      DockerContainerManager
      DockerContainerManager:required
      ;;
    *)
      echo -n "Usages: "
      echo "require "{Class\,,PathManager\,,Boot2DockerManager\,,DockerManager\,,DockerContainerManager\,,NetworkManager}
      exit 1
  esac
}
