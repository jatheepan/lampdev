FROM ubuntu:20.04

RUN apt-get update && \
  apt-get install software-properties-common -y --no-install-recommends && \
  add-apt-repository ppa:ondrej/php -y && \
  apt-get install -y --no-install-recommends \
  php7.2 \
  php7.2-mbstring \
  php7.2-bcmath \
  php7.2-xml \
  php7.2-xmlrpc \
  php7.2-zip \
  php7.2-sqlite3 \
  php7.2-mysql \
  php7.2-imap \
  php7.2-readline \
  php7.2-phpdbg \
  php7.2-curl \
  php7.2-dev \
  php-pear \
  php-ssh2 \
  php-yaml \
  php-apcu \
  php-xhprof \
  php-xml \
  curl \
  unzip \
  make \
  apache2 \
  vim

RUN pecl install xdebug && \
    apt-get autoremove -y && apt-get clean -y && \
    rm -rf /tmp/* /var/tmp/* /usr/share/doc/*

RUN echo "zend_extension=$(find /usr/ -name xdebug.so)" > /etc/php/7.2/apache2/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /etc/php/7.2/apache2/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /etc/php/7.2/apache2/conf.d/xdebug.ini

RUN a2enmod rewrite
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV XDEBUG_CONFIG="idekey=YOURSECRETKEY remote_host=docker.for.mac.host.internal default_enable=0 remote_enable=1 remote_autostart=0 remote_connect_back=0 profiler_enable=0"

COPY apache-config.conf /etc/apache2/sites-enabled/000-default.conf
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
