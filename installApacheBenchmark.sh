#!/bin/bash

clear
echo "Go to install Apache Benchmark"
yum -y install apr-util
yum -y install yum-utils
mkdir ~/http
cd ~/http
yumdownloader httpd
rpm2cpio httpd-2.2.3-43.el5.centos.3.i386.rpm | cpio -idmv
mv usr/bin/ab /usr/bin/ab
cd ~
rm -rf ~/httpd

echo "Run ab"
ab http://www.google.com