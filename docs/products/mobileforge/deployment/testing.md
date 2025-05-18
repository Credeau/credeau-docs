# Deployment: Testing Environment

## Overview

The testing environment simulates the full MobileForge data flow using containerized components. All services — including APIs, Kafka, Consumers, and Databases — are launched using Docker Compose, with production-like images pulled from AWS ECR.

This environment is intended for functional testing on local machines or lightweight servers. It replicates the full data flow pipeline for validation, debugging, and integration testing.

## Prerequisites

- Docker and Docker Compose installed
- AWS CLI installed and configured (`aws configure`)
- Access to Credeau's private ECR repository

## Deployment Steps

### Step 1: Authenticate with AWS ECR

Run the following command to authenticate Docker with AWS ECR:

```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com
```

### Step 2: Create `docker-compose.testing.yml`

```yaml
version: 3.8

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
            - 27017:27017

    postgres:
        image: postgres:16
        environment:
            POSTGRES_USER: credeau
            POSTGRES_PASSWORD: 123456
            POSTGRES_DB: api_insights_db
        ports:
            - 5432:5432

    producer-api:
        image: <aws_account_id>.dkr.ecr.<region>.amazonaws.com/producer-api:<version>
        environment:
            DI_POSTGRES_USERNAME: credeau
            DI_POSTGRES_PASSWORD: 123456
            DI_POSTGRES_HOST: postgres
            DI_POSTGRES_PORT: 5432
            DI_POSTGRES_DATABASE: api_insights_db
            DI_POSTGRES_SYNC_DATABASE: sync_db
            DI_MONGODB_USERNAME: credeau
            DI_MONGODB_PASSWORD: 123456
            DI_MONGODB_HOST: mongo
            DI_MONGODB_PORT: 27017
            DI_MONGODB_DATABASE: sync_db
            DI_MONGODB_ENABLED_SOURCES: *
            DI_KAFKA_BROKER_ENDPOINT: kafka:9092
        depends_on:
            - kafka
            - postgres

    common-consumer:
        image: <aws_account_id>.dkr.ecr.<region>.amazonaws.com/data-consumer:<version>
        environment:
            DI_POSTGRES_USERNAME: credeau
            DI_POSTGRES_PASSWORD: 123456
            DI_POSTGRES_HOST: postgres
            DI_POSTGRES_PORT: 5432
            DI_POSTGRES_DATABASE: api_insights_db
            DI_POSTGRES_SYNC_DATABASE: sync_db
            DI_MONGODB_USERNAME: credeau
            DI_MONGODB_PASSWORD: 123456
            DI_MONGODB_HOST: mongo
            DI_MONGODB_PORT: 27017
            DI_MONGODB_DATABASE: sync_db
            DI_MONGODB_ENABLED_SOURCES: *
            DI_KAFKA_BROKER_ENDPOINT: kafka:9092
        depends_on:
            - kafka
            - mongo
            - postgres

    sms-extraction-api:
        image: <aws_account_id>.dkr.ecr.<region>.amazonaws.com/sms-extraction-api:<version>
        environment:
            DB_USER: credeau
            DB_PASSWORD: 123456
            DB_HOST: postgres
            DB_PORT: 5432
            DB_NAME: api_insights_db
            MAX_SMS_COUNT: 1000
            DB_ENCRYPTION_KEY: <encryption key>
        depends_on:
            - postgres

    insights-api:
        image: <aws_account_id>.dkr.ecr.<region>.amazonaws.com/insights-api:<version>
        environment:
            LAUNCH_ENVIRONMENT: testing
            DI_POSTGRES_USERNAME: credeau
            DI_POSTGRES_PASSWORD: 123456
            DI_POSTGRES_HOST: postgres
            DI_POSTGRES_PORT: 5432
            DI_POSTGRES_DATABASE: api_insights_db
            DI_POSTGRES_SYNC_DATABASE: sync_db
            DI_KAFKA_BROKER_ENDPOINT: kafka:9092
            SMS_EXTRACTOR_SERVICE_URL: sms-extraction-api
            SMS_EXTRACTOR_BATCH_SIZE: 1000
            DI_MONGODB_USERNAME: credeau
            DI_MONGODB_PASSWORD: 123456
            DI_MONGODB_HOST: mongo
            DI_MONGODB_PORT: 27017
            DI_MONGODB_DATABASE: sync_db
            DI_MONGODB_ENABLED_SOURCES: *
        depends_on:
            - mongo
            - postgres
            - sms-extraction-api
```

### Step 3: Start the Stack

```bash
docker compose -f docker-compose.testing.yml up -d --pull always
```

### Step 4: Verify

```bash
docker compose ps
```