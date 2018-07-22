#!/usr/bin/env bash
#!/usr/bin/env bash
set -eo pipefail

echo '--- testing rails 3.2'

echo '-- start rails server'
bundle exec ./bin/rails server -p 5002 -e test &
sleep 2 # give rails a chance to start up correctly

echo '-- cypress run'
node_modules/.bin/cypress run

echo '-- stop rails server'
kill -9 `cat tmp/pids/server.pid`