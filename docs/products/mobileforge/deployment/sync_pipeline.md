# Deployment: Sync Pipeline

This document outlines the deployment steps for different components of the sync pipeline.



## Components Overview

The sync pipeline consists of three main components -

1. Producer API
2. Kafka Message Broker
3. Consumer Service

> **Note:** All required Docker images for the sync pipeline components will be provided by Credeau via AWS ECR or another designated container registry. Please ensure you have access credentials as required.

## 1. Producer API Deployment

### Prerequisites

- Access to AWS ECR or other container registry
- Docker installed on the deployment machine
- AWS CLI configured (if using AWS ECR)

### Deployment Steps

#### Pull the Producer API Image

```bash
# For AWS ECR
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker pull <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-producer-api:<version>
```

#### Configure Environment Variables

Create a `.env` file with the following variables -

```bash
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
```

#### Run the Container
```bash
docker run -d \
    --name producer-api \
    --env-file .env \
    -p 8000:8000 \
    <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-producer-api:<version>
```

### Nodes Exposure and Scaling Recommendations

#### Exposing Nodes with Load Balancer

- For production deployments, expose your Producer API service using a load balancer (such as AWS Application Load Balancer or Network Load Balancer).
- This ensures high availability, fault tolerance, and even distribution of traffic.
- In Kubernetes, use a `Service` of type `LoadBalancer` to expose your pods.
- For Docker Compose or EC2, place your containers behind an AWS ELB/ALB.

#### Recommended Node Specifications

- Use nodes/EC2 instances with **at least 2GB RAM and 2 vCPUs** for running Producer API.
- This ensures sufficient resources for stable operation and avoids out-of-memory or CPU throttling issues.

#### Scaling Guidance

- Monitor CPU and RAM usage for each service.
- **Scale up** (add more pods/containers/instances) if max CPU or RAM usage exceeds **50%** for a period of 1 minute.

## 2. Kafka Deployment

### Prerequisites

- Kubernetes cluster or Docker Compose
- Sufficient storage for message persistence
- Network access between components

### Deployment Methods

#### 1. Using Docker Compose (Recommended for Dev Testing / UAT Environments)

```yaml
version: '3'
services:
    zookeeper:
    image: confluentinc/cp-zookeeper:latest
    environment:
        ZOOKEEPER_CLIENT_PORT: 2181
    ports:
        - "2181:2181"

    kafka:
    image: confluentinc/cp-kafka:latest
    depends_on:
        - zookeeper
    ports:
        - "9092:9092"
    environment:
        KAFKA_BROKER_ID: 1
        KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
        KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:29092,PLAINTEXT_HOST://localhost:9092
        KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
        KAFKA_INTER_BROKER_LISTENER_NAME: PLAINTEXT
        KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
```

#### 2. AWS Managed Kafka (Recommended for Production Environments)

**Prerequisites**

- AWS CLI configured with appropriate permissions
- VPC with at least 2 private subnets in different Availability Zones
- Security groups for MSK cluster
- IAM roles and policies for MSK

**Create Security Groups**

```bash
# Create security group for MSK
aws ec2 create-security-group \
    --group-name msk-security-group \
    --description "Security group for MSK cluster" \
    --vpc-id <your-vpc-id>

# Add inbound rules for Kafka
aws ec2 authorize-security-group-ingress \
    --group-id <msk-security-group-id> \
    --protocol tcp \
    --port 9092 \
    --source-group <producer-consumer-security-group-id>

aws ec2 authorize-security-group-ingress \
    --group-id <msk-security-group-id> \
    --protocol tcp \
    --port 2181 \
    --source-group <producer-consumer-security-group-id>
```

**Create MSK Cluster**

```bash
aws kafka create-cluster \
    --cluster-name "mobileforge-sync-cluster" \
    --kafka-version "3.8.0" \
    --number-of-broker-nodes 3 \
    --enhanced-monitoring PER_BROKER \
    --broker-node-group-info \
    '{
        "ClientSubnets": ["<subnet-id-1>", "<subnet-id-2>", "<subnet-id-3>"],
        "SecurityGroups": ["<msk-security-group-id>"],
        "InstanceType": "kafka.t3a.large",
        "StorageInfo": {
            "EbsStorageInfo": {
                "VolumeSize": 100
            }
        }
    }' \
    --encryption-info \
    '{
        "EncryptionInTransit": {
            "ClientBroker": "TLS",
            "InCluster": true
        }
    }'
```

