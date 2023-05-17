FROM debian:bullseye-slim as extract

LABEL org.opencontainers.image.source=https://github.com/ctxsh/containers/core
LABEL org.opencontainers.image.description="Core image"
LABEL org.opencontainers.image.licenses="Apache 2.0"

FROM debian:bullseye-slim

COPY requirements3.txt /tmp/requirements3.txt

RUN : \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        netcat \
        curl \
        jq \
        ca-certificates \
        python3-minimal \
        python3-venv \
        python3-pip \
    && pip3 install -r /tmp/requirements3.txt \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && rm -rf /tmp/* \
    && :

CMD ["/bin/bash"]