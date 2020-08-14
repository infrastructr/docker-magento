#!/bin/sh

n=0
until [ "$n" -ge 5 ]
do
   echo "Waiting for database connection ($n)..."
   mysqladmin ping -h"${MAGENTO_DB_HOST}" --silent && break
   n=$((n+1))
   sleep 2
done

bin/magento setup:install \
    --base-url="${MAGENTO_BASE_URL}" \
    --db-host="${MAGENTO_DB_HOST}" \
    --db-name="${MAGENTO_DB_NAME}" \
    --db-user="${MAGENTO_DB_USER}" \
    --db-password="${MAGENTO_DB_PASSWORD}" \
    --admin-firstname="${MAGENTO_ADMIN_FIRSTNAME}" \
    --admin-lastname="${MAGENTO_ADMIN_LASTNAME}" \
    --admin-email="${MAGENT_ADMIN_EMAIL}" \
    --admin-user="${MAGENTO_ADMIN_USER}" \
    --admin-password="${MAGENTO_ADMIN_PASSWORD}" \
    --language="${MAGENTO_LANGUAGE}" \
    --currency="${MAGENTO_CURRENCY}" \
    --timezone="${MAGENTO_TIMEZONE}" \
    --use-rewrites="${MAGENTO_USE_REWRITES}" \
    --backend-frontname="${MAGENTO_BACKEND_FRONTNAME}" \
    --search-engine="${MAGENTO_SEARCH_ENGINE}" \
    --elasticsearch-host="${MAGENTO_ELASTICSEARCH_HOSTNAME}" \
    --elasticsearch-port="${MAGENTO_ELASTICSEARCH_PORT}" \
    --elasticsearch-enable-auth="${MAGENTO_ELASTICSEARCH_ENABLE_AUTH}" \
    --elasticsearch-username="${MAGENTO_ELASTICSEARCH_USERNAME}" \
    --elasticsearch-password="${MAGENTO_ELASTICSEARCH_PASSWORD}"

if [ "$MAGENTO_2FA_ENABLE" = "false" ]; then
    bin/magento module:disable Magento_TwoFactorAuth
fi
