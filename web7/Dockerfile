FROM ubuntu:16.04
# VOLUME ["/var/www"]

RUN mkdir -p /scripts

RUN apt-get update
RUN apt-get -y install software-properties-common

RUN apt-get install -y language-pack-en-base
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update 
RUN apt-get install -y php7.1 php7.1-common php7.1-zip

RUN apt-get install -y --allow-unauthenticated \
      apt-utils \
      vim \
      apache2 \
      php7.1-cli \
      libapache2-mod-php7.1 \
      php7.1-gd \
      php7.1-ldap \
      php7.1-mysql \
      php7.1-dev \
      build-essential \
      php7.1-mcrypt \
      php7.1-curl \
      php7.1-json \
      php7.1-intl \
      php-xdebug \
      php7.1-mbstring \
      php-msgpack \
      mysql-client \
      mongodb-clients \
      php-mongodb \
      graphviz \
      php7.1-imap \
      php-pear \
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
RUN touch /etc/php/7.1/mods-available/redis.ini && echo 'extension=redis.so' > /etc/php/7.1/mods-available/redis.ini
RUN phpenmod redis 

#RUN pear install Net_GeoIP
#RUN pecl install -f xhprof-beta
#RUN echo "extension=xhprof.so" > /etc/php/7.1/mods-available/xhprof.ini
#RUN phpenmod -v 7.1 xhprof

RUN apt-add-repository -y ppa:phalcon/stable
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated libpcre3-dev php7.1-phalcon

RUN phpenmod -v 7.1 mcrypt
RUN phpenmod -v 7.1 phalcon

#GEARMAN
RUN apt-get -y install --allow-unauthenticated libgearman-dev 
RUN mkdir -p /tmp/install && cd /tmp/install && \
    wget https://github.com/wcgallego/pecl-gearman/archive/master.zip && \
    unzip master.zip && cd pecl-gearman-master && \
    phpize && ./configure && make install && \
    echo "extension=gearman.so" > /etc/php/7.1/mods-available/gearman.ini && \
    phpenmod -v ALL -s ALL gearman && rm -rf /tmp/install/pecl-gearman-master && \
    rm /tmp/install/master.zip 

RUN mkdir -p /mnt/www/regiondo

RUN rm -rf /etc/apache2/sites-enabled/*
RUN mkdir /etc/apache2/ssl
COPY ./ssl/* /etc/apache2/ssl/
COPY xdebug.ini /etc/php/7.1/mods-available/xdebug.ini
COPY run /usr/local/bin/run
COPY magerun.phar /usr/local/bin/magerun.phar

#MAILPARSE
#RUN pecl install --nodeps mailparse  > /dev/null 2>&1
RUN sed -i '1i #define HAVE_MBSTRING 1'  /usr/include/php/20160303/ext/mbstring/libmbfl/mbfl/mbfilter.h && \
    sed -i '1i #undef HAVE_MBSTRING'  /usr/include/php/20160303/ext/mbstring/libmbfl/mbfl/mbfilter.h
RUN pecl install --nodeps mailparse && \
    echo "extension=mailparse.so" > /etc/php/7.1/mods-available/mailparse.ini && \
    phpenmod -v 7.1 mailparse

RUN cd /root/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN cd /root/ && composer require zircote/swagger-php && composer global require zircote/swagger-php
RUN ln -s /root/vendor/bin/swagger /usr/local/bin/swagger

RUN chmod +x /usr/local/bin/run

RUN phpenmod -v 7.1 imap
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl

RUN mkdir -p /root/libxl/src
RUN cd /root/libxl/src && \
    wget http://libxl.com/download/libxl-lin-3.7.2.tar.gz && \
    tar xzf libxl-lin-3.7.2.tar.gz && cd libxl-3.7.2.0 && \
    ln -s include_c include && cd ..

#PYTHON FOR GEARMAN
RUN apt-get -y install python-pip
RUN apt-get -y install libmysqlclient-dev
RUN apt-get -y install python-dev
RUN pip install MySQL-python
RUN pip install gearman
#END PYTHON

#WKHTMLTOPDF 0.12.3
RUN cd /tmp/install && \
    wget https://downloads.wkhtmltopdf.org/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz && \
    tar xvf wkhtmltox-0.12.3_linux-generic-amd64.tar.xz && \
    chmod a+x wkhtmltox/bin/wkhtmltopdf && \
    mv wkhtmltox/bin/wkhtmltopdf /usr/bin && \
    rm -rf wkhtmltox && \
    rm wkhtmltox-0.12.3_linux-generic-amd64.tar.xz && \
    cd ..
#END WKHTMLTOPDF

EXPOSE 80
EXPOSE 443

CMD ["/usr/local/bin/libxlsInstaller.sh"]
CMD ["/usr/local/bin/run"]
WORKDIR /mnt/www/regiondo
