#!/bin/sh

set -e

luarocks make --tree lua_modules
eval `luarocks --tree lua_modules path`

lua examples/handsome_server.lua&
pid=`echo $!`
echo "Server started with PID $pid"

sleep 2

trap \
  "kill -TERM $pid" \
  TERM EXIT

busted tests/*.lua
