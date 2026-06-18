# Deployment: MobileForge Databases

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

- `api_insights_db` (main application database)

#### Create database and user:

```sql
-- Create databases
CREATE DATABASE api_insights_db;

-- Create user with password
CREATE USER mobileforge_user WITH PASSWORD 'your_secure_password';

-- Grant privileges for api_insights_db
GRANT CONNECT ON DATABASE api_insights_db TO mobileforge_user;
GRANT USAGE ON SCHEMA public TO mobileforge_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO mobileforge_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO mobileforge_user;
```

#### Create Tables

Database to use - `api_insights_db`

=== "Usual Postgres"

	```sql
	-- public.api_request_dump definition
	CREATE TABLE public.api_request_dump (
		request_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT (now() AT TIME ZONE 'UTC'::text) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		request_dump json NOT NULL,
		api_name varchar(128) NOT NULL,
		CONSTRAINT api_request_dump_pkey PRIMARY KEY (request_id)
	);

	CREATE INDEX idx_api_request_dump_api_name ON public.api_request_dump USING btree (api_name);
	CREATE INDEX idx_api_request_dump_client_id ON public.api_request_dump USING btree (client_id);
	CREATE INDEX idx_api_request_dump_created_at ON public.api_request_dump USING btree (created_at);
	CREATE INDEX idx_api_request_dump_request_id ON public.api_request_dump USING btree (request_id);
	CREATE INDEX idx_api_request_dump_user_id ON public.api_request_dump USING btree (user_id);

	-- public.api_response_dump definition
	CREATE TABLE public.api_response_dump (
		request_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT (now() AT TIME ZONE 'UTC'::text) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		response_dump json NULL,
		time_to_featurize float8 NULL,
		time_json json NULL,
		api_name varchar(128) NOT NULL,
		CONSTRAINT api_response_dump_pkey PRIMARY KEY (request_id)
	);

	CREATE INDEX idx_api_response_dump_api_name ON public.api_response_dump USING btree (api_name);
	CREATE INDEX idx_api_response_dump_client_id ON public.api_response_dump USING btree (client_id);
	CREATE INDEX idx_api_response_dump_created_at ON public.api_response_dump USING btree (created_at);
	CREATE INDEX idx_api_response_dump_request_id ON public.api_response_dump USING btree (request_id);
	CREATE INDEX idx_api_response_dump_user_id ON public.api_response_dump USING btree (user_id);

	-- public.clients definition
	CREATE TABLE public.clients (
		id bigint GENERATED ALWAYS AS IDENTITY,
		client_id varchar(72) NOT NULL,
		email varchar(32) NULL,
		auth_token varchar(36) NOT NULL,
		created_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
		updated_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
		geography varchar(128) DEFAULT 'india'::character varying NOT NULL,
		CONSTRAINT clients_pkey PRIMARY KEY (id, created_at)
	);

	CREATE INDEX idx_clients_client_id ON public.clients USING btree (client_id);

	-- public.fetch_extracted_request_dump definition
	CREATE TABLE public.fetch_extracted_request_dump (
		request_id varchar(128) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		cutoff_date varchar(128) NOT NULL,
		CONSTRAINT fetch_extracted_request_dump_pkey PRIMARY KEY (request_id, created_at)
	) PARTITION BY RANGE (created_at);

	CREATE INDEX idx_fetch_extracted_req_client_id ON public.fetch_extracted_request_dump USING btree (client_id);
	CREATE INDEX idx_fetch_extracted_req_user_id ON public.fetch_extracted_request_dump USING btree (user_id);

	-- public.fetch_extracted_response_dump definition
	CREATE TABLE public.fetch_extracted_response_dump (
		request_id varchar(128) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		response_dump json NULL,
		time_to_featurize float8 NULL,
		time_json json NULL,
		CONSTRAINT fetch_extracted_response_dump_pkey PRIMARY KEY (request_id, created_at)
	) PARTITION BY RANGE (created_at);

	CREATE INDEX idx_fetch_extracted_resp_client_id ON public.fetch_extracted_response_dump USING btree (client_id);
	CREATE INDEX idx_fetch_extracted_resp_user_id ON public.fetch_extracted_response_dump USING btree (user_id);

	-- public.insights_request_dump definition
	CREATE TABLE public.insights_request_dump (
		request_id varchar(128) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		cutoff_date varchar(128) NOT NULL,
		CONSTRAINT insights_request_dump_pkey PRIMARY KEY (request_id, created_at)
	) PARTITION BY RANGE (created_at);

	CREATE INDEX idx_insights_req_client_id ON public.insights_request_dump USING btree (client_id);
	CREATE INDEX idx_insights_req_user_id ON public.insights_request_dump USING btree (user_id);

	-- public.insights_response_dump definition
	CREATE TABLE public.insights_response_dump (
		request_id varchar(128) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		response_dump json NULL,
		time_to_featurize float8 NULL,
		time_json json NULL,
		groupings json DEFAULT '[]'::json NOT NULL,
		CONSTRAINT insights_response_dump_pkey PRIMARY KEY (request_id, created_at)
	) PARTITION BY RANGE (created_at);

	CREATE INDEX idx_insights_resp_client_id ON public.insights_response_dump USING btree (client_id);
	CREATE INDEX idx_insights_resp_user_id ON public.insights_response_dump USING btree (user_id);

	-- public.sync_events_log definition
	CREATE TABLE public.sync_events_log (
		id bigint GENERATED ALWAYS AS IDENTITY,
		event_type varchar(128) NULL,
		event_value varchar(128) NULL,
		sync_request_id varchar(128) NULL,
		client_id varchar(128) NOT NULL,
		user_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		CONSTRAINT sync_events_log_pkey PRIMARY KEY (id, created_at)
	) PARTITION BY RANGE (created_at);

	CREATE INDEX idx_sync_events_log_client_id ON public.sync_events_log USING btree (client_id);
	CREATE INDEX idx_sync_events_log_sync_request_id ON public.sync_events_log USING btree (sync_request_id);
	CREATE INDEX idx_sync_events_log_user_id ON public.sync_events_log USING btree (user_id);

	-- public.unauthorized_requests definition
	CREATE TABLE public.unauthorized_requests (
		id bigint GENERATED ALWAYS AS IDENTITY,
		client_id varchar(128) NOT NULL,
		request_id varchar(128) NOT NULL,
		auth_token varchar(256) NOT NULL,
		req_body json NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		CONSTRAINT unauthorized_requests_pkey PRIMARY KEY (id, created_at)
	) PARTITION BY RANGE (created_at);

	CREATE INDEX idx_unauthorized_requests_client_id ON public.unauthorized_requests USING btree (client_id);

	-- public."usage" definition
	CREATE TABLE public."usage" (
		id bigint GENERATED ALWAYS AS IDENTITY,
		request_id varchar(128) NULL,
		client_id varchar(128) NOT NULL,
		api_name varchar(128) NOT NULL,
		response_code int4 NULL,
		created_at timestamp NOT NULL,
		CONSTRAINT usage_pkey PRIMARY KEY (id, created_at)
	) PARTITION BY RANGE (created_at);

	CREATE INDEX idx_usage_api_name ON public.usage USING btree (api_name);
	CREATE INDEX idx_usage_client_id ON public.usage USING btree (client_id);
	```

