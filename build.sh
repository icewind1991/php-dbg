#!/bin/bash

if [ ! -d php ]; then
  git clone https://github.com/docker-library/php
fi

patch -N -p1 -d php < debug.patch

versions=("8.1" "8.2" "8.3")

cd php; DOCKER_PHP_ENABLE_DEBUG=1 ./apply-templates.sh

for version in "${versions[@]}"; do
  docker build -t icewind1991/php-debug:$version-fpm -f php/$version/bullseye/fpm/Dockerfile php/$version/bullseye/fpm
done
