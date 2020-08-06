#!/bin/sh

set -e

if [ "$1" = "apache2-foreground" ]; then
    n=0
    until [ "$n" -ge 5 ]
    do
       echo "Waiting for database connection ($n)..."
       mysqladmin ping -h"${MAGENTO_DB_HOST}" --silent && break
       n=$((n+1))
       sleep 2
    done

    /magento-install.sh

    /magento-post-install.sh

    docker-php-entrypoint "$@"
else
    exec "$@"
fi

