#!/usr/bin/env bash

DATE=`date +%Y-%m-%d:%H:%M:%S`
DBNAME=`echo ${BACKUP_DB} | sed "s/.*://g"`
BACKUP_NAME=`echo ${DBNAME}-${DATE}.export | sed "s/[:/]/-/g"`

${ORIENTDB_HOME}/bin/console.sh "connect ${BACKUP_DB} ${BACKUP_USER} ${BACKUP_PASS};freeze database;export database ${BACKUP_DIR}/${BACKUP_NAME};release database;"