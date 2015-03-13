#!/bin/sh

# Export variables
export ORIENTDB_HOME='/opt/orient'
export ORIENTDB_VERSION='2.0.5'
export ORIENTDB_NODE_NAME=$(hostname)

java -Xmx512M -Dhazelcast.ip=${IP} -Dhazelcast.tcp=${TCP} -Dhazelcast.aws=${AWS} -Dhazelcast.access=${AWS_ACCESS_KEY} -Dhazelcast.secret=${AWS_SECRET_KEY} -Dhazelcast.region=${AWS_REGION} -Dhazelcast.group=${AWS_SECURITY_GROUP} -Dhazelcast.members=${MEMBERS} -Djna.nosys=true -XX:+HeapDumpOnOutOfMemoryError -Djava.awt.headless=true -Dfile.encoding=UTF8 -Drhino.opt.level=9 -Ddistributed=true -Djava.util.logging.config.file="${ORIENTDB_HOME}/config/orientdb.properties" -Dorientdb.config.file="${ORIENTDB_HOME}/config/orientdb.xml" -Dorientdb.www.path="${ORIENTDB_HOME}/www" -Dorientdb.build.number="UNKNOWN@r${buildNumber}; 2015-03-12 22:59:10+0000" -cp "${ORIENTDB_HOME}/lib/orientdb-server-${ORIENTDB_VERSION}.jar:${ORIENTDB_HOME}/lib/*" $* com.orientechnologies.orient.server.OServerMain
