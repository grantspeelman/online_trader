# Online Trader

Build online trading communities

### Development using Docker

First install docker. [Install Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

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

## Licence

Licensed under the [MIT License](LICENCE.md).