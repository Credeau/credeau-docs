# Deployment: Testing Environment

## Overview

The testing environment simulates the full MobileForge data flow using containerized components. All services — including APIs, Kafka, Consumers, and Databases — are launched using Docker Compose, with production-like images pulled from AWS ECR.

---

## Prerequisites

- Docker and Docker Compose installed
- AWS CLI installed and configured (`aws configure`)
- Access to Credeau's private ECR repository

---

## Step 1: Authenticate with AWS ECR

Run the following command to authenticate Docker with AWS ECR:

```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
```

## Step 2: Create `docker-compose.yml`

```yaml
version: "3.8"

services:

  zookeeper:
    image: confluentinc/cp-zookeeper:7.5.0
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181

  kafka:
    image: confluentinc/cp-kafka:7.5.0
    depends_on:
      - zookeeper
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_LISTENERS: PLAINTEXT://:9092
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:9092

  mongo:
    image: mongo:7.0
    environment:
      MONGO_INITDB_ROOT_USERNAME: credeau
      MONGO_INITDB_ROOT_PASSWORD: 123456
      MONGO_INITDB_DATABASE: sync_db
    ports:
      - "27017:27017"

  postgres:
    image: postgres:16
    environment:
      POSTGRES_USER: credeau
      POSTGRES_PASSWORD: 123456
      POSTGRES_DB: api_insights_db
    ports:
      - "5432:5432"

  producer-api:
    image: <aws_account_id>.dkr.ecr.<region>.amazonaws.com/producer-api:<version>
    environment:
      - DI_POSTGRES_USERNAME="credeau"
      - DI_POSTGRES_PASSWORD="123456"
      - DI_POSTGRES_HOST="postgres"
      - DI_POSTGRES_PORT="5432"
      - DI_POSTGRES_DATABASE="api_insights_db"
      - DI_POSTGRES_SYNC_DATABASE="sync_db"
      - DI_MONGODB_USERNAME="credeau"
      - DI_MONGODB_PASSWORD="123456"
      - DI_MONGODB_HOST="mongo"
      - DI_MONGODB_PORT="27017"
      - DI_MONGODB_DATABASE="sync_db"
      - DI_MONGODB_ENABLED_SOURCES="*"
      - DI_MONGODB_MAX_POOL_SIZE="100"
      - DI_MONGODB_MIN_POOL_SIZE="10"
      - DI_MONGODB_SERVER_SELECTION_TIMEOUT_MS="15000"
      - DI_MONGODB_CONNECT_TIMEOUT_MS="10000"
      - DI_MONGODB_SOCKET_TIMEOUT_MS="10000"
      - DI_MONGODB_RETRY_WRITES="true"
      - DI_MONGODB_WAIT_QUEUE_TIMEOUT_MS="2000"
      - DI_KAFKA_BROKER_ENDPOINT="kafka:9092"
      - ENABLED_TOPICS="-"
      - KAFKA_CONSUMER_GROUP="-"
    depends_on:
      - kafka
      - postgres

  common-consumer:
    image: <aws_account_id>.dkr.ecr.<region>.amazonaws.com/sms-consumer:<version>
    environment:
      - DI_POSTGRES_USERNAME="credeau"
      - DI_POSTGRES_PASSWORD="123456"
      - DI_POSTGRES_HOST="postgres"
      - DI_POSTGRES_PORT="5432"
      - DI_POSTGRES_DATABASE="api_insights_db"
      - DI_POSTGRES_SYNC_DATABASE="sync_db"
      - DI_MONGODB_USERNAME="credeau"
      - DI_MONGODB_PASSWORD="123456"
      - DI_MONGODB_HOST="mongo"
      - DI_MONGODB_PORT="27017"
      - DI_MONGODB_DATABASE="sync_db"
      - DI_MONGODB_ENABLED_SOURCES="*"
      - DI_MONGODB_MAX_POOL_SIZE="100"
      - DI_MONGODB_MIN_POOL_SIZE="10"
      - DI_MONGODB_SERVER_SELECTION_TIMEOUT_MS="15000"
      - DI_MONGODB_CONNECT_TIMEOUT_MS="10000"
      - DI_MONGODB_SOCKET_TIMEOUT_MS="10000"
      - DI_MONGODB_RETRY_WRITES="true"
      - DI_MONGODB_WAIT_QUEUE_TIMEOUT_MS="2000"
      - DI_KAFKA_BROKER_ENDPOINT="kafka:9092"
      - ENABLED_TOPICS="sms_batched,apps_and_device_batched,contacts_batched,call_logs_batched,events_log"
      - KAFKA_CONSUMER_GROUP="test-consumer-group"
    depends_on:
      - kafka
      - mongo
      - postgres

  sms-extraction-api:
    image: <aws_account_id>.dkr.ecr.<region>.amazonaws.com/sms-extraction-api:<version>
    environment:
      - ENV=testing

  insights-api:
    image: <aws_account_id>.dkr.ecr.<region>.amazonaws.com/insights-api:<version>
    environment:
      - ENV=testing
    depends_on:
      - mongo
      - postgres
      - sms-extraction-api
```