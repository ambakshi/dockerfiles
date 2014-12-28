#!/bin/sh

set -ex

GIT_PULL=${GIT_PULL:-false}
if $GIT_PULL; then
    git pull
fi

sudo bundle exec fpm-cook package recipe.rb
