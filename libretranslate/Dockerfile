ARG BUILD_FROM
FROM $BUILD_FROM

# Arbeitsverzeichnis
WORKDIR /app

# Systemabhängigkeiten installieren
# RUN apk update && apk upgrade
RUN apk add python3 py3-pip icu-dev g++ make
# RUN apk add python3 py3-pip icu-dev qt5-qtbase-dev g++ make py3-qt5 pyqt5-dev
# currently not working: PyQt5 cant be installed
# RUN pip install PyQt5==5.15.4 --config-settings --confirm-license= --verbose
RUN pip install libretranslate

# Copy root filesystem
COPY rootfs /
