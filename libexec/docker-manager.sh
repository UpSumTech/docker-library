#!/bin/bash
# Docker manager

fullSrcDir() {
  echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
}
source "$( fullSrcDir )/utils.sh"

DockerManager() {
  require Class
  require DockerMachineManager
  _dockerManagerConstructor=$FUNCNAME

  DockerManager:new() {
    local this="$1"
    local constructor=$_dockerManagerConstructor
    Class:addInstanceMethod $constructor $this 'validate' 'DockerManager.validate'
    Class:addInstanceMethod $constructor $this 'clean' 'DockerManager.clean'
    Class:addInstanceMethod $constructor $this 'build' 'DockerManager.build'
    Class:addInstanceProperty $constructor $this imageNames "$( _sanitizeImageNames "$2" )"
  }

  _sanitizeImageNames() {
    if [[ "$1" =~ ^[a-zA-Z0-9_,]+\,$ ]]; then
      echo ${BASH_REMATCH[@]}
    else
      echo "$1",
    fi
  }

  DockerManager.validate() {
    local instance="$1"
    [[ ! -z $( command -v docker ) ]] || \
      Class:exception "Please install docker"
    [[ "$( eval "echo \$${instance}_imageNames" )" =~ ^[a-zA-Z0-9_\.:,-]+$ ]] || \
      Class:exception "Please install docker"
  }

  _stop() {
    eval "$( docker-machine env "$( DockerMachineManager:vmName )" )"
    docker ps -a -q | xargs -0 -I container docker stop container
  }

  _remove() {
    eval "$( docker-machine env "$( DockerMachineManager:vmName )" )"
    docker ps -a -q | xargs -0 -I container docker rm container
  }

  DockerManager.clean() {
    _stop && _remove
  }

  DockerManager.build() {
    local instance="$1"
    local imageNameWithTag
    local imageName
    local tagName
    local name
    local dockerDir
    local nonExistingDirs=()

    eval "$( docker-machine env "$( DockerMachineManager:vmName )" )"

    while read -r -d ',' imageNameWithTag; do
      if [[ "$imageNameWithTag" =~ [a-zA-Z0-9_\.-]+:[a-zA-Z0-9_\.-]+ ]]; then
        imageName="$( echo ${BASH_REMATCH[@]} | cut -d : -f1 )"
        tagName="$( echo ${BASH_REMATCH[@]} | cut -d : -f2 )"
        dockerDir="$( fullSrcDir )/../docker/$imageName/$tagName"
      else
        imageName="$imageNameWithTag"
        tagName=""
        dockerDir="$( fullSrcDir )/../docker/$imageName"
      fi

      name="sumanmukherjee03/$imageNameWithTag"

      if [[ -d "$dockerDir" ]]; then
        docker build -t="$name" "$dockerDir"
        docker push "$name"
      else
        nonExistingDirs+=( "$dockerDir" )
      fi
    done <<< "$( eval "echo \$${instance}_imageNames" )"

    [[ ${#nonExistingDirs[@]} -gt 0 ]] && \
      Class:exception "$( echo ${nonExistingDirs[*]} ) do not exist"
  }

  DockerManager:required() {
    export -f DockerManager:new
  }
  export -f DockerManager:required
}
