# Deployment: CredForge Databases

This document outlines the deployment steps for the required databases: MongoDB 7.0 and PostgreSQL 16.

## Database Requirements

- MongoDB 7.0
- PostgreSQL 16

## Deployment Methods

### 1. Docker Compose (Recommended for Dev Testing Environments)

#### MongoDB 7.0

```yaml
version: '3.8'
services:
  mongodb:
    image: mongo:7.0
    container_name: mongodb
    ports:
      - "27017:27017"
    environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=your_secure_password
    volumes:
      - mongodb_data:/data/db

volumes:
  mongodb_data:
```

#### PostgreSQL 16

```yaml
version: '3.8'
services:
  postgres:
    image: postgres:16
    container_name: postgres
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_USER=admin
      - POSTGRES_PASSWORD=your_secure_password
      - POSTGRES_DB=postgres
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

To deploy using Docker Compose:

1. Create a `docker-compose.yml` file with both services
2. Run `docker-compose up -d`
3. Verify services are running with `docker-compose ps`

### 2. Custom Installation on Ubuntu 22.04 (Recommended for UAT Environments)

#### MongoDB 7.0 Installation

Import MongoDB public GPG key:
```bash
curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
```

Create list file for MongoDB:
```bash
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
```

Update package database and install MongoDB:
```bash
sudo apt-get update
sudo apt-get install -y mongodb-org
```

Start and enable MongoDB:
```bash
sudo systemctl start mongod
sudo systemctl enable mongod
```

#### PostgreSQL 16 Installation

Add PostgreSQL repository:
```bash
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
```

Install PostgreSQL:
```bash
sudo apt-get update
sudo apt-get install -y postgresql-16
```

Start and enable PostgreSQL:
```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

### 3. AWS Managed Databases (Recommended for Production Environments)

#### Amazon DocumentDB (MongoDB Compatible)

1. Create a DocumentDB cluster:
   - Go to AWS Console → DocumentDB
   - Click "Create cluster"
   - Select engine version compatible with MongoDB 7.0
   - Configure instance class (recommended: db.r6g.large or higher)
   - Set up VPC and security groups
   - Configure backup retention period
   - Set up encryption at rest

2. Configure security:
   - Configure security groups to allow access from application servers

#### Amazon RDS for PostgreSQL 16

1. Create an RDS instance:
   - Go to AWS Console → RDS
   - Click "Create database"
   - Choose PostgreSQL 16
   - Select instance class (recommended: db.r6g.large or higher)
   - Configure storage (recommended: 100GB+ with autoscaling)
   - Set up VPC and security groups
   - Enable Multi-AZ deployment for high availability
   - Configure backup retention period
   - Enable encryption at rest

2. Configure security:
   - Configure security groups to allow access from application servers

## Database Schema Setup

### PostgreSQL Database Setup

#### Required PostgreSQL Databases

- `cred_forge_db`

#### Create database and user:

```sql
-- Create databases
CREATE DATABASE cred_forge_db;

-- Create user with password
CREATE USER credforge_user WITH PASSWORD 'your_secure_password';

-- Grant privileges for api_insights_db
GRANT CONNECT ON DATABASE cred_forge_db TO credforge_user;
GRANT USAGE ON SCHEMA public TO credforge_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO credforge_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO credforge_user;

-- Set default privileges for future tables in both databases
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO credforge_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public 
GRANT USAGE, SELECT ON SEQUENCES TO credforge_user;
```

#### Create Tables

Database to use - `cred_forge_db`

```sql
CREATE TABLE forge_request_workflow_state (
    request_id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255),
    reference_id VARCHAR(255),
    client_id VARCHAR(255),
    workflow_endpoint VARCHAR(255),
    workflow_strategy VARCHAR(255),
    workflow_config JSONB,
    input_json JSONB DEFAULT '{}'::jsonb,
    ecm JSONB,
    features JSONB,
    rules_output JSONB,
    engine_history JSONB,
    created_at TIMESTAMP NOT NULL,
    created_date TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

-- Optional indices for better query performance
CREATE INDEX idx_request_workflow_state_reference_id ON forge_request_workflow_state(reference_id);
CREATE INDEX idx_request_workflow_state_user_id ON forge_request_workflow_state(user_id);
CREATE INDEX idx_request_workflow_state_request_id ON forge_request_workflow_state(request_id);
CREATE INDEX idx_request_workflow_state_client_id ON forge_request_workflow_state(client_id);
CREATE INDEX idx_request_workflow_state_workflow_endpoint ON forge_request_workflow_state(workflow_endpoint);
CREATE INDEX idx_request_workflow_state_workflow_strategy ON forge_request_workflow_state(workflow_strategy);
CREATE INDEX idx_request_workflow_state_created_date ON forge_request_workflow_state(created_date);

CREATE TABLE forge_ecm_response_log (
    id SERIAL PRIMARY KEY,
    request_id VARCHAR(255) NOT NULL,
    user_id VARCHAR(255),
    reference_id VARCHAR(255),
    engine VARCHAR(255),
    client_id VARCHAR(255),
    external_status VARCHAR(255),
    external_response_code INTEGER,
    external_retries INTEGER,
    external_latency FLOAT,
    ecm_data_source VARCHAR(255),
    ecm_message VARCHAR(255),
    metadata_json JSONB,
    ecm_status_code INTEGER,
    created_at TIMESTAMP NOT NULL,
    created_date TIMESTAMP NOT NULL
);

-- Indices for better query performance
CREATE INDEX idx_ecm_response_log_request_id ON forge_ecm_response_log(request_id);
CREATE INDEX idx_ecm_response_log_reference_id ON forge_ecm_response_log(reference_id);
CREATE INDEX idx_ecm_response_log_user_id ON forge_ecm_response_log(user_id);
CREATE INDEX idx_ecm_response_log_engine ON forge_ecm_response_log(engine);
CREATE INDEX idx_ecm_response_log_created_date ON forge_ecm_response_log(created_date);

CREATE TABLE forge_application_logs (
    id CHAR(36),
    request_id VARCHAR(255),
    client_id VARCHAR(255),
    reference_id VARCHAR(255),
    user_id VARCHAR(255),
    forge_component VARCHAR(255) NOT NULL,
    api_endpoint VARCHAR(255),
    engine_name VARCHAR(255),
    workflow_name VARCHAR(255),
    level VARCHAR(50) NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    message TEXT NOT NULL,
    extra_data JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (timestamp, id)
) ENGINE=InnoDB
PARTITION BY RANGE (UNIX_TIMESTAMP(timestamp)) (
    PARTITION p_first VALUES LESS THAN (UNIX_TIMESTAMP('2024-01-01 00:00:00'))
);

-- Create indexes
CREATE INDEX idx_application_logs_request_id ON forge_application_logs(request_id);
CREATE INDEX idx_application_logs_client_id ON forge_application_logs(client_id);
CREATE INDEX idx_application_logs_reference_id ON forge_application_logs(reference_id);
CREATE INDEX idx_application_logs_user_id ON forge_application_logs(user_id);
CREATE INDEX idx_application_logs_forge_component ON forge_application_logs(forge_component);
CREATE INDEX idx_application_logs_api_endpoint ON forge_application_logs(api_endpoint);
CREATE INDEX idx_application_logs_engine_name ON forge_application_logs(engine_name);
CREATE INDEX idx_application_logs_workflow_name ON forge_application_logs(workflow_name);
CREATE INDEX idx_application_logs_level ON forge_application_logs(level);
```