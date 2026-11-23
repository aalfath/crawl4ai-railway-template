# Crawl4AI for Railway: the official image, pinned by version and digest.
# Bump both the tag and the digest together, and add a CHANGELOG.md entry.
FROM unclecode/crawl4ai:0.9.6@sha256:4603d7c4d69769673dfa1214fa9abbcac2a874d4d9af07d784782af528b65c68

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
