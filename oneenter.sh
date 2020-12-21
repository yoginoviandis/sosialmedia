#!/bin/bash

echo -e "Update\n"
apt-get update

echo "install webserver"
echo "==================================="
echo -e "Install apache2 php php-mysql & mysql-server\n"
apt-get install -y apache2 php php-mysql mysql-server
echo -e "\ninstall selesai\n"

#buat user
mysql -u root <<EOFMYSQL
create user 'devopscilsy'@'localhost' identified by '12345';
grant all privileges on *.* to 'devopscilsy'@'localhost';
EOFMYSQL

#akses mysql dengan user yang di atas
mysql -u devopscilsy -p12345 <<yns
create database dbsosmed;
\q
yns

echo -e "\nedit apache"
git clone https://github.com/yoginoviandis/belajarsosial.git
#hapus file di var/www/html/*
rm -rf /var/www/html/*
#cut file belajarsosial ke folder apache
mv belajarsosial/*  /var/www/html
echo -e "pindahkan selesai\n"

#menjalankan ulang apache2
service apache2 restart

