#!/usr/bin/env bash
# Railway start wrapper for Crawl4AI.
set -euo pipefail

# Listen on Railway's PORT (the image's own default is 11235).
export CRAWL4AI_PORT="${CRAWL4AI_PORT:-${PORT:-11235}}"

# Crawl4AI only listens beyond loopback when an API token is set. Without one
# the public domain could never reach it, so fail loudly instead.
if [[ -z "${CRAWL4AI_API_TOKEN:-}" ]]; then
  echo "railway-start: CRAWL4AI_API_TOKEN is empty. Set it (the template generates one) and redeploy." >&2
  exit 1
fi

DATA="${CRAWL4_AI_BASE_DIRECTORY:-/data}"
mkdir -p "$DATA/redis" "$DATA/.crawl4ai"
chown appuser:appuser "$DATA" "$DATA/redis" "$DATA/.crawl4ai"
chown -R appuser:appuser "$DATA/.crawl4ai" "$DATA/redis"

# supervisord stays root so it can open the container's stdout/stderr; its
# config runs Redis and the API server as appuser.
export HOME=/home/appuser
cd /app
exec bash /app/entrypoint.sh
