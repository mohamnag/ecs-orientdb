FROM abcum/alpine:latest

MAINTAINER Tobie Morgan Hitchcock <tobie@abcum.com>

# Packages

RUN apk-install tar curl openjdk7-jre-base

# Install

RUN curl -o orientdb.tar.gz https://abcum.s3.amazonaws.com/orientdb/orientdb-community-2.0.5.tar.gz && mkdir -p /opt/orient && tar -zxvf orientdb.tar.gz --strip-components=1 --directory /opt/orient && rm -rf orientdb.tar.gz

# Configs

RUN rm -rf /opt/orient/config

ADD conf/* /opt/orient/config/

RUN keytool -genkey -alias foo -keystore /root/.keystore -dname cn=test -storepass changeit -keypass changeit

# Expose the necessary ports

EXPOSE 2424 2480 5701

# Setup default environment

ENV IP=127.0.0.1 TCP=true AWS=false AWS_ACCESS_KEY=NOTSET AWS_SECRET_KEY=NOTSET AWS_REGION=eu-west-1 AWS_SECURITY_GROUP=core MEMBERS=127.0.0.1

# Set the default command

CMD /opt/orient/config/orient.sh