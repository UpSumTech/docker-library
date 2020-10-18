#! /usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
  local fn="$1"
  shift 1
  pushd .
  eval "$(declare -F "$fn")" "$@"
  popd
}

chdir_run_and_ret_res() {
  local result
  local fn="$1"
  shift 1
  pushd .
  result=$(eval "$(declare -F "$fn")" "$@")
  popd
  echo "$result"
}

wait_till_done() {
  local fn="$1"
  shift 1
  (eval "$(declare -F "$fn")" "$@") &
  wait
  ok
}
