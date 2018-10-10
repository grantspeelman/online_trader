# 1: Use ruby base:
FROM ruby:2.5

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >> /etc/apt/sources.list.d/pgdg.list && \
    apt-get update  -q && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client-10 \
    nodejs

WORKDIR /app

ENV PATH=/app/bin:$PATH