**Wait for Cluster Creation**

```bash
# Check cluster status
aws kafka describe-cluster --cluster-arn <cluster-arn>
```

**Get Bootstrap Servers**

```bash
# Get bootstrap servers for client configuration
aws kafka get-bootstrap-brokers --cluster-arn <cluster-arn>
```

**Create Topics**

```bash
# Create the sync topic
aws kafka create-topic \
    --cluster-arn <cluster-arn> \
    --topic sms_batched \
    --partitions 16 \
    --replication-factor 3 \
    --config retention.ms=1800000

aws kafka create-topic \
    --cluster-arn <cluster-arn> \
    --topic events_log \
    --partitions 20 \
    --replication-factor 3 \
    --config retention.ms=1800000

aws kafka create-topic \
    --cluster-arn <cluster-arn> \
    --topic apps_and_device_batched \
    --partitions 5 \
    --replication-factor 3 \
    --config retention.ms=1800000

aws kafka create-topic \
    --cluster-arn <cluster-arn> \
    --topic contacts_batched \
    --partitions 5 \
    --replication-factor 3 \
    --config retention.ms=1800000

aws kafka create-topic \
    --cluster-arn <cluster-arn> \
    --topic call_logs_batched \
    --partitions 5 \
    --replication-factor 3 \
    --config retention.ms=1800000
```

**Configuration for Producer and Consumer**

Update the environment variables in your `.env` files to use the MSK bootstrap servers:

```bash
# For Producer and Consumer .env files
DI_KAFKA_BROKER_ENDPOINT="<bootstrap-server-1>:9092,<bootstrap-server-2>:9092,<bootstrap-server-3>:9092"
```

#### Cost Optimization

1. **Instance Types**
   - Use appropriate instance types based on workload
   - Consider reserved instances for production
   - Monitor broker metrics for right-sizing

2. **Storage**
   - Configure appropriate EBS volume sizes
   - Monitor storage usage
   - Set up alerts for storage thresholds

## 3. Consumer Deployment

### Prerequisites

- Access to AWS ECR or other container registry
- Docker installed on the deployment machine
- AWS CLI configured (if using AWS ECR)

### Deployment Steps

#### Pull the Producer API Image

```bash
# For AWS ECR
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker pull <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-consumer:<version>
```

#### Configure Environment Variables

Create a `.env` file with the following variables -

```bash
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

#### Run the Container
```bash
docker run -d \
    --name consumer \
    --env-file .env \
    <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-consumer:<version>
```

For production setups, split consumer into 3 different consumers sms consumer, events consumer and a common consumer. Change the following configurations to achieve this -

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

### Scaling Recommendations

#### Recommended Node Specifications

- Use nodes/EC2 instances with **at least 2GB RAM and 2 vCPUs** for running Producer API.
- This ensures sufficient resources for stable operation and avoids out-of-memory or CPU throttling issues.

#### Scaling Guidance

- Monitor CPU and RAM usage for each service.
- **Scale up** (add more pods/containers/instances) if max CPU or RAM usage exceeds **50%** for a period of 1 minute.
- For more enhanced scaling, monitor Kafka topic lags and trigger scale up as the lag increases more than 50 

## Scaling Ladder

| DAU | Producer Nodes | SMS Consumer | Events Consumer | Common Consumer | Kafka Brokers (8GB RAM, 2 vCPU) |
|----------|:-------------:|:------------:|:--------------:|:--------------:|:-------------------------------:|
| 25K | 1-3 | 1-4 | 1-2 | 1-2 | 1-3 |
| 50K | 2-5 | 2-8 | 1-5 | 1-5 | 3 |
| 75K | 3-7 | 3-12 | 2-7 | 2-7 | 3 |
| 100K | 4-10 | 4-16 | 3-10 | 3-10 | 3-5 |

> With increasing data consumer nodes, do adjust the partition count of the respective topics to at least match the max number of nodes expected.