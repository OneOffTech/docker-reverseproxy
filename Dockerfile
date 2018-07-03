FROM traefik:1.6-alpine

# Apply the standard traefik configuration
ADD files/traefik.toml /etc/traefik/

# Hijack the container to replace variables in traefik configuration
ADD files/start.sh /start.sh
EXPOSE 80
ENTRYPOINT ["/start.sh"]