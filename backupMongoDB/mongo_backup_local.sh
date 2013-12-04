#!/bin/sh
 
MONGODB_SHELL='mongo'
DUMP_UTILITY='mongodump'
#SET the bd name which one you want to backup
read -p 'Enter database name to backup: ' db
DB_NAME=$db
 
#SET server path where you want to save the file
CLOUD_PATH='/var/local/mongoDB'
 
#SET your user name
SERVER_USER=''
 
#SET your host name or IP of the server
HOST_NAME=''
 
date_now=`date +%Y_%m_%d_%H_%M_%S`
dir_name='db_backup_'${date_now}
file_name='db_backup_'${date_now}'.bz2'
current_year=`date +%Y`
 
 
log() {
    echo $1
}
 
do_cleanup(){
    rm -rf 'db_backup_'${current_year}* 
    log 'cleaning up....'
}
 
do_backup(){
    log 'snapshotting the db and creating archive' && \
    ${MONGODB_SHELL} admin fsync_lock.js && \
  log 'db locked and creating backup' 
    ${DUMP_UTILITY} -d ${DB_NAME} -o ${dir_name} && tar -jcf $file_name ${dir_name} && \
    ${MONGODB_SHELL} admin fsync_unlock.js && \
    log 'data backd up and created snapshot'
}
 
save_in_cloud(){
  log 'saving backup to another server...'
  qrsync conf.json
}
 
 
do_backup && save_in_cloud && do_cleanup
