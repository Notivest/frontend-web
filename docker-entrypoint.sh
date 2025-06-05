#!/usr/bin/env bash
set -euo pipefail

# Requiere que se pasen LAS variables en tiempo de ejecución
#   NEW_RELIC_BROWSER_KEY
#   NEW_RELIC_APP_ID
: "${NEW_RELIC_BROWSER_KEY:?Env var NEW_RELIC_BROWSER_KEY missing}"
: "${NEW_RELIC_APP_ID:?Env var NEW_RELIC_APP_ID missing}"

find /usr/share/nginx/html -type f \( -name '*.js' -o -name '*.html' \) -print0 |
  xargs -0 sed -i \
    -e "s/_NR_KEY_PLACEHOLDER_/${NEW_RELIC_BROWSER_KEY}/g" \
    -e "s/_NR_APPID_PLACEHOLDER_/${NEW_RELIC_APP_ID}/g"

echo "↪ New Relic Browser variables inyectadas. Iniciando Nginx…"
exec "$@"
