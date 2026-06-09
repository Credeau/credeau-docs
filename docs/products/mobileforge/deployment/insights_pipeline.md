# Deployment: MobileForge Insights Pipeline

This document outlines the deployment steps for different components of the insights pipeline.

## Components Overview

The sync pipeline consists of three main components -

1. Insights API
2. SMS Extraction API

> **Note:** All required Docker images for the insights pipeline components will be provided by Credeau via AWS ECR or another designated container registry. Please ensure you have access credentials as required.

## Insights API

### Prerequisites

- Access to AWS ECR or other container registry
- Docker installed on the deployment machine
- AWS CLI configured (if using AWS ECR)

### Environment Variables

The application supports various environment variables to provide application with necessary runtime values -

| Variable                                    | Description |
|---------------------------------------------|-------------|
| `CLIENT_ID`                                 | Client ID shared by Credeau |
| `LAUNCH_ENVIRONMENT`                        | Environment in which the service is deployed (dev, staging, prod) |
| `DI_POSTGRES_USERNAME`                      | Username for postgres database authentication |
| `DI_POSTGRES_PASSWORD`                      | Password for postgres database authentication |
| `DI_POSTGRES_HOST`                          | Host address of postgres database server to connect |
| `DI_POSTGRES_PORT`                          | Mapped port of postgres database server to connect |
| `DI_POSTGRES_DATABASE`                      | Database name for postgres database connection |
| `DI_POSTGRES_SYNC_DATABASE`                 | Sync Database name for postgres database connection |
| `SMS_EXTRACTOR_SERVICE_URL`                 | URL of the SMS Extraction Service |
| `DI_MONGODB_USERNAME`                       | Username for mongo database authentication |
| `DI_MONGODB_PASSWORD`                       | Password for mongo database authentication |
| `DI_MONGODB_HOST`                           | Host address of mongo database server to connect |
| `DI_MONGODB_PORT`                           | Mapped port of mongo database server to connect |
| `DI_MONGODB_DATABASE`                       | Database name for mongo database connection |
| `LICENSE_KEY`                               | Product enablement license key shared by Credeau |
| `SUBSCRIPTION_ID`                           | Subscription ID shared by Credeau |
| `APPS_MAPPING_PATH`                         | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_apps_mapping.json.enc` |
| `FRAUD_APPS_MAPPING_PATH`                   | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_fraud_apps_mapping.json.enc` |
| `AVG_DEVICE_MAPPING_PATH`                   | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_avg_device_price.json.enc` |
| `DEVICE_MAPPING_PATH`                       | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_device_pricing.json.enc` |
| `MERCHANT_MAPPING_PATH`                     | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_merchant_clean_sender_name_mapping.csv.enc` |
| `SMS_MAPPING_PATH`                          | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_sms_sender_mapping.json.enc` |
| `SMS_MAPPING_V2_PATH`                       | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_sms_sender_mapping_v2.json.enc` |
| `COMPANY_MODEL_PATH`                        | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_company_model.pkl.enc` |
| `COMPANY_VECTORIZER_PATH`                   | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_company_vectorizer.pkl.enc` |
| `COUNT_VECTORIZER_PATH`                     | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_countvectorizer.pickle.enc` |
| `LABEL_MODEL_PATH`                          | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_label_encoder.pickle.enc` |
| `LR_MODEL_PATH`                             | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_lr.pickle.enc` |
| `MERCHANT_LABEL_V2_PATH`                    | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_label_encoder_v2.pkl.enc` |
| `MERCHANT_LABEL_PATH`                       | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_label_encoder.pkl.enc` |
| `MERCHANT_MODEL_V2_PATH`                    | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_model_v2.pkl.enc` |
| `MERCHANT_MODEL_PATH`                       | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_model.pkl.enc` |
| `MERCHANT_VECTORIZER_V2_PATH`               | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_vectorizer_v2.pkl.enc` |
| `MERCHANT_VECTORIZER_PATH`                  | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_vectorizer.pkl.enc` |
| `LGB_SCORE_MODEL_PATH`                      | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_lgb_model.pkl.enc` |
| `PAYDAY_SCORE_LGB_MODEL_PATH`               | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_payday_lgb_model.pkl.enc` |
| `PAYDAY_SCORE_LGB_MODEL_V2_PATH`            | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_payday_lgb_model_20250623.pkl.enc` |
| `PAYDAY_SCORE_LGB_MODEL_V3_PATH`            | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_payday_lgb_model_20250703.pkl.enc` |
| `PREDICTORS_SCORE_LGB_MODEL_PATH`           | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_predictors_lgb.pkl.enc` |
| `PREDICTORS_PAYDAY_SCORE_LGB_MODEL_PATH`    | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_predictors_payday_lgb_model.pkl.enc` |
| `PREDICTORS_PAYDAY_SCORE_LGB_MODEL_V2_PATH` | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_predictors_payday_lgb_model_20250623.pkl.enc` |
| `PREDICTORS_PAYDAY_SCORE_LGB_MODEL_V3_PATH` | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_predictors_payday_lgb_model_20250703.pkl.enc` |
| `EMI_LGB_MODEL_V2_PATH`                     | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_EMI_lgb_model_20250730_V2.pkl.enc` |
| `PREDICTORS_EMI_LGB_MODEL_V2_PATH`          | `s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_predictors_EMI_lgb_model_20250730_V2.pkl.enc` |
| `AWS_ACCESS_KEY_ID`                         | AWS Access Key shared by Credeau, for fetching the artifacts |
| `AWS_SECRET_ACCESS_KEY`                     | AWS Secret Key shared by Credeau, for fetching the artifacts |
| `AWS_DEFAULT_REGION`                        | AWS Region Name shared by Credeau, for fetching the artifacts |

> ⚠️ **Note!**
>
> Following values will be provided by Credeau, during the integration -
>
> - `credeau_asset_bucket`
> - `client_id`

### Deployment: Using Docker

Pull the Insights API docker image from AWS ECR or similar container registry -

```bash
# For AWS ECR
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker pull <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-insights-api:<version>
```

Create a `.env` file with the following variables -

```bash
CLIENT_ID="<client id shared by Credeau>"
LAUNCH_ENVIRONMENT="prod"
DI_POSTGRES_USERNAME="mobileforge_user"
DI_POSTGRES_PASSWORD="your_secure_password"
DI_POSTGRES_HOST="<host address of deployed PostgresSQL host>"
DI_POSTGRES_PORT="5432"
DI_POSTGRES_DATABASE="api_insights_db"
DI_POSTGRES_SYNC_DATABASE="sync_db"
SMS_EXTRACTOR_SERVICE_URL="<sms extractor service url>"
DI_MONGODB_USERNAME="mobileforge_user"
DI_MONGODB_PASSWORD="your_secure_password"
DI_MONGODB_HOST="<host address of deployed MongoDB host>"
DI_MONGODB_PORT="27017"
DI_MONGODB_DATABASE="sync_db"
LICENSE_KEY="<product activation license key shared by Credeau>"
SUBSCRIPTION_ID="<subscription id shared by credeau>"
APPS_MAPPING_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_apps_mapping.json.enc"
FRAUD_APPS_MAPPING_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_fraud_apps_mapping.json.enc"
AVG_DEVICE_MAPPING_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_avg_device_price.json.enc"
DEVICE_MAPPING_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_device_pricing.json.enc"
MERCHANT_MAPPING_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_merchant_clean_sender_name_mapping.csv.enc"
SMS_MAPPING_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_sms_sender_mapping.json.enc"
SMS_MAPPING_V2_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/configs/india_configs_sms_sender_mapping_v2.json.enc"
COMPANY_MODEL_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_company_model.pkl.enc"
COMPANY_VECTORIZER_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_company_vectorizer.pkl.enc"
COUNT_VECTORIZER_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_countvectorizer.pickle.enc"
LABEL_MODEL_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_label_encoder.pickle.enc"
LR_MODEL_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_lr.pickle.enc"
MERCHANT_LABEL_V2_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_label_encoder_v2.pkl.enc"
MERCHANT_LABEL_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_label_encoder.pkl.enc"
MERCHANT_MODEL_V2_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_model_v2.pkl.enc"
MERCHANT_MODEL_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_model.pkl.enc"
MERCHANT_VECTORIZER_V2_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_vectorizer_v2.pkl.enc"
MERCHANT_VECTORIZER_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/models/india_models_merchant_vectorizer.pkl.enc"
LGB_SCORE_MODEL_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_lgb_model.pkl.enc"
PAYDAY_SCORE_LGB_MODEL_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_payday_lgb_model.pkl.enc"
PAYDAY_SCORE_LGB_MODEL_V2_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_payday_lgb_model_20250623.pkl.enc"
PAYDAY_SCORE_LGB_MODEL_V3_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_payday_lgb_model_20250703.pkl.enc"
PREDICTORS_SCORE_LGB_MODEL_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_predictors_lgb.pkl.enc"
PREDICTORS_PAYDAY_SCORE_LGB_MODEL_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_predictors_payday_lgb_model.pkl.enc"
PREDICTORS_PAYDAY_SCORE_LGB_MODEL_V2_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_predictors_payday_lgb_model_20250623.pkl.enc"
PREDICTORS_PAYDAY_SCORE_LGB_MODEL_V3_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_predictors_payday_lgb_model_20250703.pkl.enc"
EMI_LGB_MODEL_V2_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_EMI_lgb_model_20250730_V2.pkl.enc"
PREDICTORS_EMI_LGB_MODEL_V2_PATH="s3://<credeau_asset_bucket>/clients/client_<client_id>/insights/scoring/india_scoring_predictors_EMI_lgb_model_20250730_V2.pkl.enc"
AWS_ACCESS_KEY_ID="aws access key id shared by Credeau"
AWS_SECRET_ACCESS_KEY="aws secret key shared by Credeau"
AWS_DEFAULT_REGION="aws region name shared by Credeau"
```

Now, run the container -

```bash
docker run -d \
    --name insights-api \
    --env-file .env \
    -p 8000:8000 \
    <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-insights-api:<version>
