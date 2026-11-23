# Changelog

Each entry is one version of this Railway template. Breaking changes come first.

## 0.9.6 (2026-11-23)

- Breaking changes: the default LLM provider is now `openai/gpt-6-luna` and LLM calls no longer send `temperature: 0.01`. This only matters if you call the LLM extraction endpoints without naming a provider. No new variables.
- Security release: closes nine advisories in the Docker server (an SSRF path, browser contexts and hooks shared between callers, a ReDoS bypass, unchecked markdown options, chunked bodies past the size limit, and more) and raises dependency floors for a vulnerable Brotli decoder. See the [0.9.6 changelog](https://github.com/unclecode/crawl4ai/blob/main/CHANGELOG.md).
- Crawl4AI 0.9.5 → **0.9.6** (`unclecode/crawl4ai:0.9.6@sha256:4603d7c4d69769673dfa1214fa9abbcac2a874d4d9af07d784782af528b65c68`).
- Tested on Railway before merging: the published template was deployed, data was written, the service was switched to this version, and the data and login were still there.

## 0.9.5-1 (2026-11-16)

- README: add the Deploy on Railway button for the published template `crawl4ai-3`. No change to the service.

## 0.9.5 (2026-11-16)

- First release: Crawl4AI 0.9.5, official image `unclecode/crawl4ai:0.9.5@sha256:0b05666882bfb67f45d559a5b827839c54127b74aedd723f8ab338a3571b5fc9`.
- Listens on Railway's `PORT`, requires `CRAWL4AI_API_TOKEN` (the template generates it), health check on `/health`.
- Crawl cache and Redis job store on a volume at `/data`.
