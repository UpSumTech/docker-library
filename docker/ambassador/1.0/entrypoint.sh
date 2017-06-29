#!/bin/sh

env \
  | grep _TCP= \
  | (sed 's/.*_PORT_\([0-9]*\)_TCP=tcp:\/\/\(.*\):\(.*\)/socat -t 100000000 TCP4-LISTEN:\1,fork,reuseaddr TCP4:\2:\3 \&/'; echo wait) \
  | sh

env \
  | grep _UDP= \
  | (sed 's/.*_PORT_\([0-9]*\)_UDP=udp:\/\/\(.*\):\(.*\)/socat -t 100000000 UDP4-LISTEN:\1,fork,reuseaddr UDP4:\2:\3 \&/'; echo wait) \
  | sh
