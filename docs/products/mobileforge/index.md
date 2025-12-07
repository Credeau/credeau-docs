# MobileForge

MobileForge is a deployable device intelligence platform, that ensures all data collected from user's mobile devices can be securely transmitted to the institution's infrastructure, where profiling and processing take place — maintaining full control and compliance within institutional premises.

## Key Features

- Modular architecture
- Scalable deployment options
- Robust data syncing with minimal drops
- Powerful data features and insights for user profiling  
- Utilizes open-source databases (MongoDB and PostgreSQL) for efficient and reliable data storage

Explore the sections below to learn more about MobileForge's components, deployment strategies, scaling guidelines, and data schemas.

## Architecture Overview

The diagram below illustrates a typical deployment of the MobileForge platform. It is intended as a reference architecture showcasing how various components work together in a production-grade setup.

![MobileForge Architecture](../../assets/diagrams/mobile_forge_architecture_diagram.svg)

This architecture highlights key components such as -

1. Data ingestion from mobile devices
2. Secure transmission to institutional infrastructure
3. Robust data syncing
4. The combined use of MongoDB and PostgreSQL for optimized storage and profiling operations

> ⚠️ Note!
>
> The MobileForge platform,
> 
> 1. receives authentication keys, and 
> 2. shares API usage information
>
> with the Credeau servers. This information is used for billing and compliance purposes.
> 
> Apart from these, no other data point leaves the institution's premises, ensuring complete data privacy.

## Components

The MobileForge solution can be broken down into 2 major pipelines, where each is composed of modular services that can be independently scaled and deployed.

### 1. Data Sync

Responsible for securely ingesting data from mobile devices and storing it for downstream processing.

![Data Sync Pipeline Architecture](../../assets/diagrams/mobile_forge_architecture_diagram_data_sync_pipeline.svg)

Services -

- **Producer API**: Acts as an entry point to the system, receiving data from the SDK.

- **Kafka Stream**: Serves as the backbone for streaming data reliably between services.

- **Data Consumers**: Process incoming data from Kafka and store into the databases. These can be grouped basis the type of data source to consume.

- **Databases**:
    - **MongoDB**: Used for storing the raw data collected from users' devices.
    - **PostgreSQL**: Used for storing user metadata and API usage data.

### 2. Insights Generation

Provides APIs for reading, profiling, and deriving insights from the synced data.

![Insights Generation Pipeline Architecture](../../assets/diagrams/mobile_forge_architecture_diagram_insights_pipeline.svg)

Services -

- **Insights API**: Delivers processed insights by executing in-house algorithms and machine learning models on top of user's synced data.

- **Extraction API**: Extracts relevant financial signals from user's raw data.

- **Databases**:
    - **MongoDB**: Used for fetching the raw data collected from users' devices.
    - **PostgreSQL**: Used for fetching user metadata and storing derived insights from the raw data.
