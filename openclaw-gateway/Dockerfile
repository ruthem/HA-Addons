# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Node.js 22, OpenClaw and tools
RUN apk add --no-cache \
    nodejs \
    npm \
    curl \
    ca-certificates \
    git \
    jq \
    openssh-client \
    build-base \
    python3 \
  && npm install -g openclaw \
  && npm cache clean --force \
  && rm -rf /tmp/* /root/.npm

# Copy root filesystem
COPY rootfs /

WORKDIR /config/openclaw