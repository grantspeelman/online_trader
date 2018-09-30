# 1: Use ruby base:
FROM jruby:9.1

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update  -q && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client \
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

USER deploy

CMD jruby -J-Xmx480m -G bin/rails server
