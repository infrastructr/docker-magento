[![Travis (.org) branch](https://img.shields.io/travis/infrastructr/docker-magento/master)](https://travis-ci.org/infrastructr/docker-magento)
[![Docker Pulls](https://img.shields.io/docker/pulls/infrastructr/magento)](https://hub.docker.com/r/infrastructr/magento)
[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/infrastructr/docker-magento)](https://hub.docker.com/repository/docker/infrastructr/magento/tags?page=1)

# Docker Magento
Provides containerized [Magento Commerce](https://magento.com/).

## Usage

    docker-compose up -d

## Configuration
Use environment variables for the configuration.

Available parameters along with the default values listed below.

    MAGENTO_BASE_URL: http://shop.local
    MAGENTO_DB_HOST: database
    MAGENTO_DB_USER: shop
    MAGENTO_DB_PASSWORD: secret
    MAGENTO_DB_NAME: shop
    MAGENTO_ADMIN_FIRSTNAME: Average
    MAGENTO_ADMIN_LASTNAME: Joe
    MAGENT_ADMIN_EMAIL: average.joe@example.org
    MAGENTO_ADMIN_USER: admin
    MAGENTO_ADMIN_PASSWORD: secret
    MAGENTO_LANGUAGE: de_DE
    MAGENTO_CURRENCY: EUR
    MAGENTO_TIMEZONE: Europe/Berlin
    MAGENTO_USE_REWRITES: 1
    MAGENTO_BACKEND_FRONTNAME: admin_nimda
    
## Development
Run locally built image

    docker-compose up

Rebuild image

    docker-compose build

## Maintainers

- [build-failure](https://github.com/build-failure)

## License

See the [LICENSE.md](LICENSE.md) file for details
