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
docker run --name orient -e PUBLIC_IP=`ip route | awk '/eth1/ { print  $9 }'` -e PRIVATE_IP=`ip route | awk '/default/ { print  $3 }'` -p 2424:2424 -p 2480:2480 -p 5701:5701 -d abcum/orientdb
```