```

### Production Readiness

#### Use Load Balancing

- For production deployments, expose your Insights API service using a load balancer (such as AWS Application Load Balancer or Network Load Balancer).
- This ensures high availability, fault tolerance, and even distribution of traffic.
- In Kubernetes, use a `Service` of type `LoadBalancer` to expose your pods.
- For Docker Compose or EC2, place your containers behind an AWS ELB/ALB.

#### Recommended Node Specifications

Ensure each node has the following amount of resources available at runtime to avoid out-of-memory and CPU throttle like issues -

| Environment     | CPU (vCPUs) | Memory (GB) |
|-----------------|-------------|-------------|
| Dev/UAT         | 2           | 8           |
| Production      | 4           | 16          |

#### Enable Auto-Scaling

- Keep a check on CPU and Memory consumption of the deployed nodes
- Assign a appropriate threshold for **scaling up** and **scaling down** of nodes - eg: 50%
- Raise an event as soon as this threshold is breached and scale up/down the nodes accordingly
- Services like AWS Autoscaling, K8s HPA, etc. make this easy to implement

## SMS Extraction API

### Prerequisites

- Access to AWS ECR or other container registry
- Docker installed on the deployment machine
- AWS CLI configured (if using AWS ECR)

### Environment Variables

The application supports various environment variables to provide application with necessary runtime values -

| Variable                   | Description |
|----------------------------|-------------|
| `DB_USER`                  | Username for postgres database authentication |
| `DB_PASSWORD`              | Password for postgres database authentication |
| `DB_HOST`                  | Host address of postgres database server to connect |
| `DB_PORT`                  | Mapped port of postgres database server to connect |
| `DB_NAME`                  | Database name for postgres database connection |
| `VOCAB_USE_S3`             | `true` |
| `VOCAB_S3_BUCKET`          | `<credeau_asset_bucket>` |
| `VOCAB_S3_KEY`             | `clients/client_<client_id>/extractor/vocabulary/vocabulary.enc` |
| `VOCAB_S3_REGION`          | AWS Region Name shared by Credeau, for fetching the artifacts |
| `CLASSIFICATION_USE_S3`    | `true` |
| `CLASSIFICATION_S3_BUCKET` | `<credeau_asset_bucket>` |
| `CLASSIFICATION_S3_KEY`    | `clients/client_<client_id>/extractor/classification/classification.enc` |
| `CLASSIFICATION_S3_REGION` | AWS Region Name shared by Credeau, for fetching the artifacts |
| `REGEX_USE_S3`             | `true` |
| `REGEX_S3_BUCKET`          | `<credeau_asset_bucket>` |
| `REGEX_S3_KEY`             | `clients/client_<client_id>/extractor/regex/regex.enc` |
| `REGEX_S3_REGION`          | AWS Region Name shared by Credeau, for fetching the artifacts |
| `AWS_ACCESS_KEY_ID`        | AWS Access Key shared by Credeau, for fetching the artifacts |
| `AWS_SECRET_ACCESS_KEY`    | AWS Secret Key shared by Credeau, for fetching the artifacts |
| `AWS_DEFAULT_REGION`       | AWS Region Name shared by Credeau, for fetching the artifacts |

> ⚠️ **Note!**
>
> Following values will be provided by Credeau, during the integration -
>
> - `credeau_asset_bucket`
> - `client_id`

### Deployment: Using Docker

Pull the SMS Extraction API docker image from AWS ECR or similar container registry -

```bash
# For AWS ECR
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker pull <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-sms-extraction:<version>
```

Create a `.env` file with the following variables -

```bash
DB_USER="mobileforge_user"
DB_PASSWORD="your_secure_password"
DB_HOST="<host address of deployed PostgresSQL host>"
DB_PORT="5432"
DB_NAME="api_insights_db"
VOCAB_USE_S3="true"
VOCAB_S3_BUCKET="<credeau_asset_bucket>"
VOCAB_S3_KEY="clients/client_<client_id>/extractor/vocabulary/vocabulary.enc"
VOCAB_S3_REGION="ap-south-1"
CLASSIFICATION_USE_S3="true"
CLASSIFICATION_S3_BUCKET="<credeau_asset_bucket>"
CLASSIFICATION_S3_KEY="clients/client_<client_id>/extractor/classification/classification.en"
CLASSIFICATION_S3_REGION="ap-south-1"
REGEX_USE_S3="true"
REGEX_S3_BUCKET="<credeau_asset_bucket>"
REGEX_S3_KEY="clients/client_<client_id>/extractor/regex/regex.enc"
REGEX_S3_REGION="ap-south-1"
AWS_ACCESS_KEY_ID="aws access key id shared by Credeau"
AWS_SECRET_ACCESS_KEY="aws secret key shared by Credeau"
AWS_DEFAULT_REGION="aws region name shared by Credeau"
```

Now, run the container -

```bash
docker run -d \
    --name sms-extraction \
    --env-file .env \
    <account-id>.dkr.ecr.<region>.amazonaws.com/credeau-sms-extraction:<version>
