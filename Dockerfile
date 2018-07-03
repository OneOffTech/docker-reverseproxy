FROM traefik:1.6-alpine

# Add the bash
RUN apk add --no-cache bash gawk sed grep bc coreutils

# Apply the standard traefik configuration
ADD files/traefik.toml /etc/traefik/

# Hijack the container to replace variables in traefik configuration
ADD files/start.sh /start.sh
EXPOSE 80
ENTRYPOINT ["/start.sh"]