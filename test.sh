#!/usr/bin/env bash
set -eo pipefail

echo '--- testing rails 3.2'
export SECRET_TOKEN="blueblahblueblahblueblahblueblahblueblahblueblahblueblahblueblahblueblahblueblah"
export RAILS_ENV=test
export CYPRESS="1"

echo '-- start rails server'
bin/rails server -p 5002 -e test &
sleep 10 # give rails a chance to start up correctly

echo '-- cypress run'
node_modules/.bin/cypress install
if [ -z $CYPRESS_RECORD_KEY ]
then
    node_modules/.bin/cypress run -P spec
else
    node_modules/.bin/cypress run -P spec --record
fi

echo '-- stop rails server'
kill `cat tmp/pids/server.pid`
