#!/bin/sh
EC2_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
echo Discovered IP: ${EC2_IP}

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
echo Discovered Availability Zone: ${EC2_AVAIL_ZONE}

EC2_REGION="`echo \"${EC2_AVAIL_ZONE}\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
echo Discovered Region: ${EC2_REGION}

#ORIENTDB_NODE_NAME=$(hostname)
echo Using Node Name: ${ORIENTDB_NODE_NAME}

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
    -Ddistributed=true  $*
