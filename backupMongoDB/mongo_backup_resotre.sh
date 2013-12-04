#!/bin/bash
 
RESTORE_UTILITY='mongorestore'
read -p 'Enter database name to restore: ' db
DB_NAME=$db
 
log() {
    echo $1
}
 
 
do_restore(){
    local fname=$1
    tar -jxf $1 && \
    ${RESTORE_UTILITY} -d ${DB_NAME} ${fname//.bz2}/${DB_NAME}
}
 
get_file_from_qiniu(){
    qboxrsctl login mani95lisa@gmail.com Afdsds12
    qboxrsctl get $db $1
}
 
do_cleanup(){
    rm -rf db_backup* 
    log 'cleaning up....'
}
 
if [ $# -lt 1 ]
then
    echo "Usage: $0 <backup_filename>"
    exit 1
fi
 
filename=$1
 
get_file_from_qiniu ${filename} && do_restore ${filename} && do_cleanup
