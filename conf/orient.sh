#!/bin/sh

# Export variable
export ORIENTDB_HOME='/opt/orient'

# Export variable
export ORIENTDB_NODE_NAME=$(hostname)

java -Xmx512M -Dhazelcast.ip=${IP} -Dhazelcast.tcp=${TCP} -Dhazelcast.aws=${AWS} -Dhazelcast.access=${AWSKEY} -Dhazelcast.secret=${AWSSEC} -Dhazelcast.region=${AWSREGION} -Dhazelcast.group=${AWSGROUP} -Dhazelcast.members=${MEMBERS} -Djna.nosys=true -XX:+HeapDumpOnOutOfMemoryError -Djava.awt.headless=true -Dfile.encoding=UTF8 -Drhino.opt.level=9 -Ddistributed=true -Dorientdb.config.file="${ORIENTDB_HOME}/config/orientdb.xml" -Dorientdb.www.path="${ORIENTDB_HOME}/www" -Dorientdb.build.number="UNKNOWN@r${buildNumber}; 2015-02-19 23:40:05+0000" -cp "${ORIENTDB_HOME}/lib/orientdb-server-2.0.3.jar:${ORIENTDB_HOME}/lib/*" $* com.orientechnologies.orient.server.OServerMain
