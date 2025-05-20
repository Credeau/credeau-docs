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

- Use nodes/EC2 instances with **at least 16GB RAM and 4 vCPUs** for running Insights API.
- This ensures sufficient resources for stable operation and avoids out-of-memory or CPU throttling issues.

#### Scaling Guidance

- Monitor CPU and RAM usage for each service.
- **Scale up** (add more pods/containers/instances) if max CPU or RAM usage exceeds **50%** for a period of 1 minute.

## 2. SMS Extraction Deployment

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
DB_USER="mobileforge_user"
DB_PASSWORD="your_secure_password"
DB_HOST="<host address of deployed PostgresSQL host>"
DB_PORT="5432"
DB_NAME="api_insights_db"
MAX_SMS_COUNT="1000"
DB_ENCRYPTION_KEY="<db_encryption_key>"
```

#### Run the Container
```bash
docker run -d \
    --name sms-extraction \
    --env-file .env \
    <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-sms-extraction:<version>
```

### Scaling Recommendations

#### Recommended Node Specifications

- Use nodes/EC2 instances with **at least 16GB RAM and 4 vCPUs** for running SMS Extraction API.
- This ensures sufficient resources for stable operation and avoids out-of-memory or CPU throttling issues.

#### Scaling Guidance

- Monitor CPU and RAM usage for each service.
- **Scale up** (add more pods/containers/instances) if max CPU or RAM usage exceeds **50%** for a period of 1 minute.

## Scaling Ladder

The following table provides recommended node counts based on daily active users (DAU):

| Daily Active Users | Insights API Nodes | SMS Extraction API Nodes |
|-------------------|-------------------|-------------------------|
| 25K            | 1-2               | 1                       |
| 50K            | 2-5               | 1-3                     |
| 75K            | 4-7               | 2-4                     |
| 100K           | 6-10              | 3-5                     |

> **Note:** These recommendations assume:

> - Each node has the minimum recommended specifications (16GB RAM, 4 vCPUs)
> - Average user activity patterns
> - Standard business hours usage
> - Regular maintenance windows
>
> Adjust node counts based on:

> - Peak usage times
> - Geographic distribution of users
> - Specific workload patterns
> - Performance monitoring metrics