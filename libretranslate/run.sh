#!/usr/bin/env bash
set -e
ls -l /app/
# Lade bashio helper
if [ -f /usr/lib/bashio/bashio.sh ]; then
  source /usr/lib/bashio/bashio.sh
else
  # Fallback: minimal environment variables if bashio nicht verfügbar
  echo "Info: bashio not found, falling back to env vars"
  bashio=false
fi

# Helper: read config via bashio or env
if [ "${bashio:-false}" != false ]; then
  HOST="$(bashio::config 'host')"
  PORT="$(bashio::config 'port')"
  LANGUAGES="$(bashio::config 'languages')"
  DEBUG="$(bashio::config 'debug')"
else
  HOST="${HOST:-0.0.0.0}"
  PORT="${PORT:-5000}"
  LANGUAGES="${LANGUAGES:-en,es,de,fr,it,zh}"
  DEBUG="${DEBUG:-false}"
fi

# Logging helper
log() {
  if [ "${bashio:-false}" != false ]; then
    bashio::log.info "$1"
  else
    echo "$1"
  fi
}

log "LibreTranslate add-on starting"
log "Host=${HOST} Port=${PORT} Languages='${LANGUAGES}' Debug=${DEBUG}"

MODELS_DIR="/share/libretranslate/models"
mkdir -p "$MODELS_DIR"

# Prüfen und ggf. fehlende Modelle herunterladen
MISSING=false
IFS=',' read -ra LANG_LIST <<< "$LANGUAGES"
for lang in "${LANG_LIST[@]}"; do
  lang_trimmed="$(echo "$lang" | xargs)"
  if [ -z "$lang_trimmed" ]; then
    continue
  fi
  if [ ! -d "$MODELS_DIR/$lang_trimmed" ]; then
    log "Missing model for: $lang_trimmed"
    MISSING=true
  else
    log "Model exists for: $lang_trimmed"
  fi
done

if [ "$MISSING" = true ]; then
  log "Downloading missing models..."
  if [ "$DEBUG" = true ] || [ "$DEBUG" = "true" ]; then
    libretranslate --update-models --models-dir "$MODELS_DIR" --debug
  else
    libretranslate --update-models --models-dir "$MODELS_DIR"
  fi
else
  log "All configured models present"
fi

log "Starting LibreTranslate (foreground) on ${HOST}:${PORT}"
# Start im Vordergrund; exec sorgt, dass stdout/stderr an Supervisor weitergeleitet wird
if [ "$DEBUG" = true ] || [ "$DEBUG" = "true" ]; then
  exec libretranslate --host "${HOST}" --port "${PORT}" --models-dir "${MODELS_DIR}" --load-only "${LANGUAGES}" --debug
else
  exec libretranslate --host "${HOST}" --port "${PORT}" --models-dir "${MODELS_DIR}" --load-only "${LANGUAGES}"
fi
