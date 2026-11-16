# Crawl4AI for Railway: the official image, pinned by version and digest.
# Bump both the tag and the digest together, and add a CHANGELOG.md entry.
FROM unclecode/crawl4ai:0.9.5@sha256:0b05666882bfb67f45d559a5b827839c54127b74aedd723f8ab338a3571b5fc9

# The wrapper starts as root only to prepare the Railway volume (mounted
# root-owned at /data), then drops to the image's own non-root user.
USER root

# Keep the crawl cache (~/.crawl4ai) and the in-container Redis job store on
# the volume, so they survive restarts and redeploys.
ENV CRAWL4_AI_BASE_DIRECTORY=/data
RUN rm -rf /var/lib/redis && ln -s /data/redis /var/lib/redis

COPY start.sh /usr/local/bin/railway-start.sh
RUN chmod 755 /usr/local/bin/railway-start.sh

WORKDIR /app
CMD ["bash", "/usr/local/bin/railway-start.sh"]