```

### Production Readiness

#### Use Load Balancing

- For production deployments, expose your SMS Extraction API service using a load balancer (such as AWS Application Load Balancer or Network Load Balancer).
- This ensures high availability, fault tolerance, and even distribution of traffic.
- In Kubernetes, use a `Service` of type `LoadBalancer` to expose your pods.
- For Docker Compose or EC2, place your containers behind an AWS ELB/ALB.

#### Recommended Node Specifications

Ensure each node has the following amount of resources available at runtime to avoid out-of-memory and CPU throttle like issues -

| Environment     | CPU (vCPUs) | Memory (GB) |
|-----------------|-------------|-------------|
| Dev/UAT         | 2           | 8           |
| Production      | 4           | 16          |

#### Enable Auto-Scaling

- Keep a check on CPU and Memory consumption of the deployed nodes
- Assign a appropriate threshold for **scaling up** and **scaling down** of nodes - eg: 50%
- Raise an event as soon as this threshold is breached and scale up/down the nodes accordingly
- Services like AWS Autoscaling, K8s HPA, etc. make this easy to implement

## Scaling Ladder

The following table provides recommended node counts based on daily active users (DAU):

| DAU  | Insights API Nodes | SMS Extraction API Nodes |
|------|:------------------:|:------------------------:|
| 25K  | 1-2                | 1                        |
| 50K  | 2-5                | 1-3                      |
| 75K  | 4-7                | 2-4                      |
| 100K | 6-10               | 3-5                      |

---

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