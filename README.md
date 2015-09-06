# OrientDB dockerized for ECS

OrientDB containerized in a distributed setup ready for AWS's ECS service.

## DB Service

> **WARNING** this setup does not encrypt messages sent between DB instances, and is meant to be used INSIDE a secured network.

- Before starting read (skim) this: https://hazelcast.com/resources/amazon-ec2-deployment-guide/

- Following environment variables should be set during the task definition:

```bash
 AWS_ACCESS_KEY=...
 AWS_SECRET_KEY=...
 EC2_SEC_GROUP=sg_db_servers
 EC2_TAG_KEY=cluster
 EC2_TAG_VAL=odb_node
 ORIENTDB_ROOT_PASSWORD=somestrongpassword
 MEM_LIMIT=512M
```

- Because in a correct setup each DB container shall run on one separate EC2 machine (container instance) due to static port mappings necessary, you will need exactly the same amount of machines as you will have DB containers.

- You have to at least expose port `5701` out of container for clustering to work. You will also need one of the ports `2424` (binary) or `2480` (REST API) or maybe both exposed for accessing DB.

- As multicast is not possible on EC2, and you probably dont want to restart all your containers on each IP change, the Hazelcast's AWS specific discovery is used. For better results it can be restricted either by tags attached to EC2 machine (container instance) or by one shared security group or by both.

- On the security group attached to your EC2 machines (container instances) which are supposed to run this image as DB cluster, following ports should be opened. You can do it either by giving a specific port range, or by mentioning the security group name as source.
    - Port `5701`, DB instances communicate with each other over that port
    - ICMP Echo Request (from Custom ICMP Rule), used for node fail detection

- AWS key and secret provided shall be best belonging to a new user with only one permission given `ec2:DescribeInstances`. The whole permission shall look like:

```json
 {
   "Version": "xxxxxxx",
   "Statement": [
     {
       "Sid": "xxxxxx",
       "Effect": "Allow",
       "Action": [
         "ec2:DescribeInstances"
       ],
       "Resource": [
         "*"
       ]
     }
   ]
 }
```

## Backup
This same (=saving space on your docker host) image can also be used for making backups of a running DB. In this case the command should be overridden and following params should be provided as environment parameters:
```bash
 ORIENTDB_ROOT_PASSWORD=somestrongpassword
 BACKUP_HOST=...
```

A sample usage:
```bash
$ docker run -e ORIENTDB_ROOT_PASSWORD=somepass -e BACKUP_HOST="remote:localhost/testdb" mohamnag/ecs-orientdb backup.sh
```

The backup will be stored under the container volume `/backups/`. Backup file's name contains DB host, DB name and date and time stamp. You can mount the backup volume on another container for further processing (like uploading to S3) using `--volumes-from` switch.