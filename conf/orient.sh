#!/bin/sh

# Export variables
export ORIENTDB_HOME='/opt/orient'
export ORIENTDB_VERSION=${VERSION}
export ORIENTDB_NODE_NAME=$(hostname)

curl -o orientdb.tar.gz https://abcum.s3.amazonaws.com/orientdb/orientdb-community-2.0.1.tar.gz && mkdir -p /opt/orient && tar -zxvf orientdb.tar.gz --strip-components=1 --directory /opt/orient && rm -rf orientdb.tar.gz && rm -rf /opt/orient/config && mv /opt/config /opt/orient/config

java -Xmx${MEM} -Dhazelcast.ip=${IP} -Dhazelcast.tcp=${TCP} -Dhazelcast.aws=${AWS} -Dhazelcast.access=${AWS_ACCESS_KEY} -Dhazelcast.secret=${AWS_SECRET_KEY} -Dhazelcast.region=${AWS_REGION} -Dhazelcast.group=${AWS_SECURITY_GROUP} -Dhazelcast.members=${MEMBERS} -Djna.nosys=true -XX:+HeapDumpOnOutOfMemoryError -Djava.awt.headless=true -Dfile.encoding=UTF8 -Drhino.opt.level=9 -Ddistributed=true -Djava.util.logging.config.file="${ORIENTDB_HOME}/config/orientdb.properties" -Dorientdb.config.file="${ORIENTDB_HOME}/config/orientdb.xml" -Dorientdb.www.path="${ORIENTDB_HOME}/www" -cp "${ORIENTDB_HOME}/lib/orientdb-server-${ORIENTDB_VERSION}.jar:${ORIENTDB_HOME}/lib/*" $* com.orientechnologies.orient.server.OServerMain
