FROM java:8

MAINTAINER Mohammad Naghavi <mohamnag@gmail.com>

# Setup default environment, these may be overwritten when running image
ENV IP=127.0.0.1 
ENV MEM=512M 
ENV TCP=true 
ENV MEMBERS=127.0.0.1 

ENV AWS=false 
ENV AWS_ACCESS_KEY=NOTSET 
ENV AWS_SECRET_KEY=NOTSET 
ENV AWS_REGION=eu-west-1 
ENV AWS_SECURITY_GROUP=core 


# Export internal variables
ENV ORIENTDB_HOME='/opt/orient'
ENV ORIENTDB_VERSION='2.0.15'
ENV ORIENTDB_NODE_NAME=$(hostname)

# Expose the necessary ports
EXPOSE 2424 2480 5701

# Install
RUN \
	curl -o orientdb.tar.gz http://orientdb.com/download.php?file=orientdb-community-${ORIENTDB_VERSION}.tar.gz && \
	mkdir -p /opt/orient && \
	tar -zxvf orientdb.tar.gz --strip-components=1 --directory /opt/orient && \
	rm -rf orientdb.tar.gz && \
	rm -rf /opt/orient/config

# Add Configurations
ADD conf /opt/orient/config

# Set the default command
ADD init /opt/init
CMD /opt/init/orient.sh