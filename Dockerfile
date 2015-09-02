FROM java:8

MAINTAINER Mohammad Naghavi <mohamnag@gmail.com>

# Setup default environment, these have to be overwritten when running image
ENV AWS_ACCESS_KEY=NOTSET
ENV AWS_SECRET_KEY=NOTSET
ENV EC2_SEC_GROUP=NOTSET
ENV EC2_TAG_KEY=NOTSET
ENV EC2_TAG_VAL=NOTSET
ENV ORIENTDB_ROOT_PASSWORD=0r13ntDB


# Export internal variables
ENV MEM=512M
ENV ORIENTDB_HOME='/opt/orient'
ENV ORIENTDB_VERSION='2.0.15'

# Expose the necessary ports
EXPOSE 2424 2480 5701

# Install
RUN \
	curl -o orientdb.tar.gz http://orientdb.com/download.php?file=orientdb-community-${ORIENTDB_VERSION}.tar.gz && \
	mkdir -p ${ORIENTDB_HOME} && \
	tar -zxvf orientdb.tar.gz --strip-components=1 --directory ${ORIENTDB_HOME} && \
	rm -rf orientdb.tar.gz && \
	rm -rf ${ORIENTDB_HOME}/config

# Add Configurations
ADD conf ${ORIENTDB_HOME}/config

# Set the default command
ADD init /opt/init
CMD /opt/init/orient.sh