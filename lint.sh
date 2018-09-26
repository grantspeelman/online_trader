#!/usr/bin/env bash
set -eo pipefail

echo '--- install and run overcommit'
export BUNDLE_GEMFILE=Gemtools
bundle install
bin/overcommit --run
