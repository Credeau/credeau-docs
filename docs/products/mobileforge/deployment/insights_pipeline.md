# Deployment: Insights Pipeline

This document outlines the deployment steps for different components of the insights pipeline.

## Components Overview

The sync pipeline consists of three main components -

1. Insights API
3. SMS Extraction API

> **Note:** All required Docker images for the insights pipeline components will be provided by Credeau via AWS ECR or another designated container registry. Please ensure you have access credentials as required.

## 1. Insights API Deployment

### Prerequisites

- Access to AWS ECR or other container registry
- Docker installed on the deployment machine
- AWS CLI configured (if using AWS ECR)

### Deployment Steps

#### Pull the Insights API Image

```bash
# For AWS ECR
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker pull <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-insights-api:<version>
```

#### Configure Environment Variables

Create a `.env` file with the following variables -

```bash
LAUNCH_ENVIRONMENT="prod"
DI_POSTGRES_USERNAME="mobileforge_user"
DI_POSTGRES_PASSWORD="your_secure_password"
DI_POSTGRES_HOST="<host address of deployed PostgresSQL host>"
DI_POSTGRES_PORT="5432"
DI_POSTGRES_DATABASE="api_insights_db"
DI_POSTGRES_SYNC_DATABASE="sync_db"
SMS_EXTRACTOR_SERVICE_URL="<sms extractor service url>"
SMS_EXTRACTOR_BATCH_SIZE="1000"
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
```

#### Run the Container
```bash
docker run -d \
    --name insights-api \
    --env-file .env \
    -p 8000:8000 \
    <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-insights-api:<version>
```

### Nodes Exposure and Scaling Recommendations

#### Exposing Nodes with Load Balancer

- For production deployments, expose your Insights API service using a load balancer (such as AWS Application Load Balancer or Network Load Balancer).
- This ensures high availability, fault tolerance, and even distribution of traffic.
- In Kubernetes, use a `Service` of type `LoadBalancer` to expose your pods.
- For Docker Compose or EC2, place your containers behind an AWS ELB/ALB.

#### Recommended Node Specifications

- Use nodes/EC2 instances with **at least 2GB RAM and 2 vCPUs** for running Insights API.
- This ensures sufficient resources for stable operation and avoids out-of-memory or CPU throttling issues.

#### Scaling Guidance

- Monitor CPU and RAM usage for each service.
- **Scale up** (add more pods/containers/instances) if max CPU or RAM usage exceeds **50%** for a period of 1 minute.

## 3. SMS Extraction Deployment

### Prerequisites

- Access to AWS ECR or other container registry
- Docker installed on the deployment machine
- AWS CLI configured (if using AWS ECR)

### Deployment Steps

#### Pull the SMS Extraction API Image

```bash
# For AWS ECR
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker pull <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-sms-extraction:<version>
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

### Scaling Recommendations

#### Recommended Node Specifications

- Use nodes/EC2 instances with **at least 2GB RAM and 2 vCPUs** for running Producer API.
- This ensures sufficient resources for stable operation and avoids out-of-memory or CPU throttling issues.

#### Scaling Guidance

- Monitor CPU and RAM usage for each service.
- **Scale up** (add more pods/containers/instances) if max CPU or RAM usage exceeds **50%** for a period of 1 minute.
- For more enhanced scaling, monitor Kafka topic lags and trigger scale up as the lag increases more than 50 
