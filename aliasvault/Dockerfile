FROM ghcr.io/aliasvault/aliasvault:latest

COPY run.sh /run.sh
RUN sed -i 's/\r$//' /run.sh && chmod +x /run.sh

CMD ["/run.sh"]