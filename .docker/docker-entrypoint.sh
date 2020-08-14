#!/bin/sh

set -e

if [ "$1" = "apache2-foreground" ]; then
    /magento-install.sh

    /magento-post-install.sh

    docker-php-entrypoint "$@"
else
    exec "$@"
fi

