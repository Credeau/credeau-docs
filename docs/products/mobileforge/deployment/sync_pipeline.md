# Deployment: MobileForge Data Sync Pipeline

This document outlines the deployment steps for different components of the data sync pipeline.

## Components Overview

The sync pipeline consists of three main components -

1. Producer API
2. Kafka Message Broker
3. Consumer Service

> **Note:** All required Docker images for the sync pipeline components will be provided by Credeau via AWS ECR or another designated container registry. Please ensure you have access credentials as required.

## Producer API

### Environment Variables

The application supports various environment variables to provide application with necessary runtime values -

| Variable | Description |
|----------|-------------|
| `DI_POSTGRES_USERNAME` | Username for postgres database authentication |
| `DI_POSTGRES_PASSWORD` | Password for postgres database authentication |
| `DI_POSTGRES_HOST` | Host address of postgres database server to connect |
| `DI_POSTGRES_PORT` | Mapped port of postgres database server to connect |
| `DI_POSTGRES_DATABASE` | Database name for postgres database connection |
| `DI_POSTGRES_SYNC_DATABASE` | Sync Database name for postgres database connection |
| `DI_KAFKA_BROKER_ENDPOINT` | List of Kafka broker endpoints to connect to |

### Deployment: Using Docker

Pull the Producer API docker image from AWS ECR or similar container registry -

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 1234567890.dkr.ecr.ap-south-1.amazonaws.com
docker pull 1234567890.dkr.ecr.ap-south-1.amazonaws.com/credeau-producer-api:v1.0.0
```

Create a `.env` file with the appropriate values of following -

```
DI_POSTGRES_USERNAME="mobileforge_user"
DI_POSTGRES_PASSWORD="your_secure_password"
DI_POSTGRES_HOST="<host address of deployed PostgresSQL host>"
DI_POSTGRES_PORT="5432"
DI_POSTGRES_DATABASE="api_insights_db"
DI_POSTGRES_SYNC_DATABASE="sync_db"
DI_KAFKA_BROKER_ENDPOINT="<bootstrap-server-1>:9092,<bootstrap-server-2>:9092,<bootstrap-server-3>:9092"
```

Now, run the container -

```bash
docker run -d \
    --name producer-api \
    --env-file .env \
    -p 8000:8000 \
    1234567890.dkr.ecr.ap-south-1.amazonaws.com/credeau-producer-api:v1.0.0
```

### Production Readiness

#### Use Load Balancing

- For production deployments, expose your Producer API service using a load balancer (such as AWS Application Load Balancer or Network Load Balancer).
- This ensures high availability, fault tolerance, and even distribution of traffic.
- In Kubernetes, use a `Service` of type `LoadBalancer` to expose your pods.
- For Docker Compose or EC2, place your containers behind an AWS ELB/ALB.

#### Recommended Node Specifications

Ensure each node has the following amount of resources available at runtime to avoid out-of-memory and CPU throttle like issues -

| Environment     | CPU (vCPUs) | Memory (GB) |
|-----------------|-------------|-------------|
| Dev/UAT         | 2           | 2           |
| Production      | 4           | 8           |

#### Enable Auto-Scaling

- Keep a check on CPU and Memory consumption of the deployed nodes
- Assign a appropriate threshold for **scaling up** and **scaling down** of nodes - eg: 50%
- Raise an event as soon as this threshold is breached and scale up/down the nodes accordingly
- Services like AWS Autoscaling, K8s HPA, etc. make this easy to implement

## Kafka

For Dev/UAT like environments, use the official Kafka/Zookeper images from confluent to spawn up the brokers. For production grade setup, managed services like AWS MSK and Confluent cloud are highly recommended for higher reliability and availability.

### Topics

The Producer API needs the following topics to be present at runtime -

| Topic                     | Partitions | Replication Factor |
|---------------------------|------------|--------------------|
| `sms_batched`             | 16         | 3                  |
| `events_log`              | 20         | 3                  |
| `apps_and_device_batched` | 10         | 3                  |
| `contacts_batched` *      | 10         | 3                  |
| `call_logs_batched` *     | 10         | 3                  |

> `*` - Not required for deployments made in India.

The number of partitions mentioned, has to change as per scaling needs. The provided config is sufficient to sustain 150K-200K Daily Active Users on the SDK.

## Consumer Deployment

### Environment Variables

The application supports various environment variables to provide application with necessary runtime values -

| Variable | Description |
|----------|-------------|
| `DI_POSTGRES_USERNAME` | Username for postgres database authentication |
| `DI_POSTGRES_PASSWORD` | Password for postgres database authentication |
| `DI_POSTGRES_HOST` | Host address of postgres database server to connect |
| `DI_POSTGRES_PORT` | Mapped port of postgres database server to connect |
| `DI_POSTGRES_DATABASE` | Database name for postgres database connection |
| `DI_POSTGRES_SYNC_DATABASE` | Sync Database name for postgres database connection |
| `DI_MONGODB_USERNAME` | Username for mongo database authentication |
| `DI_MONGODB_PASSWORD` | Password for postgres database authentication |
| `DI_MONGODB_HOST` | Host address of mongo database server to connect |
| `DI_MONGODB_PORT` | Mapped port of mongo database server to connect |
| `DI_MONGODB_DATABASE` | Database name for mongo database connection |
| `DI_KAFKA_BROKER_ENDPOINT` | List of Kafka broker endpoints to connect to |
| `ENABLED_TOPICS` | List of topics name to listen on |
| `KAFKA_CONSUMER_GROUP` | Name of data source specific consumer group |

### Deployment: Using Docker

Pull the Producer API docker image from AWS ECR or similar container registry -

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 1234567890.dkr.ecr.ap-south-1.amazonaws.com
docker pull 1234567890.dkr.ecr.ap-south-1.amazonaws.com/credeau-producer-api:v1.0.0
```