=== "Aurora Limitless Postgres"

	```sql
	-- public.api_request_dump definition
	CREATE TABLE public.api_request_dump (
		request_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT (now() AT TIME ZONE 'UTC'::text) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		request_dump json NOT NULL,
		api_name varchar(128) NOT NULL,
		CONSTRAINT api_request_dump_pkey PRIMARY KEY (request_id)
	);

	CREATE INDEX idx_api_request_dump_api_name ON public.api_request_dump USING btree (api_name);
	CREATE INDEX idx_api_request_dump_client_id ON public.api_request_dump USING btree (client_id);
	CREATE INDEX idx_api_request_dump_created_at ON public.api_request_dump USING btree (created_at);
	CREATE INDEX idx_api_request_dump_request_id ON public.api_request_dump USING btree (request_id);
	CREATE INDEX idx_api_request_dump_user_id ON public.api_request_dump USING btree (user_id);

	-- public.api_response_dump definition
	CREATE TABLE public.api_response_dump (
		request_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT (now() AT TIME ZONE 'UTC'::text) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		response_dump json NULL,
		time_to_featurize float8 NULL,
		time_json json NULL,
		api_name varchar(128) NOT NULL,
		CONSTRAINT api_response_dump_pkey PRIMARY KEY (request_id)
	);

	CREATE INDEX idx_api_response_dump_api_name ON public.api_response_dump USING btree (api_name);
	CREATE INDEX idx_api_response_dump_client_id ON public.api_response_dump USING btree (client_id);
	CREATE INDEX idx_api_response_dump_created_at ON public.api_response_dump USING btree (created_at);
	CREATE INDEX idx_api_response_dump_request_id ON public.api_response_dump USING btree (request_id);
	CREATE INDEX idx_api_response_dump_user_id ON public.api_response_dump USING btree (user_id);

	-- public.clients definition
	CREATE SEQUENCE public.clients_id_seq;

	CREATE TABLE public.clients (
		id bigint NOT NULL DEFAULT nextval('public.clients_id_seq'::regclass),
		client_id varchar(72) NOT NULL,
		email varchar(32) NULL,
		auth_token varchar(36) NOT NULL,
		created_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
		updated_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
		geography varchar(128) DEFAULT 'india'::character varying NOT NULL,
		CONSTRAINT clients_pkey PRIMARY KEY (id, created_at)
	);

	ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;

	CREATE INDEX idx_clients_client_id ON public.clients USING btree (client_id);

	-- public.fetch_extracted_request_dump definition
	CREATE TABLE public.fetch_extracted_request_dump (
		request_id varchar(128) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		cutoff_date varchar(128) NOT NULL,
		CONSTRAINT fetch_extracted_request_dump_pkey PRIMARY KEY (request_id, created_at)
	);

	CREATE INDEX idx_fetch_extracted_req_client_id ON public.fetch_extracted_request_dump USING btree (client_id);
	CREATE INDEX idx_fetch_extracted_req_user_id ON public.fetch_extracted_request_dump USING btree (user_id);

	-- public.fetch_extracted_response_dump definition
	CREATE TABLE public.fetch_extracted_response_dump (
		request_id varchar(128) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		response_dump json NULL,
		time_to_featurize float8 NULL,
		time_json json NULL,
		CONSTRAINT fetch_extracted_response_dump_pkey PRIMARY KEY (request_id, created_at)
	);

	CREATE INDEX idx_fetch_extracted_resp_client_id ON public.fetch_extracted_response_dump USING btree (client_id);
	CREATE INDEX idx_fetch_extracted_resp_user_id ON public.fetch_extracted_response_dump USING btree (user_id);

	-- public.insights_request_dump definition
	CREATE TABLE public.insights_request_dump (
		request_id varchar(128) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		cutoff_date varchar(128) NOT NULL,
		CONSTRAINT insights_request_dump_pkey PRIMARY KEY (request_id, created_at)
	);

	CREATE INDEX idx_insights_req_client_id ON public.insights_request_dump USING btree (client_id);
	CREATE INDEX idx_insights_req_user_id ON public.insights_request_dump USING btree (user_id);

	-- public.insights_response_dump definition
	CREATE TABLE public.insights_response_dump (
		request_id varchar(128) NOT NULL,
		user_id varchar(128) NOT NULL,
		client_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		response_dump json NULL,
		time_to_featurize float8 NULL,
		time_json json NULL,
		groupings json DEFAULT '[]'::json NOT NULL,
		CONSTRAINT insights_response_dump_pkey PRIMARY KEY (request_id, created_at)
	);

	CREATE INDEX idx_insights_resp_client_id ON public.insights_response_dump USING btree (client_id);
	CREATE INDEX idx_insights_resp_user_id ON public.insights_response_dump USING btree (user_id);

	-- public.sync_events_log definition
	CREATE SEQUENCE public.sync_events_log_id_seq;

	CREATE TABLE public.sync_events_log (
		id bigint NOT NULL DEFAULT nextval('public.sync_events_log_id_seq'::regclass),
		event_type varchar(128) NULL,
		event_value varchar(128) NULL,
		sync_request_id varchar(128) NULL,
		client_id varchar(128) NOT NULL,
		user_id varchar(128) NOT NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		CONSTRAINT sync_events_log_pkey PRIMARY KEY (id, created_at)
	);

	ALTER SEQUENCE public.sync_events_log_id_seq OWNED BY public.sync_events_log.id;

	CREATE INDEX idx_sync_events_log_client_id ON public.sync_events_log USING btree (client_id);
	CREATE INDEX idx_sync_events_log_sync_request_id ON public.sync_events_log USING btree (sync_request_id);
	CREATE INDEX idx_sync_events_log_user_id ON public.sync_events_log USING btree (user_id);

	-- public.unauthorized_requests definition
	CREATE SEQUENCE public.unauthorized_requests_id_seq;

	CREATE TABLE public.unauthorized_requests (
		id bigint NOT NULL DEFAULT nextval('public.unauthorized_requests_id_seq'::regclass),
		client_id varchar(128) NOT NULL,
		request_id varchar(128) NOT NULL,
		auth_token varchar(256) NOT NULL,
		req_body json NULL,
		created_at timestamp DEFAULT now() NOT NULL,
		CONSTRAINT unauthorized_requests_pkey PRIMARY KEY (id, created_at)
	);

	ALTER SEQUENCE public.unauthorized_requests_id_seq OWNED BY public.unauthorized_requests.id;

	CREATE INDEX idx_unauthorized_requests_client_id ON public.unauthorized_requests USING btree (client_id);

	-- public."usage" definition
	CREATE SEQUENCE public.usage_id_seq;

	CREATE TABLE public."usage" (
		id bigint NOT NULL DEFAULT nextval('public.usage_id_seq'::regclass),
		request_id varchar(128) NULL,
		client_id varchar(128) NOT NULL,
		api_name varchar(128) NOT NULL,
		response_code int4 NULL,
		created_at timestamp NOT NULL,
		CONSTRAINT usage_pkey PRIMARY KEY (id, created_at)
	);

	ALTER SEQUENCE public.usage_id_seq OWNED BY public.usage.id;

	CREATE INDEX idx_usage_api_name ON public.usage USING btree (api_name);
	CREATE INDEX idx_usage_client_id ON public.usage USING btree (client_id);
	```

