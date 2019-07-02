#!/bin/bash

. ./common.sh

docker build -t packer-ansible:${TRAVIS_COMMIT} .
docker tag packer-ansible:${TRAVIS_COMMIT} ${image}
