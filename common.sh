set -e

version=$(grep ansible== ./requirements.txt | awk -F'==' '{print $2}')
image="krzysztofmagosa/packer-ansible:${version}"

