#! /usr/bin/env bash

[[ -f /usr/local/share/bash_utils.sh && $BASH_UTILS_SOURCED -neq 1 ]] && . /usr/local/share/bash_utils.sh

validate() {
  [[ ! -z "$PASSWD" ]] || die "PASSWD was not provided"
}

main() {
  local configFile="$PGCONFIG/postgresql.conf"
  validate
  gosu postgres initdb -D "$PGDATA" -E 'UTF-8'
  local cmd="gosu postgres postgres --single -jE --config-file=$configFile"
  $cmd <<< "CREATE USER root WITH SUPERUSER;" > /dev/null
  $cmd <<< "ALTER USER root WITH PASSWORD '$PASSWD';" > /dev/null
  $cmd <<< "CREATE DATABASE root;" > /dev/null
  set -- "$@" --config-file="$configFile" -D "$PGDATA"
  exec gosu postgres "$@"
}

if [ "${1:0:1}" = '-' ]; then
  set -- postgres "$@"
fi

if [[ "$1" = 'postgres' ]]; then
  main "$@"
else
  exec "$@"
fi
