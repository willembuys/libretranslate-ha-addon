ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-debian:latest
FROM $BUILD_FROM

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
    qt5-qmake \
    qtbase5-dev \
    qttools5-dev-tools \
    libqt5core5a \
    libqt5gui5 \
    libqt5widgets5 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Virtuelle Umgebung
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Python-Pakete
RUN pip install --upgrade pip
RUN pip install --no-cache-dir libretranslate argostranslate PyQt5 PyQt5-sip

# Startskript
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000
CMD ["/run.sh"]
