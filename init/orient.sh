#!/bin/sh
EC2_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`

EC2_REGION="`echo \"${EC2_AVAIL_ZONE}\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"

EC2_SEC_GROUP=`curl -s http://169.254.169.254/latest/meta-data/security-groups`

java \
	-Xmx${MEM} \
	-Dhazelcast.ip=${EC2_IP} \
	-Dhazelcast.aws=true \
	-Dhazelcast.access=${AWS_ACCESS_KEY} \
	-Dhazelcast.secret=${AWS_SECRET_KEY} \
	-Dhazelcast.region=${EC2_REGION} \
	-Dhazelcast.group=${EC2_SEC_GROUP} \
	-Dhazelcast.tcp=true \
	-Dhazelcast.members=${MEMBERS} \
	-Djna.nosys=true \
	-XX:+HeapDumpOnOutOfMemoryError \
	-Djava.awt.headless=true \
	-Dfile.encoding=UTF8 \
	-Drhino.opt.level=9 \
	-Ddistributed=true \
	-Djava.util.logging.config.file="${ORIENTDB_HOME}/config/orientdb.properties" \
	-Dorientdb.config.file="${ORIENTDB_HOME}/config/orientdb.xml" \
	-Dorientdb.www.path="${ORIENTDB_HOME}/www" \
	-cp "${ORIENTDB_HOME}/lib/orientdb-server-${ORIENTDB_VERSION}.jar:${ORIENTDB_HOME}/lib/*" $* com.orientechnologies.orient.server.OServerMain
