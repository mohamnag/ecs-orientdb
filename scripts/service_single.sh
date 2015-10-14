#
#   Very similar to service.sh, it only skips all the distributed setup needed, mostly intended for testing.
#

# we handle replacing root pass here, because otherwise a guest user will also be created
sed -i "s|ORIENTDB_ROOT_PASSWORD|${ORIENTDB_ROOT_PASSWORD}|" ${ORIENTDB_HOME}/config/orientdb-server-config.xml

${ORIENTDB_HOME}/bin/server.sh \
    -Xmx${HEAP_MEM_LIMIT} \
    -Dstorage.diskCache.bufferSize=${DISK_CACHE_BUFFER} \
    -Dhazelcast.ip=${EC2_IP} \
    -Dhazelcast.access=${AWS_ACCESS_KEY} \
    -Dhazelcast.secret=${AWS_SECRET_KEY} \
    -Dhazelcast.region=${EC2_REGION} \
    -Dhazelcast.group=${EC2_SEC_GROUP} \
    -Dhazelcast.tag_key=${EC2_TAG_KEY} \
    -Dhazelcast.tag_value=${EC2_TAG_VAL} \
    -Dnetwork.lockTimeout=${ODB_NETWORK_LOCKTIMEOUT} \
    -Dnetwork.socketTimeout=${ODB_NETWORK_SOCKETTIMEOUT} \
    -Ddistributed=false  $*
