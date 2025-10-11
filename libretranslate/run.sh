#!/usr/bin/env bash
set -e
source /usr/lib/bashio/bashio.sh

bashio::log.info "LibreTranslate Add-on wird gestartet..."

HOST="$(bashio::config 'host')"
PORT="$(bashio::config 'port')"
LANGUAGES="$(bashio::config 'languages')"
DEBUG="$(bashio::config 'debug')"

MODELS_DIR="/share/libretranslate/models"
mkdir -p "$MODELS_DIR"

if [ "$DEBUG" = "true" ]; then
  set -x
  bashio::log.info "DEBUG aktiviert"
  bashio::log.info "Host = $HOST"
  bashio::log.info "Port = $PORT"
  bashio::log.info "Languages = $LANGUAGES"
fi

bashio::log.info "Starte LibreTranslate Server..."
exec libretranslate \
  --host "$HOST" \
  --port "$PORT" \
  --models-dir "$MODELS_DIR" \
  --load-only "$LANGUAGES"
