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

### MongoDB Database Setup

#### Create databases and user

```javascript
// Connect to MongoDB
use admin

// Create application user
db.createUser({
  user: "credforge_user",
  pwd: "your_secure_password",
  roles: [
    { role: "readWrite", db: "cred_forge_db" }
  ]
})
```

#### Create collections in MongoDB

```javascript
// 1. Clients
db.createCollection("clients");
db.clients.createIndex({ "client_id": 1 });
db.clients.createIndex({ "auth_token": 1 });

// 2. Ecm Client Metadata
db.createCollection("ecm_client_metadata");
db.ecm_client_metadata.createIndex({ "client_id": 1 });
db.ecm_client_metadata.createIndex({ "engine": 1 });

// 3. Ecm Output Log
db.createCollection("ecm_output_log");
db.ecm_output_log.createIndex({ "reference_id": 1 });
db.ecm_output_log.createIndex({ "user_id": 1 });
db.ecm_output_log.createIndex({ "engine": 1 });
db.ecm_output_log.createIndex({ "request_id": 1 });
db.ecm_output_log.createIndex({ "client_id": 1 });

// 4. Ecm Request Log
db.createCollection("ecm_request_log");
db.ecm_request_log.createIndex({ "reference_id": 1 });
db.ecm_request_log.createIndex({ "user_id": 1 });
db.ecm_request_log.createIndex({ "request_id": 1 });
db.ecm_request_log.createIndex({ "engine": 1 });
db.ecm_request_log.createIndex({ "client_id": 1 });

// 5. Ecm Response Log
db.createCollection("ecm_response_log");
db.ecm_response_log.createIndex({ "reference_id": 1 });
db.ecm_response_log.createIndex({ "request_id": 1 });
db.ecm_response_log.createIndex({ "user_id": 1 });
db.ecm_response_log.createIndex({ "engine": 1 });
db.ecm_response_log.createIndex({ "client_id": 1 });

// 6. Request Workflow State
db.createCollection("request_workflow_state");
db.request_workflow_state.createIndex({ "client_id": 1 });
db.request_workflow_state.createIndex({ "created_date": 1 });
db.request_workflow_state.createIndex({ "user_id": 1 });
db.request_workflow_state.createIndex({ "request_id": 1 });
db.request_workflow_state.createIndex({ "reference_id": 1 });
db.request_workflow_state.createIndex({ "workflow_strategy": 1 });
db.request_workflow_state.createIndex({ "workflow_endpoint": 1 });

// 7. Unauthorized Requests
db.createCollection("unauthorized_requests");
db.unauthorized_requests.createIndex({ "client_id": 1 });
db.unauthorized_requests.createIndex({ "request_id": 1 });

// 8. Usage
db.createCollection("usage");
db.usage.createIndex({ "client_id": 1 });
db.usage.createIndex({ "request_id": 1 });
db.usage.createIndex({ "api_name": 1 });

// 9. Workflow Configs
db.createCollection("workflow_configs");
db.workflow_configs.createIndex({ "workflow_name": 1 });
db.workflow_configs.createIndex({ "client_id": 1 });

// 10. Workflow Endpoint Config
db.createCollection("workflow_endpoint_config");
db.workflow_endpoint_config.createIndex({ "workflow_endpoint": 1 });
db.workflow_endpoint_config.createIndex({ "client_id": 1 });

// 11. Workflow Event Log
db.createCollection("workflow_event_log");
db.workflow_event_log.createIndex({ "client_id": 1 });
db.workflow_event_log.createIndex({ "reference_id": 1 });
db.workflow_event_log.createIndex({ "request_id": 1 });
db.workflow_event_log.createIndex({ "user_id": 1 });
db.workflow_event_log.createIndex({ "event_type": 1 });
```

### Important Notes

1. Replace `your_secure_password` with a strong, secure password in all scripts
2. Ensure proper network security rules are in place before running these scripts
3. For production environments, use AWS Secrets Manager or similar services to manage credentials
4. Regularly rotate database credentials
5. Monitor database access logs for any unauthorized access attempts

## Security Considerations

1. Always use strong passwords
2. Enable encryption at rest
3. Configure network security (firewalls, security groups)
4. Regular backups
5. Monitor database performance and logs
6. Keep databases updated with security patches

## Backup and Recovery

### MongoDB
- Regular automated backups
- Point-in-time recovery (for DocumentDB)
- Backup verification
- Recovery testing

### PostgreSQL
- Automated snapshots
- Point-in-time recovery
- WAL archiving
- Backup verification
- Recovery testing

## Monitoring

1. Set up CloudWatch metrics (for AWS deployments)
2. Configure database-specific monitoring tools
3. Set up alerts for:
   - High CPU usage
   - Low disk space
   - Connection count
   - Error rates
   - Replication lag

## Maintenance

1. Regular security updates
2. Performance optimization
3. Index maintenance
4. Vacuum operations (PostgreSQL)
5. Database statistics updates

## Scaling Ladder

The following table provides recommended node specifications and counts for PostgreSQL and MongoDB deployments at various Daily Active User (DAU) scales.

- **PostgreSQL**: 1GB RAM, 2 vCPU, 25GB disk (3000 IOPS, 125 MBPS)
- **MongoDB**: 4GB RAM, 2 vCPU, 100GB disk (3000 IOPS, 125 MBPS)

| Requests / Day | PostgreSQL Nodes| MongoDB Nodes |
|----------------|:---------------:|:-------------:|
| **10K**        | 1               | 1             |
| **25K**        | 2               | 2             |
| **50K**        | 3               | 3             |
| **75K**        | 4               | 4             |
| **100K**       | 5               | 5             |

**Notes:**

- For high availability and failover, consider running at least 2 nodes (primary + standby/replica) at all times, even at lower DAU.
- Scale up node count and/or instance size if you observe CPU, RAM, or disk IOPS/throughput consistently above 50% utilization.
- Adjust disk size and IOPS as data volume grows.
- Monitor database metrics and tune accordingly.