# LibreTranslate Add-on für Home Assistant
ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM $BUILD_FROM

WORKDIR /app

# ==== Systemabhängigkeiten installieren ====
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-virtualenv \
    g++ \
    make \
    cmake \
    qt5-qtbase-dev \
    qt5-qttools-dev \
    py3-pyqt5 \
    py3-sip \
    bash \
    git

# ==== Virtuelle Umgebung für Python einrichten ====
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# ==== Python-Abhängigkeiten installieren ====
# --break-system-packages optional, falls keine venv aktiv
RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir libretranslate argostranslate

# ==== Startskript hinzufügen ====
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000
CMD ["/run.sh"]
