FROM hashicorp/packer:1.4.3

MAINTAINER Krzysztof Magosa <krzysztof@magosa.pl>

ADD ./requirements.txt ./
ADD ./entrypoint.sh /bin/

RUN \
  apk add --no-cache \
    python2 \
    libffi \
    openssl \
    openssh \
    coreutils \
    tar \
    docker && \
  apk add --no-cache --virtual dev-dependencies \
    python2-dev \
    py-pip \
    gcc \
    g++ \
    libffi-dev \
    openssl-dev \
    make && \
  pip install -r ./requirements.txt && \
  apk del dev-dependencies && \
  rm -f ./requirements.txt && \
  adduser -S app -G root -h /home

ADD --chown=app:root ./known_hosts /home/.ssh/known_hosts

USER app
ENTRYPOINT ["/bin/entrypoint.sh"]

