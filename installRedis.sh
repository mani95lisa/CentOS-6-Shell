#!/bin/bash

clear
echo "Going to install Redis"

echo "Install kernel-headers for Windows Azure Machine"
sudo yum --disableexcludes=main install kernel-headers-2.6.32-279.14.1.el6.openlogic.x86_64

echo "Install GCC"
yum -y install gcc-c++

echo "Install Development Group for make, if install gcc-c++ doesn't work"
yum groupinstall "Development Tools"

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

mkdir -p /etc/redis
mkdir -p /var/redis
cd /home/redis-$version/
cp utils/redis_init_script /etc/init.d/redis
curl -L https://gist.github.com/mani95lisa/7766989/raw/4d328f653a4196ceb1179b429f5180f23f82ff57/redis > /etc/init.d/redis
cd /home/redis-$version/
cp redis.conf /etc/redis/redis.conf
chkconfig --add redis
chkconfig redis on
service redis start

echo "Redis Installed"
echo "Set daemonize to yes (by default it is no)"
echo "Check that the pidfile is /var/run/redis.pid;"
echo "Set the logfile to /var/log/redis.log;"
echo "Set the dir to /var/redis/."
