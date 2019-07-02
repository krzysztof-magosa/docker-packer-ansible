#!/bin/bash

set -e

version=$(grep ansible== ./requirements.txt | awk -F'==' '{print $2}')

docker build -t packer-ansible:${TRAVIS_COMMIT} .
docker tag packer-ansible:${TRAVIS_COMMIT} krzysztofmagosa/packer-ansible:${version}

if [ "${TRAVIS_BRANCH}" = "master" && "${TRAVIS_PULL_REQUEST}" = "false" ] ; then
  echo "push"
fi
