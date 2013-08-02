#!/bin/bash

clear
echo "Go to install Apache Benchmark"
yum -y install apr-util
yum -y install yum-utils
mkdir ~/http
cd ~/http
yumdownloader httpd
read -p 'Enter download rpm : (httpd-2.2.15-15.el6.centos.1.x86_64.rpm) ' rpm
rpm = ${rpm:httpd-2.2.15-15.el6.centos.1.x86_64.rpm}
rpm2cpio $rpm | cpio -idmv
mv usr/bin/ab /usr/bin/ab
cd ~
rm -rf ~/httpd

echo "Run ab"
ab http://www.google.com