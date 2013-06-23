#!/bin/bash

clear
echo "Going to install Redis"

wget http://redis.googlecode.com/files/redis-2.6.13.tar.gz
tar xzf redis-2.6.13.tar.gz
cd redis-2.6.13/src
make
 
mkdir -p /usr/local/bin
cp -pf redis-server /usr/local/bin
cp -pf redis-benchmark /usr/local/bin
cp -pf redis-cli /usr/local/bin
cp -pf redis-check-dump /usr/local/bin
cp -pf redis-check-aof /usr/local/bin

echo "Redis Installed"