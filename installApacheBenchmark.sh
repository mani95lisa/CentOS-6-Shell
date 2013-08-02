#!/bin/bash

clear
echo "Go to install Apache Benchmark"
sudo yum install httpd-tools

echo "Run ab"
ab http://www.google.com