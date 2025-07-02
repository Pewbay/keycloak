# Use official Keycloak image
FROM quay.io/keycloak/keycloak:26.2.5

# Set non-sensitive configs
ENV KC_DB=postgres
ENV KC_HOSTNAME_STRICT=false
ENV KC_HTTP_ENABLED=true
ENV KC_PROXY=edge
ENV KC_METRICS_ENABLED=true
ENV KC_HEALTH_ENABLED=true

# Install custom providers (if any)
COPY ./providers /opt/keycloak/providers/

# Set up health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s \
    CMD curl -f http://localhost:8080/health || exit 1

# Run as non-root user
USER 1000

# Expose ports
EXPOSE 8080

# Start in production mode (optimized build)
CMD ["start", "--optimized"]