> Note:
>
> All the heavy tables are partitioned on `created_at` timestamp field. Which can be used to further create daily/weekly/monthly partitions based on analytical use cases.


#### Create Table Partitions

Create helper function to create daily partitions on target tables for `N` days in advance -

```sql
CREATE OR REPLACE FUNCTION public.create_daily_partition(parent_table text, partition_date date, days_ahead integer DEFAULT 0)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    partition_name text;
    partition_start timestamp;
    partition_end timestamp;
    partition_col_name text;
    d date := partition_date;
    end_date date := partition_date + days_ahead;
BEGIN
    -- Detect the partition key column
    SELECT a.attname INTO partition_col_name
    FROM pg_partitioned_table pt
    JOIN pg_class c ON pt.partrelid = c.oid
    JOIN pg_attribute a ON a.attrelid = pt.partrelid AND a.attnum = ANY(pt.partattrs)
    WHERE c.relname = parent_table
    LIMIT 1;

    IF partition_col_name IS NULL THEN
        RAISE EXCEPTION 'Partition column not found for table %', parent_table;
    END IF;

    -- Iterate using WHILE loop (safe for DATE)
    WHILE d <= end_date LOOP
        partition_start := d::timestamp;
        partition_end := (d + 1)::timestamp;
        partition_name := parent_table || '_' || to_char(d, 'YYYY_MM_DD');

        BEGIN
            IF NOT EXISTS (
                SELECT 1
                FROM pg_class c
                JOIN pg_namespace n ON n.oid = c.relnamespace
                WHERE c.relname = partition_name
                AND n.nspname = 'public'
            ) THEN
                EXECUTE format(
                    'CREATE TABLE IF NOT EXISTS %I PARTITION OF %I FOR VALUES FROM (%L) TO (%L)',
                    partition_name,
                    parent_table,
                    partition_start,
                    partition_end
                );

                RAISE NOTICE 'Created partition % for table % on %', partition_name, parent_table, partition_col_name;
            END IF;

        EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE 'Failed to create partition %: %', partition_name, SQLERRM;
        END;

        d := d + INTERVAL '1 day';
    END LOOP;

    RETURN;
END;
$function$
;
```

