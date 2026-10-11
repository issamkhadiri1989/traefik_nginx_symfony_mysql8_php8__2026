
FROM php:8.5-fpm

ARG BUILD_ARGUMENT_ENV=dev

ENV APP_HOME=/var/www/html \
    COMPOSER_ALLOW_SUPERUSER=1

# Dépendances système
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash-completion \
    fish \
    procps \
    nano \
    git \
    unzip \
    curl \
    wget \
    ca-certificates \
    libicu-dev \
    zlib1g-dev \
    libxml2 \
    libxml2-dev \
    libreadline-dev \
    libzip-dev \
    librabbitmq-dev \
    libxslt-dev \
    libldap2-dev \
    libssl-dev \
    supervisor \
    cron \
    sudo \
    $PHPIZE_DEPS \
    && rm -rf /var/lib/apt/lists/*

# Extensions PHP natives
RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j"$(nproc)" \
        pdo_mysql \
        sockets \
        intl \
        zip \
        xsl \
        ldap

# Extensions PECL
RUN set -eux; \
    pecl channel-update pecl.php.net; \
    pecl install amqp; \
    docker-php-ext-enable amqp; \
    pecl install apcu; \
    docker-php-ext-enable apcu; \
    pecl install xdebug-3.5.3; \
    docker-php-ext-enable xdebug; \
    rm -rf /tmp/pear

WORKDIR ${APP_HOME}

USER root