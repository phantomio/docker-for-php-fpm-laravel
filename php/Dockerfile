ARG SA_PASSWORD
FROM php:fpm

# For composer
RUN apt-get update \
    && apt-get install -y gnupg2 \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y libzip-dev \
    && apt-get install -y wget \
    && apt-get install -y unixodbc-dev \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && docker-php-ext-install zip

RUN wget http://pear.php.net/go-pear.phar \
    && php go-pear.phar

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e5325b19b381bfd88ce90a5ddb7823406b2a38cff6bb704b0acc289a09c8128d4a8ce2bbafcd1fcbdc38666422fe2806') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer

# Set composer environment
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin
ENV DB_CONNECTION=sqlsrv \
  DB_HOST=laravel-sqlsrv \
  DB_PORT=1433 \
  DB_USERNAME=SA

# Install sqlsrv pdo_sqlsrv
RUN pecl install sqlsrv pdo_sqlsrv \
    && printf "; priority=20\nextension=sqlsrv.so\n" > /usr/local/etc/php/conf.d/sqlsrv.ini \
    && printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /usr/local/etc/php/conf.d/pdo_sqlsrv.ini \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

# Connection Pooling fot sqlsrv
RUN echo "[ODBC]" >> /etc/odbcinst.ini \
    && echo "Pooling=Yes" >> /etc/odbcinst.ini

# Install laravel installer & debugbar
RUN composer global require "laravel/installer"

# PHP's DB setting
RUN apt-get update \
    && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo_mysql pdo_pgsql

# Install Node.js
RUN apt-get install -y nodejs

WORKDIR /src