Execute, or set crons for -

```sql
SELECT create_daily_partition('usage', CURRENT_DATE, 10);
SELECT create_daily_partition('unauthorized_requests', CURRENT_DATE, 10);
SELECT create_daily_partition('sync_events_log', CURRENT_DATE, 10);
SELECT create_daily_partition('insights_response_dump', CURRENT_DATE, 10);
SELECT create_daily_partition('insights_request_dump', CURRENT_DATE, 10);
SELECT create_daily_partition('fetch_extracted_response_dump', CURRENT_DATE, 10);
SELECT create_daily_partition('fetch_extracted_request_dump', CURRENT_DATE, 10);
```

> Note!
>
> Above steps can also be triggered using external scheduled actions like `Linux Cron`, `Airflow Scheduled DAGs`, etc.

To setup crons using `pg_cron` -

Enable `pg_cron` -

```sql
CREATE EXTENSION IF NOT EXISTS pg_cron;

SELECT * FROM pg_extension WHERE extname = 'pg_cron';

GRANT USAGE ON SCHEMA cron TO mobileforge_user;

GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA cron TO mobileforge_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA cron GRANT EXECUTE ON FUNCTIONS TO mobileforge_user;
```

Set crons -

```sql
SELECT cron.schedule(
  'create_daily_partitions_for_usage',
  '0 0 * * *',
  $$SELECT create_daily_partition('usage', CURRENT_DATE, 10);$$
);

SELECT cron.schedule(
  'create_daily_partitions_for_unauthorized_requests',
  '0 0 * * *',
  $$SELECT create_daily_partition('unauthorized_requests', CURRENT_DATE, 10);$$
);

SELECT cron.schedule(
  'create_daily_partitions_for_sync_events_log',
  '0 0 * * *',
  $$SELECT create_daily_partition('sync_events_log', CURRENT_DATE, 10);$$
);

SELECT cron.schedule(
  'create_daily_partitions_for_insights_response_dump',
  '0 0 * * *',
  $$SELECT create_daily_partition('insights_response_dump', CURRENT_DATE, 10);$$
);

SELECT cron.schedule(
  'create_daily_partitions_for_insights_request_dump',
  '0 0 * * *',
  $$SELECT create_daily_partition('insights_request_dump', CURRENT_DATE, 10);$$
);

SELECT cron.schedule(
  'create_daily_partitions_for_fetch_extracted_response_dump',
  '0 0 * * *',
  $$SELECT create_daily_partition('fetch_extracted_response_dump', CURRENT_DATE, 10);$$
);

SELECT cron.schedule(
  'create_daily_partitions_for_fetch_extracted_request_dump',
  '0 0 * * *',
  $$SELECT create_daily_partition('fetch_extracted_request_dump', CURRENT_DATE, 10);$$
);
```

