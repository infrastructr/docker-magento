#!/bin/sh

set -e

#--search-engine="${MAGENTO_SEARCH_ENGINE}" \

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

docker-php-entrypoint "$@"
