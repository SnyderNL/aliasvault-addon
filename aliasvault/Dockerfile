# Tip: pin UPSTREAM_IMAGE to a fixed tag/digest for reproducible releases.
ARG UPSTREAM_IMAGE=ghcr.io/aliasvault/aliasvault:latest
FROM ${UPSTREAM_IMAGE}

COPY ha-persist-init.sh /etc/cont-init.d/10-ha-persist
COPY ha-persist-finish.sh /etc/cont-finish.d/90-ha-persist
RUN sed -i 's/\r$//' /etc/cont-init.d/10-ha-persist /etc/cont-finish.d/90-ha-persist \
    && chmod +x /etc/cont-init.d/10-ha-persist /etc/cont-finish.d/90-ha-persist
