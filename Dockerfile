FROM php:7.3.20-apache-buster

ARG MAGENTO_PUBLIC_KEY
ARG MAGENTO_PRIVATE_KEY

ENV MAGENTO_BASE_URL "http://shop.local"
ENV MAGENTO_DB_HOST "database"
ENV MAGENTO_DB_USER "shop"
ENV MAGENTO_DB_PASSWORD "secret123"
ENV MAGENTO_DB_NAME "shop"
ENV MAGENTO_ADMIN_FIRSTNAME "Average"
ENV MAGENTO_ADMIN_LASTNAME "Joe"
ENV MAGENT_ADMIN_EMAIL "average.joe@example.org"
ENV MAGENTO_ADMIN_USER "admin"
ENV MAGENTO_ADMIN_PASSWORD "secret123"
ENV MAGENTO_LANGUAGE "de_DE"
ENV MAGENTO_CURRENCY "EUR"
ENV MAGENTO_TIMEZONE "Europe/Berlin"
ENV MAGENTO_USE_REWRITES "1"
ENV MAGENTO_BACKEND_FRONTNAME "admin_nimda"

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libxml2-dev \
    zlib1g-dev \
    libpng-dev \
    libonig-dev \
    libbz2-dev \
    libxslt1-dev \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    lsof \
    default-mysql-client \
    wget \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure \
    gd --with-freetype-dir --with-jpeg-dir \
  && docker-php-ext-install -j$(nproc) \
    gd \
    bcmath \
    intl \
    pdo_mysql \
    simplexml \
    soap \
    xsl \
    zip

RUN mkdir -p /opt/composer \
  && cd /opt/composer \
  && wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet \
  && chmod +x /opt/composer/composer.phar \
  && ln -fsn /opt/composer/composer.phar /usr/bin/composer

RUN composer create-project --repository-url=https://${MAGENTO_PUBLIC_KEY}:${MAGENTO_PRIVATE_KEY}@repo.magento.com/ magento/project-community-edition /var/www/html

RUN cd /var/www/html/ \
  && find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} + \
  && find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} + \
  && chown -R :www-data . \
  && chmod u+x bin/magento

RUN a2enmod rewrite

COPY .docker/ /

RUN apt-get update && apt-get install -y \
    git \
    zip \
  && rm -rf /var/lib/apt/lists/*

RUN chmod +x /docker-entrypoint.sh /magento-post-install.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["apache2-foreground"]
