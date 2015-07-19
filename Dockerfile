FROM php:fpm

RUN sed -i "s/http:\/\/httpredir.debian.org\/debian/http:\/\/ftp.jp.debian.org\/debian/" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y \
        sudo \
        libbz2-dev \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libmagickwand-dev \
        imagemagick \
        libicu-dev \
        libxml2-dev \
        g++ \
        git \
        zlib1g-dev \
    && docker-php-ext-install bz2 \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-install zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ \
                                   --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && pecl install -f apcu \
    && pecl install -f imagick-beta \
    && pecl install -f intl \
    && pecl install -f redis \
    && echo "extension=apcu.so" >> /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini \
    && echo "extension=imagick.so" >> /usr/local/etc/php/conf.d/docker-php-ext-imagick.ini \
    && echo "extension=intl.so" >> /usr/local/etc/php/conf.d/docker-php-ext-intl.ini \
    && echo "extension=redis.so" >> /usr/local/etc/php/conf.d/docker-php-ext-redis.ini \
    && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql \
    && apt-get install -y libldap2-dev \
    && docker-php-ext-configure ldap --with-libdir=lib/$(gcc -dumpmachine) \
    && docker-php-ext-install ldap \
    && apt-get install -y smbclient \
    && apt-get install -y libssl-dev \
    && docker-php-ext-install ftp \
    && docker-php-ext-install exif \
    && apt-get install -y libgmp-dev \
    && ln -s /usr/include/$(gcc -dumpmachine)/gmp.h /usr/include \
    && docker-php-ext-install gmp \
    && echo deb http://www.deb-multimedia.org jessie main >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --force-yes deb-multimedia-keyring \
    && apt-get update \
    && apt-get install -y ffmpeg \
    && apt-get install -y libreoffice \
    && pecl install -f htscanner \
    && echo "extension=htscanner.so" >> /usr/local/etc/php/conf.d/docker-php-ext-htscanner.ini \
    && echo "mysql.default_socket=/run/mysqld/mysqld.sock" >> /usr/local/etc/php/conf.d/docker-php-ext-mysql.ini \
    && echo "mysqli.default_socket=/run/mysqld/mysqld.sock" >> /usr/local/etc/php/conf.d/docker-php-ext-mysqli.ini \
    && echo "pdo_mysql.default_socket=/run/mysqld/mysqld.sock" >> /usr/local/etc/php/conf.d/docker-php-ext-mysqli.ini \
    && pecl install -f oauth \
    && echo "extension=oauth.so" >> /usr/local/etc/php/conf.d/docker-php-ext-oauth.ini \
    && echo "listen.mode = 0666" >> /usr/local/etc/php-fpm.conf

CMD ["php-fpm"]
