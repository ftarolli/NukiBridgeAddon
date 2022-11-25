ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:11.1.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set workdir
WORKDIR /opt

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install requirements for add-on
RUN \
    apk add --no-cache --virtual .build-dependencies \
        libc-dev=0.7.2-r3 \
        py3-pip=20.3.4-r1 \
        python3-dev=3.9.15-r0 \
    \
    && apk add --no-cache \
        build-base=0.5-r3 \
        python3=3.9.15-r0 \
        libffi-dev=3.4.2-r1 \
        bluez=5.64-r0

COPY requirements.txt __main__.py nuki.py /opt/

# Install requirements for add-on
RUN pip install --no-cache-dir -r /opt/requirements.txt

# Copy data for add-on
COPY run.sh /
RUN chmod u+x /run.sh

CMD [ "/run.sh" ]
