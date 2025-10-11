#!/usr/bin/env bash
set -e

echo "run.sh gestartet"

# Standardwerte aus HA options
HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-5000}"
LANGUAGES="${LANGUAGES:-en,es,de,fr,it,zh}"
DEBUG="${DEBUG:-false}"
WEBUI="${WEBUI:-true}"
MODELS_DIR="/share/libretranslate/models"

echo "Konfiguration:"
echo "Host: $HOST"
echo "Port: $PORT"
echo "Sprachen: $LANGUAGES"
echo "Models directory: $MODELS_DIR"
echo "Debug: $DEBUG"
echo "WebUI: $WEBUI"

# Modelle persistent speichern
mkdir -p "$MODELS_DIR"

# Prüfen, ob Modelle existieren
MISSING_MODELS=false
for lang in $(echo $LANGUAGES | tr ',' ' '); do
  if [ ! -d "$MODELS_DIR/$lang" ]; then
    echo "Modell für $lang fehlt"
    MISSING_MODELS=true
  fi
done

# Modelle herunterladen, falls nötig
if [ "$MISSING_MODELS" = true ]; then
    echo "Lade fehlende Sprachmodelle"
    libretranslate --update-models --models-dir "$MODELS_DIR" $( [ "$DEBUG" = true ] && echo "--debug" )
else
    echo "Alle Modelle vorhanden"
fi

echo "Starte LibreTranslate"

# WebUI Flag setzen
WEBUI_FLAG=""
if [ "$WEBUI" != true ]; then
  WEBUI_FLAG="--disable-web-ui"
fi

exec libretranslate \
    --host "$HOST" \
    --port "$PORT" \
    --languages "$LANGUAGES" \
    --models-dir "$MODELS_DIR" \
    --load-only "" \
    $WEBUI_FLAG \
    $( [ "$DEBUG" = true ] && echo "--debug" )
