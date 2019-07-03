#!/bin/sh

requirements="${GALAXY_REQUIREMENTS:-requirements.yml}"

if [ -f "${requirements}" ] && [ "$1" = "build" ] && [ "${GALAXY_ENABLED}" != "no" ] ; then
  echo "Running Ansible Galaxy..."
  echo "Set GALAXY_ENABLED=no if you want to omit this step."
  ansible-galaxy install -r "${requirements}"
fi

/bin/packer $@
