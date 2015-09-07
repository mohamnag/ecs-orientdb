#!/usr/bin/env bash

DATE=`date +%Y-%m-%d:%H:%M:%S`
BACKUP_NAME=`echo ${DBNAME}-${DATE} | sed "s/[:/]/-/g"`

${ORIENTDB_HOME}/bin/backup.sh \
    plocal:${ORIENTDB_HOME}/databases/${BACKUP_DB} \
    ${BACKUP_USER} \
    ${BACKUP_PASS} \
    ${BACKUP_DIR}/${BACKUP_NAME}.zip