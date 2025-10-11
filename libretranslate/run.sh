#!/usr/bin/env bash
set -e

# ==== LibreTranslate Add-on Startup Script ====
echo "LibreTranslate Add-on wird gestartet..."

# Hole Optionen aus der Home Assistant Add-on-Konfiguration
HOST="$(bashio::config 'host')"
PORT="$(bashio::config 'port')"
LANGUAGES="$(bashio::config 'languages')"
DEBUG="$(bashio::config 'debug')"

MODELS_DIR="/share/libretranslate/models"
mkdir -p "$MODELS_DIR"

# Debug-Ausgabe aktivieren, falls konfiguriert
if [ "$DEBUG" = "true" ]; then
  set -x
  echo "DEBUG: Aktiver Debug-Modus"
  echo "DEBUG: Host = $HOST"
  echo "DEBUG: Port = $PORT"
  echo "DEBUG: Languages = $LANGUAGES"
  echo "DEBUG: Models directory = $MODELS_DIR"
fi

# === Modelle vorbereiten ===
echo "Prüfe, ob Sprachmodelle vorhanden sind..."
MISSING=false
IFS=',' read -ra LANG_LIST <<< "$LANGUAGES"
for lang in "${LANG_LIST[@]}"; do
    lang_trimmed="$(echo "$lang" | xargs)"  # trim spaces
    if [ ! -d "$MODELS_DIR/$lang_trimmed" ]; then
        echo "Fehlendes Modell für Sprache: $lang_trimmed"
        MISSING=true
    fi
done

if [ "$MISSING" = "true" ]; then
    echo "Lade fehlende Modelle herunter..."
    libretranslate --update-models --models-dir "$MODELS_DIR"
else
    echo "Alle Modelle bereits vorhanden."
fi

# === Server starten ===
echo "Starte LibreTranslate..."
echo "Erreichbar unter: http://$HOST:$PORT"

exec libretranslate \
    --host "$HOST" \
    --port "$PORT" \
    --models-dir "$MODELS_DIR" \
    --load-only "$LANGUAGES"
