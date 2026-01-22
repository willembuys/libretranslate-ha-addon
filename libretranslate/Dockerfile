# Use Debian-based image for reliable Python + ICU + ML package support
FROM debian:stable-slim

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies required by LibreTranslate / Argos Translate
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-dev \
        build-essential \
        libicu-dev \
        ca-certificates \
        curl \
        git \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to avoid old package resolver issues
RUN python3 -m pip install --upgrade pip

# Install LibreTranslate + Argos Translate
RUN pip3 install libretranslate

# Ensure models directory exists and is writable
RUN mkdir -p /share/libretranslate/models

# Expose API port
EXPOSE 5000

# Run LibreTranslate with default host binding
CMD ["libretranslate", "--host", "0.0.0.0"]
