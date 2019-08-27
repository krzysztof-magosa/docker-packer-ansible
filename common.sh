set -e

TRAVIS_COMMIT="${TRAVIS_COMMIT:-$(git rev-parse HEAD)}"

version=$(grep ansible== ./requirements.txt | awk -F'==' '{print $2}')
image="krzysztofmagosa/packer-ansible:${version}"

