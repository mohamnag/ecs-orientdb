# OrientDB dockerized for ECS

OrientDB containerized in a distributed setup ready for AWS's ECS service.


- Following environment variables should be set during the task definition:

```
AWS_ACCESS_KEY=...
AWS_SECRET_KEY=...
EC2_SEC_GROUP=sg_db_servers
EC2_TAG_KEY=cluster
EC2_TAG_VAL=odb_node
ORIENTDB_ROOT_PASSWORD=somestrongpassword
```

- Before starting read (skim) this: https://hazelcast.com/resources/amazon-ec2-deployment-guide/

- Because in a correct setup each DB container shall run on one separate EC2 machine (container instance) due to
 static port mappings necessary, you will need exactly the same amount of machines as you will have DB containers.

- You have to at least map port `5701` for clustering to work. You will also need one of the ports `2424` (binary) or
 `2480` (REST API) or maybe both exposed for accessing DB.

- Port `5701` should also be opened on EC2 machine's (container instance) security group for IPs intended for DB
 cluster subnet(s). DB instances communicate with each other over that port.

- As multicast is not possible on EC2, and you probably dont want to restart all your containers on each IP change,
 the Hazelcast's AWS specific discovery is used. For better results it can be either done by tags attached to
 EC2 machine (container instance) or by shared security group.

- **WARNING** this setup does not encrypt messages sent between DB instances, and is meant to be used INSIDE a secured
 network.