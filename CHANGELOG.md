# Changelog

Each entry is one version of this Railway template. Breaking changes come first.

## 0.9.5-1 (2026-11-16)

- README: add the Deploy on Railway button for the published template `crawl4ai-3`. No change to the service.

## 0.9.5 (2026-11-16)

- First release: Crawl4AI 0.9.5, official image `unclecode/crawl4ai:0.9.5@sha256:0b05666882bfb67f45d559a5b827839c54127b74aedd723f8ab338a3571b5fc9`.
- Listens on Railway's `PORT`, requires `CRAWL4AI_API_TOKEN` (the template generates it), health check on `/health`.
- Crawl cache and Redis job store on a volume at `/data`.
