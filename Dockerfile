# 1: Use ruby base:
FROM jruby:9.1

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update  -q && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client \
    nodejs

# 2: We'll set the application path as the working directory
WORKDIR /app

# 3: add the app's binaries path to $PATH:
ENV PATH=/app/bin:$PATH
