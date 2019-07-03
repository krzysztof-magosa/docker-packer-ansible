FROM hashicorp/packer:1.4.2

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
    tar && \
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
  adduser -S data

USER data
ENTRYPOINT ["/bin/entrypoint.sh"]

