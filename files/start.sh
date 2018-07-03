#!/usr/bin/env bash
set -e

# Check if required variables are available
if [ -z "${ADMIN_EMAIL}" ]; then
    echo "Failure starting Traefik reverse proxy: The environment variable ADMIN_EMAIL must be set."
else

    # first arg is `-f` or `--some-option`
    if [ "${1#-}" != "$1" ]; then
        set -- traefik "$@"
    fi

    # Populate flexible variable of traefik's configuration from environment variables
    sed -i "s#{{ADMIN_EMAIL}}#${ADMIN_EMAIL}#" /etc/traefik/traefik.toml


    # if our command is a valid Traefik subcommand, let's invoke it through Traefik instead
    # (this allows for "docker run traefik version", etc)
    if traefik "$1" --help 2>&1 >/dev/null | grep "help requested" > /dev/null 2>&1; then
        set -- traefik "$@"
    fi

    exec "$@"

fi