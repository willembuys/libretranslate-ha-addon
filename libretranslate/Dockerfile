# ===== Build stage =====
FROM python:3.11.11-slim-bullseye AS builder

WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
  && apt-get -qqq install --no-install-recommends -y pkg-config gcc g++ git wget curl bash \
  && apt-get upgrade --assume-yes \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python -m venv venv && ./venv/bin/pip install --no-cache-dir --upgrade pip

# Copy source code
COPY . .

# Install dependencies, compile translations
RUN ./venv/bin/pip install Babel==2.12.1 \
  && ./venv/bin/python scripts/compile_locales.py \
  && ./venv/bin/pip install torch==2.2.0 --extra-index-url https://download.pytorch.org/whl/cpu \
  && ./venv/bin/pip install "numpy<2" \
  && ./venv/bin/pip install . \
  && ./venv/bin/pip cache purge

# ===== Runtime stage =====
FROM python:3.11.11-slim-bullseye

WORKDIR /app

# Add a non-root user for Home Assistant
RUN addgroup --system --gid 1032 libretranslate \
    && adduser --system --uid 1032 libretranslate \
    && mkdir -p /home/libretranslate/.local \
    && chown -R libretranslate:libretranslate /home/libretranslate/.local

USER libretranslate

# Copy the built app and venv from builder
COPY --from=builder --chown=1032:1032 /app /app

# Copy run.sh
COPY --chown=1032:1032 run.sh /run.sh
RUN chmod +x /run.sh

# Expose API port
EXPOSE 5000

# Set PATH to use virtual environment
ENV PATH="/app/venv/bin:$PATH"

# Use run.sh as the entrypoint
ENTRYPOINT [ "/run.sh" ]
