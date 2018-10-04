# 1: Use ruby base:
FROM jruby:9.1

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >> /etc/apt/sources.list.d/pgdg.list && \
    apt-get update  -q && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client-10 \
    nodejs

RUN useradd -m deploy

WORKDIR /app

ENV PATH=/app/bin:$PATH

COPY Gemfile* ./
RUN bundle config --global github.https true
RUN bundle install -j $(nproc) --retry 5 --no-cache --without development test

COPY . .

RUN NO_DB_CONNECT="1" \
    RAILS_ENV=production \
    bundle exec rake assets:precompile

RUN mkdir -p tmp
RUN chown deploy tmp

RUN chown -R deploy /usr/local/bundle

USER deploy

CMD jruby -J-Xmx480m -G bin/rails server
