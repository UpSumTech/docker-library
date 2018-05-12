#! /usr/bin/env bash

err() {
  echo >&2 "ERROR >> $1"
  exit 1
}

export MAIN_PID="$$"
die() {
  echo >&2 "ERROR >> $1"
  kill -s TERM "$MAIN_PID"
  exit 1
}

ok() {
  echo -n ''
}

chdir_and_exec() {
  local result
  local fn="$1"
  shift 1
  pushd .
  result=$(eval "$(declare -F "$fn")" "$@")
  popd
  echo "$result"
}

log_user_and_group() {
  echo "User id : $(id -u)"
  echo "Group id : $(id -g)"
  echo "User name : $(id -un)"
  echo "Group name : $(id -gn)"
  ok
}

log_env_vars() {
  printenv
  ok
}

log_current_dir_content() {
  echo "Current Dir : $(pwd)"
  ls -lah
  ok
}

log_current_state() {
  log_user_and_group
  log_env_vars
  log_current_dir_content
  ok
}

export BASH_UTILS_SOURCED=1
