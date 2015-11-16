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

getContainerPortMapping() {
  local hostPort="$1"
  local dockerPort="$2"
  local hostType="$3"
  if [[ "$( uname -s )" =~ Linux ]]; then
    require NetworkManager
    NetworkManager:new portMappingNM1
    if [[ "$hostType" =~ external ]]; then
      local hostIP="$( eval $portMappingNM1_getIP )"
      echo "$hostIP:$hostPort:$dockerPort"
    elif [[ "$hostType" =~ bridge ]]; then
      local bridgeIP="$( eval $portMappingNM1_getDockerBridgeIP )"
      echo "$bridgeIP:$hostPort:$dockerPort"
    elif [[ "$hostType" =~ local ]]; then
      echo "$hostPort:$dockerPort"
    else
      err "Host type is not valid for port mapping"
    fi
  else
    echo "$hostPort:$dockerPort"
  fi
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
    NetworkManager)
      source "$( fullSrcDir )/network-manager.sh"
      NetworkManager
      NetworkManager:required
      ;;
    DockerMachineManager)
      source "$( fullSrcDir )/docker-machine-manager.sh"
      DockerMachineManager
      DockerMachineManager:required
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
      echo "require "{Class\,,PathManager\,,DockerMachineManager\,,DockerManager\,,DockerContainerManager\,,NetworkManager}
      exit 1
  esac
}
