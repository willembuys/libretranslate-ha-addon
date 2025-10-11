#!/usr/bin/env bash
set -e

echo "run.sh gestartet"

# Optionen aus HA
HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-5000}"
LANGUAGES="${LANGUAGES:-en,es,de,fr,it,zh}"
DEBUG="${DEBUG:-false}"
MODELS_DIR="/share/libretranslate/models"

echo "Konfiguration:"
echo "Host: $HOST"
echo "Port: $PORT"
echo "Sprachen: $LANGUAGES"
echo "Models directory: $MODELS_DIR"
echo "Debug: $DEBUG"

# Persistente Modelle
mkdir -p "$MODELS_DIR"

# Prüfen auf fehlende Modelle
MISSING_MODELS=false
for lang in $(echo $LANGUAGES | tr ',' ' '); do
  if [ ! -d "$MODELS_DIR/$lang" ]; then
    echo "Modell für $lang fehlt"
    MISSING_MODELS=true
  fi
done

# Modelle laden, falls nötig
if [ "$MISSING_MODELS" = true ]; then
    echo "Lade fehlende Sprachmodelle"
    libretranslate --update-models --models-dir "$MODELS_DIR" $( [ "$DEBUG" = true ] && echo "--debug" )
else
    echo "Alle Modelle vorhanden"
fi

echo "Starte LibreTranslate mit Ingress"
exec libretranslate \
    --host "$HOST" \
    --port "$PORT" \
    --languages "$LANGUAGES" \
    --models-dir "$MODELS_DIR" \
    --load-only "" \
    $( [ "$DEBUG" = true ] && echo "--debug" )
