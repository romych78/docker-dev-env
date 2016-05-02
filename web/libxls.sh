#!/bin/sh

LIBDIR="libxl-3.6.5.0"

mkdir -p /root/libxl/src
cd /root/libxl/src
wget http://libxl.com/download/libxl-lin-3.6.5.tar.gz
tar xzf libxl-lin-3.6.5.tar.gz
cd $LIBDIR
ln -s include_c include
cd ..
wget https://github.com/iliaal/php_excel/archive/master.zip
unzip master.zip
cd php_excel-master/
phpize
./configure --with-excel --with-libxl-libdir=../$LIBDIR/lib64 --with-libxl-incdir=../$LIBDIR/include_c
make
make install
echo "extension=excel.so" > /etc/php5/mods-available/excel.ini && php5enmod excel
