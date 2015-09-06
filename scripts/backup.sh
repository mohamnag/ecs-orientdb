#!/usr/bin/env bash

DATE=`date +%Y-%m-%d:%H:%M:%S`
DBNAME=`echo ${BACKUP_HOST} | sed "s/.*://g"`
BACKUP_NAME=`echo ${DBNAME}-${DATE} | sed "s/[:/]/-/g"`

${ORIENTDB_HOME}/bin/backup.sh \
    ${BACKUP_HOST} \
    root \
    ${ORIENTDB_ROOT_PASSWORD} \
    ${BACKUP_DIR}/${BACKUP_NAME}.zip