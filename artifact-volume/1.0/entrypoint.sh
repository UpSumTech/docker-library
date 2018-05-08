#! /usr/bin/env bash

main() {
  echo "Running artifact volume server"
  while true; do
    nc -l -p $EXPOSED_PORT -c 'echo -e "HTTP/1.1 200 OK\n\n $(date)"'
  done
}

[[ $BASH_SOURCE == $0 ]] && main "$@"
