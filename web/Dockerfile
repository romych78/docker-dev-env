FROM ubuntu:14.04

RUN apt-get update && \
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
      php5-mongo \
      php5-intl \
      php5-gearman \
      php5-xdebug

RUN pear install Net_GeoIP
RUN apt-get -y install software-properties-common
RUN apt-add-repository -y ppa:phalcon/stable
RUN apt-get update
RUN apt-get -y install gcc libpcre3-dev php5-phalcon

RUN php5enmod mcrypt
RUN php5enmod phalcon

RUN rm -rf /etc/apache2/sites-enabled/*
RUN mkdir /etc/apache2/ssl
COPY ./ssl/* /etc/apache2/ssl/
COPY xdebug.ini /etc/php5/mods-available/xdebug.ini
COPY run /usr/local/bin/run

RUN chmod +x /usr/local/bin/run

RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl

EXPOSE 80
EXPOSE 443

CMD ["/usr/local/bin/run"]
