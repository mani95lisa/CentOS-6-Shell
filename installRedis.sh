#!/bin/bash

clear
echo "Going to install Redis"

echo "Install kernel-headers"
sudo yum --disableexcludes=main install kernel-headers-2.6.32-279.14.1.el6.openlogic.x86_64

echo "Install GCC"
yum -y install gcc-c++

read -p 'Enter Redis version to install : (2.6.14) ' version
version=${version:-2.6.14}

wget http://redis.googlecode.com/files/redis-$version.tar.gz
tar xzf redis-$version.tar.gz
cd redis-$version
make
 
mkdir -p /usr/local/bin
cp -pf redis-server /usr/local/bin
cp -pf redis-benchmark /usr/local/bin
cp -pf redis-cli /usr/local/bin
cp -pf redis-check-dump /usr/local/bin
cp -pf redis-check-aof /usr/local/bin

echo "Redis Installed"