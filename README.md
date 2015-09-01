# OrientDB dockerized for ECS

OrientDB containerized in a distributed setup ready for AWS's ECS service.


Following environment variables should be set during the task definition:
```
ENV AWS_ACCESS_KEY=NOTSET 
ENV AWS_SECRET_KEY=NOTSET 
ENV AWS_SECURITY_GROUP=core 
```