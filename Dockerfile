FROM quay.io/keycloak/keycloak:26.2.5

ENV KC_DB=postgres
ENV KC_HOSTNAME_PROVIDER=v2
ENV KC_HOSTNAME_STRICT=false
ENV KC_HTTP_ENABLED=true
ENV KC_HTTP_PORT=80
ENV KC_PROXY_HEADERS=xforwarded
ENV KC_METRICS_ENABLED=true
ENV KC_HEALTH_ENABLED=true

COPY ./providers /opt/keycloak/providers/

# Clear build cache and rebuild
RUN rm -rf /opt/keycloak/conf/cache/* \
    && /opt/keycloak/bin/kc.sh build

# Set up health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=120s \
    CMD curl -f http://localhost:80/health || exit 1

# Run as non-root user
USER 1000

EXPOSE 80

CMD ["start", "--optimized", \
    "--spi-required-action-VERIFY_EMAIL_CODE-code-length=6", \
    "--spi-required-action-VERIFY_EMAIL_CODE-code-symbols=0123456789"]