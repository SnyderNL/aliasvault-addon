# Renovate will track and update this pinned upstream AliasVault image tag.
# renovate: datasource=docker depName=ghcr.io/aliasvault/aliasvault
ARG UPSTREAM_IMAGE=ghcr.io/aliasvault/aliasvault:0.29.1
FROM ${UPSTREAM_IMAGE}

COPY ha-init-wrapper.sh /usr/local/bin/ha-init-wrapper.sh
COPY ha-persist-init.sh /etc/cont-init.d/10-ha-persist
COPY ha-persist-finish.sh /etc/cont-finish.d/90-ha-persist
RUN chmod +x /usr/local/bin/ha-init-wrapper.sh /etc/cont-init.d/10-ha-persist /etc/cont-finish.d/90-ha-persist \
    && sed -i 's/\r$//' /usr/local/bin/ha-init-wrapper.sh \
    && mv /etc/s6-overlay/s6-rc.d/init/script /etc/s6-overlay/s6-rc.d/init/script.upstream \
    && ln -s /usr/local/bin/ha-init-wrapper.sh /etc/s6-overlay/s6-rc.d/init/script
