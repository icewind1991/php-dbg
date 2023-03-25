#!/bin/bash

if [ ! -d php ]; then
  git clone https://github.com/docker-library/php
fi

patch -N -p1 -d php < debug.patch
patch -N -p1 -d php < version.patch

versions=("8.0" "8.1" "8.2")

cd php; ./apply-templates.sh

for version in "${versions[@]}"; do
  docker build -t icewind1991/php-debug:$version-fpm -f php/$version/bullseye/fpm/Dockerfile php/$version/bullseye/fpm
done