FROM ghcr.io/aliasvault/aliasvault:latest

COPY ha-persist-init.sh /etc/cont-init.d/10-ha-persist
COPY ha-persist-finish.sh /etc/cont-finish.d/90-ha-persist
RUN sed -i 's/\r$//' /etc/cont-init.d/10-ha-persist /etc/cont-finish.d/90-ha-persist \
    && chmod +x /etc/cont-init.d/10-ha-persist /etc/cont-finish.d/90-ha-persist
