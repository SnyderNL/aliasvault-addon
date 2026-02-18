# Renovate will track and update this pinned upstream AliasVault image tag.
# renovate: datasource=docker depName=ghcr.io/aliasvault/aliasvault
ARG UPSTREAM_IMAGE=ghcr.io/aliasvault/aliasvault:0.26.5
FROM ${UPSTREAM_IMAGE}

COPY ha-persist-init.sh /etc/cont-init.d/10-ha-persist
COPY ha-persist-finish.sh /etc/cont-finish.d/90-ha-persist
RUN sed -i 's/\r$//' /etc/cont-init.d/10-ha-persist /etc/cont-finish.d/90-ha-persist \
    && chmod +x /etc/cont-init.d/10-ha-persist /etc/cont-finish.d/90-ha-persist
