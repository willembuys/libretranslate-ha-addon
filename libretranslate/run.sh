#!/usr/bin/env bash
set -e

echo "📦 Starte LibreTranslate..."

HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-5000}"
LANGUAGES="${LANGUAGES:-en,es,de,fr,it,zh}"
MODELS_DIR="/share/libretranslate/models"

mkdir -p "$MODELS_DIR"

# Prüfen und ggf. Modelle herunterladen
for LANG in $(echo "$LANGUAGES" | tr ',' ' '); do
    if [ ! -d "$MODELS_DIR/$LANG" ]; then
        echo "⬇️ Lade Modell für $LANG herunter..."
        libretranslate --update-models --models-dir "$MODELS_DIR" --load-only "$LANG"
    fi
done

echo "🚀 Starte LibreTranslate..."
echo "Host: $HOST"
echo "Port: $PORT"
echo "Languages: $LANGUAGES"
echo "Models directory: $MODELS_DIR"

exec libretranslate \
    --host "$HOST" \
    --port "$PORT" \
    --languages "$LANGUAGES" \
    --models-dir "$MODELS_DIR" \
    --load-only ""
