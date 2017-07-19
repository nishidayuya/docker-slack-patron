#!/bin/sh

set -e

# envsubst is not support default variables.
env -- \
  SP_DEFAULT_CHANNEL=${SP_DEFAULT_CHANNEL-general} \
  SP_ENABLE_PRIVATE_CHANNEL=${SP_ENABLE_PRIVATE_CHANNEL-true} \
  SP_ENABLE_DIRECT_MESSAGE=${SP_ENABLE_DIRECT_MESSAGE-true} \
  SP_DATABASE_URI=${SP_DATABASE_URI-mongo:27017} \
  SP_DATABASE_DATABASE=${SP_DATABASE_DATABASE-slack_logger} \
  SP_REDIS_URL=${SP_REDIS_URL-redis://redis:6379} \
  SP_REDIS_NAMESPACE=${SP_REDIS_NAMESPACE-sidekiq} \
  envsubst < config.yml.template > config.yml

bundle exec ruby logger/logger.rb

exec bundle exec rackup viewer/config.ru -o 0.0.0.0 -p 9292
