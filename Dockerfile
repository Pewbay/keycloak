FROM quay.io/keycloak/keycloak:26.2.5

# Non-sensitive config
ENV KC_DB=postgres
ENV KC_HOSTNAME_STRICT=false
ENV KC_HTTP_ENABLED=true
ENV KC_PROXY=edge
ENV KC_METRICS_ENABLED=true
ENV KC_HEALTH_ENABLED=true

# Production mode (remove dev mode)
CMD ["start"]

COPY ./providers /opt/keycloak/providers
EXPOSE 8080