#!/usr/bin/env bash
set -eo pipefail

echo '--- install'
export BUNDLE_GEMFILE=Gemtools
bundle install

echo '--- run rubocop'
bundle exec rubocop

echo '--- run reek'
bundle exec reek
