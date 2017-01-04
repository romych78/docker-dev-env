FROM ubuntu:16.04
# VOLUME ["/var/www"]

RUN apt-get update
RUN apt-get -y install software-properties-common

#RUN add-apt-repository ppa:ondrej/php
#RUN apt-get update 
RUN apt-get install -y --allow-unauthenticated \
      vim \
      apache2 \
      php7.0-cli \
      libapache2-mod-php7.0 \
      php7.0-gd \
      php7.0-json \
      php7.0-ldap \
      php7.0-mysql \
      php7.0-dev \
      build-essential \
      php7.0-mcrypt \
      php7.0-curl \
      php7.0-json \
      php7.0-json \
      php7.0-intl \
      php-xdebug \
      php7.0-mbstring \
      php-msgpack \
      mysql-client \
      mongodb-clients \
      php-mongodb \
      graphviz \
      php7.0-imap \
#      php-pear \
      php-geoip \
      libgeoip-dev \
      make \
      gearman-tools \
      libxml2 \
      libxml2-dev \
      ssmtp \
      unzip \
      wget \
      re2c \
      gcc \
      make \
      curl

#REDIS 
RUN apt-get install git -y -q && cd /root/ && \
    git clone -b php7 https://github.com/phpredis/phpredis.git && \
    mv phpredis/ /etc/ && cd /etc/phpredis && phpize && ./configure && make && make install
RUN touch /etc/php/7.0/mods-available/redis.ini && echo 'extension=redis.so' > /etc/php/7.0/mods-available/redis.ini
RUN phpenmod redis 

#RUN pear install Net_GeoIP
#RUN pecl install -f xhprof-beta
#RUN echo "extension=xhprof.so" > /etc/php/7.0/mods-available/xhprof.ini
#RUN phpenmod -v 7.0 xhprof

RUN apt-add-repository -y ppa:phalcon/stable
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated libpcre3-dev php7.0-zip php7.0-phalcon

RUN phpenmod -v 7.0 mcrypt
RUN phpenmod -v 7.0 phalcon

#GEARMAN
RUN apt-get -y install --allow-unauthenticated libgearman-dev 
RUN mkdir -p /tmp/install && cd /tmp/install && \
    wget https://github.com/wcgallego/pecl-gearman/archive/master.zip && \
    unzip master.zip && cd pecl-gearman-master && \
    phpize && ./configure && make install && \
    echo "extension=gearman.so" > /etc/php/7.0/mods-available/gearman.ini && \
    phpenmod -v ALL -s ALL gearman && rm -rf /tmp/install/pecl-gearman-master && \
    rm /tmp/install/master.zip 

RUN mkdir -p /mnt/www/regiondo

RUN rm -rf /etc/apache2/sites-enabled/*
RUN mkdir /etc/apache2/ssl
COPY ./ssl/* /etc/apache2/ssl/
COPY xdebug.ini /etc/php/7.0/mods-available/xdebug.ini
COPY run /usr/local/bin/run
COPY magerun.phar /usr/local/bin/magerun.phar

#MAILPARSE
RUN pecl install --nodeps mailparse  > /dev/null 2>&1 && \
    sed -i '1i #define HAVE_MBSTRING 1'  /usr/include/php/20151012/ext/mbstring/libmbfl/mbfl/mbfilter.h && \
    sed -i '1i #undef HAVE_MBSTRING'  /usr/include/php/20151012/ext/mbstring/libmbfl/mbfl/mbfilter.h
RUN pecl install --nodeps mailparse && \
    echo "extension=mailparse.so" > /etc/php/7.0/mods-available/mailparse.ini && \
    phpenmod -v 7.0 mailparse

RUN cd /root/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN cd /root/ && composer require zircote/swagger-php && composer global require zircote/swagger-php
RUN ln -s /root/vendor/bin/swagger /usr/local/bin/swagger

RUN chmod +x /usr/local/bin/run

RUN phpenmod -v 7.0 imap
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl

RUN mkdir -p /root/libxl/src
RUN cd /root/libxl/src && \
    wget http://libxl.com/download/libxl-lin-3.7.2.tar.gz && \
    tar xzf libxl-lin-3.7.2.tar.gz && cd libxl-3.7.2.0 && \
    ln -s include_c include && cd .. && \
    wget https://github.com/iliaal/php_excel/archive/php7.zip && unzip php7.zip
RUN cd /root/libxl/src/php_excel-php7/ && phpize && \
    ./configure --with-excel --with-libxl-incdir=/root/libxl/src/libxl-3.7.2.0/include_c --with-libxl-libdir=/root/libxl/src/libxl-3.7.2.0/lib64/ --with-libxml-dir=/usr/include/ && \
    make && make install && \
    echo "extension=excel.so" > /etc/php/7.0/mods-available/excel.ini && phpenmod -v 7.0 excel


EXPOSE 80
EXPOSE 443

CMD ["/usr/local/bin/run"]
WORKDIR /mnt/www/regiondo
