FROM quay.io/keycloak/keycloak:26.2.5

ENV KC_DB=postgres
ENV KC_HOSTNAME_STRICT=false
ENV KC_HTTP_ENABLED=true

COPY ./providers /opt/keycloak/providers

EXPOSE 80

CMD ["start-dev"]