#### Cleanup old partitions `[Optional]`

> Note!
>
> As certain tables are automatically partitioned in the above step, those can also be automatically cleaned to restore space on the database.

Create a function to purge partitions of target table older than `N` days -

```sql
CREATE OR REPLACE FUNCTION public.cleanup_old_partitions_for_table(parent_table text, retention_days integer DEFAULT 90)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    partition_record record;
    partition_date date;
BEGIN
    FOR partition_record IN 
        SELECT tablename, schemaname
        FROM pg_tables 
        WHERE schemaname = 'public' 
        AND tablename LIKE parent_table || '_%_%_%'  
    LOOP
        BEGIN
            partition_date := to_date(
                split_part(partition_record.tablename, '_', 2) || '_' ||
                split_part(partition_record.tablename, '_', 3) || '_' ||
                split_part(partition_record.tablename, '_', 4),
                'YYYY_MM_DD'
            );

            IF partition_date < current_date - retention_days THEN
                EXECUTE format('DROP TABLE IF EXISTS %I.%I', 
                               partition_record.schemaname, 
                               partition_record.tablename);
                
                INSERT INTO partition_operations_log (table_name, partition_name, operation_type, status)
                VALUES (parent_table, 
                       partition_record.tablename, 
                       'DROP',
                       'dropped: older than ' || retention_days || ' days');
            END IF;
        EXCEPTION WHEN OTHERS THEN
            -- Optional: skip partitions with bad names
            CONTINUE;
        END;
    END LOOP;
END;
$function$
;
```

For example -

To purge partitions of `usage` table post 90 days,

Execute, or set crons for -

```sql
SELECT cleanup_old_partitions_for_table('usage', 90);
```

> Note!
>
> Above steps can also be triggered using external scheduled actions like `Linux Cron`, `Airflow Scheduled DAGs`, etc.

```sql
SELECT cron.schedule(
  'cleanup_partitions_for_usage',
  '0 0 * * *',
  $$SELECT cleanup_old_partitions_for_table('usage', 90);$$
);
```

Similarly, partition purging can be applied on other tables as well.

#### Add authentication tokens

