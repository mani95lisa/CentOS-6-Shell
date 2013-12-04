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

cd src
mkdir -p /usr/local/bin
cp -pf redis-server /usr/local/bin
cp -pf redis-benchmark /usr/local/bin
cp -pf redis-cli /usr/local/bin
cp -pf redis-check-dump /usr/local/bin
cp -pf redis-check-aof /usr/local/bin

mkdir /etc/redis /var/lib/redis
cp src/redis-server src/redis-cli /usr/local/bin
cp redis.conf /etc/redis
sed -e "s/^daemonize no$/daemonize yes/" -e "s/^# bind 127.0.0.1$/bind 127.0.0.1/" -e "s/^dir \.\//dir \/var\/lib\/redis\//" -e "s/^loglevel verbose$/loglevel notice/" -e "s/^logfile stdout$/logfile \/var\/log\/redis.log/" redis.conf > /etc/redis/redis.conf
cp src/redis-server /etc/init.d
chmod 755 /etc/init.d/redis-server
chkconfig --add redis-server
chkconfig --level 345 redis-server on

echo "Redis Installed"