ARG BUILD_FROM=python:3.11.11-slim-bullseye AS builder
FROM $BUILD_FROM

# Arbeitsverzeichnis
WORKDIR /app

# Systemabhängigkeiten installieren
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-venv \
    python3-pip \
    build-essential \
    git \
    wget \
    curl \
    bash \
    pkg-config \
    g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# LibreTranslate klonen
RUN git clone --depth 1 https://github.com/LibreTranslate/LibreTranslate.git /app

# Virtuelle Umgebung
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Pip aktualisieren
RUN pip install --upgrade pip

# Python-Abhängigkeiten installieren
RUN pip install --no-cache-dir \
    Babel==2.12.1 \
    torch==2.2.0 --extra-index-url https://download.pytorch.org/whl/cpu \
    "numpy<2" \
    argostranslate \
    libretranslate

# Übersetzungen kompilieren
RUN python scripts/compile_locales.py

# Run-Skript kopieren und ausführbar machen
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Ports freigeben
EXPOSE 5000

# Add-on Start
CMD ["/run.sh"]
