FROM ubuntu:14.04
# VOLUME ["/var/www"]

RUN apt-get update &&  \
    apt-get install -y \
      vim \
      apache2 \
      php5-common \
      php5 \
      php5-cli \
      libapache2-mod-php5 \
      php5-gd \
      php5-json \
      php5-ldap \
      php5-mysql \
      php5-dev \
      php5-mcrypt \
      php5-curl \
      php5-json \
      php5-redis \
      php5-intl \
      php5-gearman \
      php5-xdebug \
      mysql-client \
      mongodb-clients \
      graphviz \
      php5-imap \
      php-pear \
      make \
      gearman-tools \
      libgv-php5 \
      ssmtp \
      unzip \
      wget \
      curl


RUN pear install Net_GeoIP
RUN pecl install -f xhprof-beta
RUN echo "extension=xhprof.so" > /etc/php5/mods-available/xhprof.ini
RUN php5enmod xhprof

RUN apt-get -y install software-properties-common
RUN apt-add-repository -y ppa:phalcon/stable
RUN apt-get update
RUN apt-get -y install gcc libpcre3-dev php5-phalcon

RUN php5enmod mcrypt
RUN php5enmod phalcon

RUN mkdir -p /mnt/www/regiondo

RUN rm -rf /etc/apache2/sites-enabled/*
RUN mkdir /etc/apache2/ssl
COPY ./ssl/* /etc/apache2/ssl/
COPY xdebug.ini /etc/php5/mods-available/xdebug.ini
COPY run /usr/local/bin/run
COPY magerun.phar /usr/local/bin/magerun.phar

RUN pecl install mongo
RUN echo "extension=mongo.so" > /etc/php5/mods-available/mongo.ini
RUN php5enmod mongo

RUN pecl install mailparse-2.1.6
RUN echo "extension=mailparse.so" > /etc/php5/mods-available/mailparse.ini
RUN php5enmod mailparse

RUN cd /root/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN cd /root/ && composer require zircote/swagger-php && composer global require zircote/swagger-php
RUN ln -s /root/vendor/bin/swagger /usr/local/bin/swagger

RUN chmod +x /usr/local/bin/run

RUN php5enmod imap
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl

RUN mkdir -p /root/libxl/src
RUN cd /root/libxl/src && \
    wget http://libxl.com/download/libxl-lin-3.6.5.tar.gz && \
    tar xzf libxl-lin-3.6.5.tar.gz && cd libxl-3.6.5.0 && \
    ln -s include_c include && cd .. && \
    wget https://github.com/iliaal/php_excel/archive/master.zip && unzip master.zip
RUN cd /root/libxl/src/php_excel-master/ && phpize
RUN cd /root/libxl/src/php_excel-master/ && ./configure --with-excel --with-libxl-incdir=../libxl-3.6.5.0/include_c --with-libxl-libdir=../libxl-3.6.5.0/lib64
RUN cd /root/libxl/src/php_excel-master/ && make && make install
RUN echo "extension=excel.so" > /etc/php5/mods-available/excel.ini && php5enmod excel


EXPOSE 80
EXPOSE 443

CMD ["/usr/local/bin/run"]
WORKDIR /mnt/www/regiondo
