ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set working directory
WORKDIR /app

# Install system dependencies required by LibreTranslate / Argos Translate
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-dev \
        python3-venv \
        build-essential \
        libicu-dev \
        curl && \
      rm -rf /var/lib/apt/lists/*

# Install LibreTranslate
RUN pip3 install libretranslate

# Copy root filesystem
COPY rootfs /