Create a `.env` file with the appropriate values of following -

```
DI_POSTGRES_USERNAME="mobileforge_user"
DI_POSTGRES_PASSWORD="your_secure_password"
DI_POSTGRES_HOST="<host address of deployed PostgresSQL host>"
DI_POSTGRES_PORT="5432"
DI_POSTGRES_DATABASE="api_insights_db"
DI_POSTGRES_SYNC_DATABASE="sync_db"
DI_MONGODB_USERNAME="mobileforge_user"
DI_MONGODB_PASSWORD="your_secure_password"
DI_MONGODB_HOST="<host address of deployed MongoDB host>"
DI_MONGODB_PORT="27017"
DI_MONGODB_DATABASE="sync_db"
DI_MONGODB_ENABLED_SOURCES="*"
DI_MONGODB_MAX_POOL_SIZE="100"
DI_MONGODB_MIN_POOL_SIZE="10"
DI_MONGODB_SERVER_SELECTION_TIMEOUT_MS="15000"
DI_MONGODB_CONNECT_TIMEOUT_MS="10000"
DI_MONGODB_SOCKET_TIMEOUT_MS="10000"
DI_MONGODB_RETRY_WRITES="true"
DI_MONGODB_WAIT_QUEUE_TIMEOUT_MS="2000"
DI_KAFKA_BROKER_ENDPOINT="<bootstrap-server-1>:9092,<bootstrap-server-2>:9092,<bootstrap-server-3>:9092"
ENABLED_TOPICS="sms_batched,apps_and_device_batched,contacts_batched,call_logs_batched,events_log"
KAFKA_CONSUMER_GROUP="some-consumer-group"
```

Now, run the container -

```bash
docker run -d \
    --name consumer-api \
    --env-file .env \
    1234567890.dkr.ecr.ap-south-1.amazonaws.com/credeau-consumer:v1.0.0
```

### Production Readiness

### Consumer Groups

For production deployments, split consumer into 3 different consumers sms consumer, events consumer and a common consumer. Change the following configurations to achieve this -

SMS Consumer -

```bash
ENABLED_TOPICS=sms_batched
KAFKA_CONSUMER_GROUP=sms-consumer-group
```

Events Consumer -

```bash
ENABLED_TOPICS=events_log
KAFKA_CONSUMER_GROUP=events-consumer-group
```

Common Consumer -

```bash
ENABLED_TOPICS=apps_and_device_batched,contacts_batched,call_logs_batched
KAFKA_CONSUMER_GROUP=common-consumer-group
```

This segregates the responsibility of each consumer to listen on specific topics and consume the data accordingly.

#### Recommended Node Specifications

Ensure each node has the following amount of resources available at runtime to avoid out-of-memory and CPU throttle like issues -

| Environment     | CPU (vCPUs) | Memory (GB) |
|-----------------|-------------|-------------|
| Dev/UAT         | 2           | 2           |
| Production      | 4           | 8           |

#### Enable Auto-Scaling

- Keep a check on CPU and Memory consumption of the deployed nodes
    - Assign a appropriate threshold for **scaling up** and **scaling down** of nodes - eg: 50%
- Additionally, keep a check on the kafka topic lags and scale the consumers accordingly
    - Assign a appropriate threshold for **scaling up** and **scaling down** of nodes - eg: sms_batched lag > 100 | 500 | 1000 etc.
- Raise an event as soon as this threshold is breached and scale up/down the nodes accordingly
- Services like AWS Autoscaling, K8s HPA, K8s KEDA etc. make this easy to implement

## Scaling Ladder

| DAU | Producer Nodes | SMS Consumer | Events Consumer | Common Consumer | Kafka Brokers |
|----------|:-------------:|:------------:|:--------------:|:--------------:|:-------------------------------:|
| 25K | 1-3 | 1-4 | 1-2 | 1-2 | 1-3 |
| 50K | 2-5 | 2-8 | 1-5 | 1-5 | 3 |
| 75K | 3-7 | 3-12 | 2-7 | 2-7 | 3 |
| 100K | 4-10 | 4-16 | 3-10 | 3-10 | 3-5 |

> With increasing data consumer nodes, do adjust the partition count of the respective topics to at least match the max number of nodes expected.