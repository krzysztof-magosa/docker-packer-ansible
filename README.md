# Packer with Ansible - Docker Image

[![Build Status](https://travis-ci.org/krzysztof-magosa/docker-packer-ansible.svg?branch=master)](https://travis-ci.org/krzysztof-magosa/docker-packer-ansible)
[![Docker Pulls](https://img.shields.io/docker/pulls/krzysztofmagosa/packer-ansible.svg)](https://hub.docker.com/r/krzysztofmagosa/packer-ansible)

Image has been created to allow creating system images using companion of two great tools - Packer and Ansible.
Everything is included inside, along with simple helper for Ansible Galaxy.

## Ansible Galaxy
Image automatically runs `ansible-galaxy install` if it detects `requirements.yml` file to ensure all
roles are installed prior to playbook run. If you want to manage roles manually or externally you can
disable this behaviour by setting environment variable `GALAXY_REQUIREMENTS` to `no`. If you have
requirements defined in different file you can override it using `GALAXY_REQUIREMENTS` environment variable.

## Tags
Tags are matching Ansible version included inside.
New image should be available up to few days after Ansible releases new version.
Click [here](https://hub.docker.com/r/krzysztofmagosa/packer-ansible/tags) to see what's available.

## File access
Local files are not available by default to applications running inside container.
You need to use Docker volumes to expose them. I assume `/data` will be used for this purpose,
image itself will never use it to avoid clashes. Home directory is set to `/home`,
in case you want e.g. to pass SSH private key. I recommend you use `-w /data` altogether with 
`$(pwd)` used as volume source, so local `.` points to the same place as `.` inside container - that makes things easier.

## Credentials
Packer may need credentials to access Cloud resources.
You may either use `-e NAME=VALUE` or `--env-file FILE` to pass them via environment variables as required.

## Usage
Building image:
```
$ docker run -v $(pwd):/data -w /data --env-file packer.env krzysztofmagosa/packer-ansible:2.8.1 build packer.json
```

Building image, private SSH key used (e.g. if you use private Git repositories with roles):
```
$ docker run -v $(pwd):/data -w /data -v $HOME/.ssh/id_rsa:/home/.ssh/id_rsa --env-file packer.env krzysztofmagosa/packer-ansible:2.8.1 build packer.json
```

## Notes
Image is based on official [Hashicorp Packer image](https://github.com/hashicorp/docker-hub-images/tree/master/packer).
[Ansible](https://github.com/ansible/ansible) is installed via PIP, using Python 2.x.
