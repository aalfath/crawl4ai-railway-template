# Crawl4AI on Railway

This repo deploys [Crawl4AI](https://github.com/unclecode/crawl4ai) **0.9.5**, the open-source web crawler that turns pages into LLM-ready Markdown, as a Railway template.

## What it deploys

One service built from this repo's `Dockerfile`:

- `FROM unclecode/crawl4ai:0.9.5@sha256:0b05666882bfb67f45d559a5b827839c54127b74aedd723f8ab338a3571b5fc9`, the official image pinned by version and digest.
- `start.sh`, a small wrapper: it makes Crawl4AI listen on Railway's `PORT`, prepares the volume and starts the image's own entrypoint. Redis and the API server run as the image's non-root `appuser`.
- A volume at `/data` for the crawl cache (`/data/.crawl4ai`) and the in-container Redis job store (`/data/redis`).
- A public Railway domain with the health check on `/health`.

## Variables

| Variable | Default | What it does |
|---|---|---|
| `CRAWL4AI_API_TOKEN` | generated 64-character secret | Bearer token for every API call. Crawl4AI refuses to listen publicly without it. |
| `PORT` | `11235` | Port the API listens on. |

Optional, add them yourself when you need them:

- LLM extraction: `LLM_PROVIDER` (for example `openai/gpt-4o-mini`) plus that provider's key (`OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `GEMINI_API_TOKEN`, ...) or `LLM_API_KEY`.
- `CRAWL4AI_HOOKS_ENABLED=true` and `CRAWL4AI_EXECUTE_JS_ENABLED=true` turn on hooks and `/execute_js`. Both run caller-supplied code, so only enable them if you trust every token holder.

## Using it

```sh
curl -X POST https://YOUR-DOMAIN/crawl \
  -H "Authorization: Bearer $CRAWL4AI_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"urls": ["https://example.com"]}'
```

The playground is at `https://YOUR-DOMAIN/playground` and the monitor dashboard at `/dashboard` (both ask for the token). The MCP endpoint is `/mcp/sse`.

Give the service at least 2 GB of memory: each crawl runs a headless Chromium.

## Updates

Railway tells everyone who deployed this template when a change is merged to `main` here, and they choose when to apply it. Each update bumps the pinned image and adds an entry to [CHANGELOG.md](CHANGELOG.md); read it before you apply one.
