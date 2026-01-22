ARG BUILD_FROM
FROM ghcr.io/hassio-addons/base:19.0.0

# Set working directory
WORKDIR /app

# Install system dependencies required by LibreTranslate / Argos Translate
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-dev \
        build-essential \
        libicu-dev \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to avoid resolver errors
RUN python3 -m pip install --upgrade pip

# Install LibreTranslate
RUN pip3 install libretranslate

# Copy root filesystem
COPY rootfs /
