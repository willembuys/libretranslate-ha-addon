#!/usr/bin/env bash
set -e
echo "📦 Starte LibreTranslate..."
mkdir -p /share/libretranslate/models
if [ ! -d "/share/libretranslate/models/de" ]; then
  echo "⬇️ Lade Sprachmodelle herunter..."
  libretranslate --update-models
fi
libretranslate --host 0.0.0.0 --port 5000 --load-only "" --models-dir /share/libretranslate/models