```sql
-- Master auth token for enabling the tools
INSERT INTO public.clients (client_id, email, auth_token, geography)
VALUES (
    'credentials',         -- client_id (required)
    'contact@example.com', -- email (nullable)
    '<auth_token>',        -- auth_token (required)
    'india'                -- geography (optional, defaults to 'india')
);

-- SDK auth token embedded in SDK for Authentication
INSERT INTO public.clients (client_id, email, auth_token, geography)
VALUES (
    '<client_id>',         -- client_id (required)
    'contact@example.com', -- email (nullable)
    '<uuid>',              -- auth_token (required)
    'india'                -- geography (optional, defaults to 'india')
);

-- Auth token used by internal servers to fetch insights
INSERT INTO public.clients (client_id, email, auth_token, geography)
VALUES (
    '<client_id>_insights', -- client_id (required)
    'contact@example.com',  -- email (nullable)
    '<uuid>',               -- auth_token (required)
    'india'                 -- geography (optional, defaults to 'india')
);
```

> **Note**:
>
> - `client_id` - a preferred name of organization unit
> - `auth_token` - will be provided by Credeau during onboarding
> - `uuid` - A 36 chars long unique alphanumeric string

Generating uuid (Python) -

```python
import uuid

token = str(uuid.uuid4())
print(f'your authentication token - {token}')
```

### MongoDB Database Setup

#### Create databases and user

```javascript
// Connect to MongoDB
use admin

// Create application user
db.createUser({
  user: "mobileforge_user",
  pwd: "your_secure_password",
  roles: [
    { role: "readWrite", db: "sync_db" }
  ]
})
```

#### Create collections in MongoDB

```javascript
// Switch to sync_db database
use sync_db

// Create collections with indexes (without validators)

// 1. Device Sync Request Device Data
db.createCollection("device_sync_request_device_data")
db.device_sync_request_device_data.createIndex({ "client_id": 1, "user_id": 1 })
db.device_sync_request_device_data.createIndex({ "request_id": 1 })

// 2. Call Logs Sync Request Data
db.createCollection("call_logs_sync_request_call_logs_data")
db.call_logs_sync_request_call_logs_data.createIndex({ "client_id": 1, "user_id": 1 })

// 3. Device Sync Request Apps Data
db.createCollection("device_sync_request_apps_data")
db.device_sync_request_apps_data.createIndex({ "client_id": 1, "user_id": 1 })

// 4. Contacts Sync Request Data
db.createCollection("contacts_sync_request_contacts_data")
db.contacts_sync_request_contacts_data.createIndex({ "client_id": 1, "user_id": 1 })

// 5. Device Transpose
db.createCollection("device_transpose")
db.device_transpose.createIndex({ "client_id": 1 })
db.device_transpose.createIndex({ "value": 1 })
db.device_transpose.createIndex({ "value_type": 1 })

// 6. Device Sync Request iOS Device Data
db.createCollection("device_sync_request_ios_device_data")
db.device_sync_request_ios_device_data.createIndex({ "client_id": 1, "user_id": 1 })
db.device_sync_request_ios_device_data.createIndex({ "request_id": 1 })

// 7. SMS Sync Request Data
db.createCollection("sms_sync_request_sms_data")
db.sms_sync_request_sms_data.createIndex({ "client_id": 1, "user_id": 1 })

// 8. Device ID Mapper
db.createCollection("device_id_mapper")
db.device_id_mapper.createIndex({ "android_id": 1 })
db.device_id_mapper.createIndex({ "app_device_id": 1 })
db.device_id_mapper.createIndex({ "device_id": 1 })
db.device_id_mapper.createIndex({ "assembled_id": 1 })
db.device_id_mapper.createIndex({ "client_id": 1 })
db.device_id_mapper.createIndex({ "google_adv_id": 1 })
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

- **PostgreSQL**: 4GB RAM, 2 vCPU, 200GB disk (3000 IOPS, 125 MBPS)
- **MongoDB**: 16GB RAM, 4 vCPU, 2TB disk (12000 IOPS, 500 MBPS)

| DAU      | PostgreSQL Nodes| MongoDB Nodes |
|----------|:---------------:|:-------------:|
| **25K**  | 1               | 1             |
| **50K**  | 1-2             | 1-2           |
| **75K**  | 2-3             | 2-3           |
| **100K** | 3-4             | 3-4           |

**Notes:**

- For high availability and failover, consider running at least 2 nodes (primary + standby/replica) at all times, even at lower DAU.
- Scale up node count and/or instance size if you observe CPU, RAM, or disk IOPS/throughput consistently above 50% utilization.
- Adjust disk size and IOPS as data volume grows.
- Monitor database metrics and tune accordingly.