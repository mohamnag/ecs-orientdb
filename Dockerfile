FROM java:8

MAINTAINER Mohammad Naghavi <mohamnag@gmail.com>

# Setup default environment, these have to be overwritten when running image
ENV AWS_ACCESS_KEY=NOTSET
ENV AWS_SECRET_KEY=NOTSET
ENV EC2_SEC_GROUP=NOTSET
ENV EC2_TAG_KEY=NOTSET
ENV EC2_TAG_VAL=NOTSET
ENV ORIENTDB_ROOT_PASSWORD=NOTSET
ENV MEM_LIMIT=512M


# Export internal variables
ENV ORIENTDB_HOME='/opt/orientdb'
ENV ORIENTDB_VERSION='2.0.15'

# Install
RUN \
	curl -o orientdb.tar.gz http://orientdb.com/download.php?file=orientdb-community-${ORIENTDB_VERSION}.tar.gz && \
	mkdir -p ${ORIENTDB_HOME} && \
	tar -zxvf orientdb.tar.gz --strip-components=1 --directory ${ORIENTDB_HOME} && \
	rm -rf orientdb.tar.gz && \
	rm -rf ${ORIENTDB_HOME}/config

# Add Hazelcast Cloud, this is a bug in OrientDB and is fixed in 2.1
RUN rm ${ORIENTDB_HOME}/lib/hazelcast*
ADD http://central.maven.org/maven2/com/hazelcast/hazelcast-all/3.4.5/hazelcast-all-3.4.5.jar ${ORIENTDB_HOME}/lib/

# Add Configurations
ADD conf ${ORIENTDB_HOME}/config
# Add init script
ADD init /opt/init
# Expose the necessary ports
EXPOSE 2424 2480 5701
# Escape union file system for DB files
VOLUME /opt/orientdb/databases/

# Set the default command
CMD /opt/init/orient.sh
