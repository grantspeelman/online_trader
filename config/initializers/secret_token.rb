# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
OnlineTrader::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || '84a47196fcc71ae77c9ed9a621f45585bac1cda5fc9fea4a10a2be56dd925d49a69273ab768143c21d6dd9ea7798787e46110697cea02e77430a9c319157a617'
