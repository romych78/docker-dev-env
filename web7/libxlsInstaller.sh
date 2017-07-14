#!/bin/sh

# @see http://libxl.com/ AND https://github.com/iliaal/php_excel


LIBDIR="libxl-3.8.0.0"

mkdir -p /root/libxl/src
cd /root/libxl/src
wget http://libxl.com/download/libxl-lin-3.8.0.tar.gz
tar xzf libxl-lin-3.8.0.tar.gz
cd $LIBDIR
ln -s include_c include
cd ..
wget https://github.com/iliaal/php_excel/archive/php7.zip
unzip php7.zip
cd php_excel-php7/
phpize
./configure --with-excel --with-libxl-libdir=../$LIBDIR/lib64 --with-libxl-incdir=../$LIBDIR/include_c
make
make install
echo "extension=excel.so" > /etc/php/7.1/mods-available/excel.ini
echo "extension=excel.so" > /etc/php/7.0/mods-available/excel.ini
phpenmod excel

echo "Now check where you have PHP extension dir: "
echo "/usr/bin/php-config7.1 --extension-dir"
echo ""
echo "Then copy excel.so there: for example:"
echo "cp /root/libxl/src/php_excel-php7/modules/excel.so /usr/lib/php/20160303/excel.so"

echo ""
echo "Then restart apache"
