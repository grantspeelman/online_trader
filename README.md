# Online Trader

[![Maintainability](https://api.codeclimate.com/v1/badges/a9e233125e997a03e374/maintainability)](https://codeclimate.com/github/grantspeelman/online_trader/maintainability)

[![Build Status](https://travis-ci.org/grantspeelman/online_trader.svg?branch=master)](https://travis-ci.org/grantspeelman/online_trader)

Build online trading communities

Running on heroku: https://collect-and-swap.herokuapp.com/

### Development setup using Docker

setup code analysis 

```bash
  BUNDLE_GEMFILE=Gemtools bundle install # not recommended to be added to Gemfile
  overcommit --install && overcommit --sign && overcommit --sign pre-commit
```

install docker. [Install Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

```bash
docker-compose build
docker-compose run --rm app bin/setup
docker-compose up # server on http://localhost:9292
```

Running tests
```bash
docker-compose run --rm app bin/rake

# or start a bash console inside docker and run commands
docker-compose run --rm app bash
bin/rake
```

Running cypress
```bash
npm install

docker-compose up -d
node_modules/.bin/cypress open -P spec
```

## Licence

Licensed under the [MIT License](LICENCE.md).