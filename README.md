# docker-orientdb

Docker container for OrientDB

### Fleet usage

```shell
fleetctl submit orient@{1..3}.service
fleetctl start orient@{1..3}.service
```

### Docker usage

```shell
docker stop orient
docker rm orient
docker pull abcum/orientdb

# Example using Vagrant with tcp discovery
docker run --name orient -h $(hostname) -e IP=`ip route | awk '/eth1/ { print  $9 }'` -e MEMBERS=172.17.8.101-103 -p 2424:2424 -p 2480:2480 -p 5701:5701 -d abcum/orientdb

# Example using Amazon with auto discovery
docker run --name orient -h $(hostname) -e IP=`ip route | awk '/default/ { print  $9 }'` -e TCP=false -e AWS=true -e AWS_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE -e AWS_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY -p 2424:2424 -p 2480:2480 -p 5701:5701 -d abcum/orientdb
```

### Environment variables

##### `IP` (needs to be set)
Specify the ip address of the machine

##### `TCP` (default `true`)
Specify whether Hazelcast should use TCP-IP discovery

##### `MEMBERS` (default `127.0.0.1`)
Specify other member nodes for TCP-IP discovery

##### `AWS` (default `false`)
Specify whether Hazelcast should use Amazon EC2 Auto discovery

##### `AWS_REGION` (default `eu-west-1`)
Specify the Amazon region to use for Amazon EC2 Auto discovery

##### `AWS_ACCESS_KEY` (default `NOTSET`)
Specify the Amazon access key to use for Amazon EC2 Auto discovery

##### `AWS_SECRET_KEY` (default `NOTSET`)
Specify the Amazon secret key to use for Amazon EC2 Auto discovery

##### `AWS_SECURITY_GROUP` (default `core`)
Specify the Amazon EC2/VPC security group to use for Amazon EC2 Auto discovery
