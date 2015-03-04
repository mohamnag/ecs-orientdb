FROM centos:latest

MAINTAINER Tobie Morgan Hitchcock <tobie@abcum.com>

# Packages

RUN yum install -y epel-release

RUN yum install -y tar java-1.7.0-openjdk-headless

# Install

RUN curl -o orientdb.tar.gz https://abcum-deploy.s3.amazonaws.com/orient/orientdb-community-2.0.3.tar.gz && mkdir -p /opt/orient && tar -zxvf orientdb.tar.gz --strip-components=1 --directory /opt/orient && rm -rf orientdb.tar.gz

# Configs

RUN rm -rf /opt/orient/config

ADD conf/* /opt/orient/config/

# Expose the necessary ports

EXPOSE 2424 2480 5701

# Setup default environment

ENV IP=127.0.0.1 TCP=true AWS=false AWSKEY=NOTSET AWSSEC=NOTSET AWSREGION=eu-west-1 AWSGROUP=core MEMBERS=127.0.0.1

# Set the default command

CMD /opt/orient/config/orient.sh