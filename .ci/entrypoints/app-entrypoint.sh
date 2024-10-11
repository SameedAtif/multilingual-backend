#!/bin/bash -e

# If running the rails server then create or migrate existing database
if [ "${1}" == "./bin/rails" ] && [ "${2}" == "server" ]; then
  ./bin/rails db:prepare
fi

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

export TMPDIR=/var/tmp
export TMP=/var/tmp
export TEMP=/var/tmp

bundle exec puma -C config/puma.rb

exec "${@}"
