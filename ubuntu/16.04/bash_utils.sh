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

is_current_user_root() {
  if [[ "$(id -u)" == "0" ]]; then
    echo "User root : yes"
  else
    echo "User root: no"
  fi
}

log_disk_usage() {
  df -kh | grep -i -v 'filesystem' | awk '{print $1 ":" $5}'
  ok
}

log_os_info() {
  cat /etc/*-release
  uname -a
  ok
}

log_selinux_info() {
  command -v getenforce >/dev/null 2>&1 \
    && getenforce
  ok
}

log_ip_tables_info() {
  command -v iptables >/dev/null 2>&1 \
    && iptables -nvL -t filter \
    && iptables -nvL -t nat
  ok
}

log_installed_packages() {
  command -v rpm >/dev/null 2>&1 && rpm -qa
  command -v dpkg >/dev/null 2>&1 && dpkg --list
  ok
}

log_current_state() {
  log_user_and_group
  log_env_vars
  log_current_dir_content
  is_current_user_root
  log_disk_usage
  log_os_info
  log_selinux_info
  log_ip_tables_info
  log_installed_packages
  ok
}

export BASH_UTILS_SOURCED=1
