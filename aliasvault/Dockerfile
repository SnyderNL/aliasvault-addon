# Renovate will track and update this pinned upstream AliasVault image tag.
# renovate: datasource=docker depName=ghcr.io/aliasvault/aliasvault
ARG UPSTREAM_IMAGE=ghcr.io/aliasvault/aliasvault:0.26.6
FROM ${UPSTREAM_IMAGE}

COPY ha-init-wrapper.sh /usr/local/bin/ha-init-wrapper.sh
RUN sed -i 's/\r$//' /usr/local/bin/ha-init-wrapper.sh \
    && chmod +x /usr/local/bin/ha-init-wrapper.sh \
    && mv /etc/s6-overlay/s6-rc.d/init/script /etc/s6-overlay/s6-rc.d/init/script.upstream \
    && ln -s /usr/local/bin/ha-init-wrapper.sh /etc/s6-overlay/s6-rc.d/init/script
