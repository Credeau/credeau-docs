# Deployment: Security Overview

This document outlines the security features implemented across the MobileForge platform to ensure data protection at every stage — from data collection on the device, through transit, to storage and access on the backend infrastructure.

## Security Architecture Overview

MobileForge is deployed as an on-premise solution within the client's own cloud environment (AWS/GCP/Azure) or on-premise data centres. This ensures that all user data remains within the client's infrastructure boundary and never leaves their controlled environment.

The platform implements a defence-in-depth strategy with security controls applied at the following layers:

1. SDK Authentication
2. Data Privacy (On-Device PII Masking)
3. Transport Security
4. Data Compression
5. Storage Encryption
6. Network Isolation & Access Control

---

## SDK Authentication

The SDK is embedded within the client's mobile application and initialised with a `client_id`, `auth_token`, and a `backend_host_url` pointing to the application servers deployed in the client's premises.

### Token Encryption Mechanism

- The SDK encrypts the authentication token using **AES-128 bit encryption** with a randomly generated salt before every API call.
- Due to the random salt, a **unique encrypted token value** is generated for each request — ensuring no two API calls carry the same token payload.
- The backend validates the incoming encrypted token by decrypting and matching it against the original token stored in the database.
- The **original plaintext token never travels over the network**, eliminating the risk of token interception or replay attacks.

### Unauthorized Request Logging

- All requests that fail authentication are logged in a dedicated `unauthorized_requests` table for audit and monitoring purposes.

---

## Data Privacy: On-Device PII Masking

Before any data leaves the user's device, the SDK performs **on-device masking** of all Personally Identifiable Information (PII). This ensures that sensitive user data is never transmitted to or stored on the backend servers.

Additionally, **no user data travels out of the client's premises**. The backend servers do not communicate any user or business data to external systems. The only outbound communication from these servers to the outside world is limited to:

1. **Credeau's Auth API** — for usage reporting and health metrics.
2. **Credeau's Content Delivery Networks** — for fetching encrypted artifacts (models, configurations) required by the application services to function. These artifacts are regularly updated by Credeau's team on a weekly/bi-weekly cadence to keep the system current with the latest improvements.

### Masked Data Categories

| Category | Examples |
|----------|----------|
| Names | Full names, first/last names |
| Phone Numbers | Mobile numbers, contact numbers |
| Identity Documents | Aadhaar numbers, PAN numbers, Voter ID, Passport numbers |
| OTPs | One-Time Passwords from SMS |
| URLs & Links | Hyperlinks embedded in messages |
| Email Addresses | Personal and business email IDs |
| Financial Identifiers | Account numbers, UPI IDs |

The masking is performed locally on the device before data is prepared for sync, ensuring that PII data is **never transmitted** over the network or stored in any backend database.

---

## Transport Security

All communication between the SDK and backend services is secured using industry-standard transport layer encryption.

### TLS Configuration

- All API endpoints are exposed exclusively over **HTTPS**.
- Minimum supported protocol version: **TLS 1.2** (or greater).
- Ensures protection against eavesdropping, man-in-the-middle attacks, and data tampering during transit.
- To enforce all the above measures, the SDK is configured to **reject endpoints** that are non-secure (plain HTTP), resolve to private IP ranges (e.g., `10.x.x.x`, `192.168.x.x`), point to localhost addresses (`127.0.0.1`), or attempt HTTP redirects to a different host — preventing SSRF and DNS rebinding class attacks.

---

## Data Compression

To optimise network utilisation and reduce bandwidth consumption, the SDK applies **gzip compression** on all data payloads before transmission.

### Benefits

- Reduced network load and faster sync times.
- Lower data transfer costs for end users on metered connections.
- Minimised exposure window during data transit due to shorter transfer durations.

---

## Storage Encryption (Encryption at Rest)

Once data enters the backend system, all persistent storage is protected with disk-level encryption.

### Encryption Standard

- All database disks (MongoDB and PostgreSQL) are encrypted using **AES-256 bit encryption**.
- This applies to both managed database services (e.g., AWS DocumentDB, Amazon RDS) and self-hosted deployments.
- Encryption is applied at the storage volume level, ensuring all data — including indexes, logs, and temporary files — is protected.

---

## Network Isolation & Access Control

MobileForge is designed with a strict network isolation model to minimise the attack surface.

### Internal Services (Private Network)

The following components are deployed within **private subnets** (behind NAT gateways) and are **not accessible from the public internet**:

- Kafka Message Brokers
- Consumer Services
- MongoDB Databases
- PostgreSQL Databases
- SMS Extraction API

### Publicly Accessible Services

Only the following endpoints are exposed to external networks:

| Service | Exposure | Access Control |
|---------|----------|----------------|
| Producer API (Data Sync) | Public | SDK communicates with this endpoint over the public internet from end-user devices; secured via token-based authentication (see SDK Authentication above) |
| Insights API | Public / Private | Client's backend servers call this API; can be hosted on a private network if the client's servers share network access, or exposed publicly with IP-based firewall rules |

### Recommended Network Infrastructure

![MobileForge Solution Diagram](https://cdn.credeau.com/static/images/mobile-forge-cloud-agnostic-solution.png)

---

## Security Assessments & Code Reviews

### Vulnerability Assessment and Penetration Testing (VAPT)

- The platform undergoes regular **VAPT assessments** conducted by third-party CERT-In empanelled entities.
- These assessments are performed on a periodic basis to identify and remediate vulnerabilities across all deployed components.
- Findings are triaged, prioritised, and addressed before each release cycle.

### Automated Security Scanning

- The product development lifecycle includes **active security scans at the source code level** to detect and address all recommended threats.
- These scans are integrated into the CI/CD pipeline as automated processes, ensuring that vulnerabilities are caught early — before code reaches production.
- Scans cover common threat categories including OWASP Top 10, dependency vulnerabilities, and static code analysis findings.

---

## Security Summary

| Layer | Mechanism | Standard |
|-------|-----------|----------|
| Authentication | AES-encrypted token with random salt | AES-128 |
| Data Privacy | On-device PII masking before sync | — |
| Transport | HTTPS with TLS | TLS 1.2+ |
| Compression | Gzip compression on payloads | — |
| Storage | Disk-level encryption at rest | AES-256 |
| Network | Private subnets, NAT, IP allowlisting | — |
| Access Control | Firewall rules, Security Groups | — |

---

## Compliance Considerations

- **Data Residency**: All data remains within the client's infrastructure boundary. No data is transmitted to external servers.
- **Audit Logging**: All API requests (both authorised and unauthorised) are logged with timestamps, client identifiers, and request metadata for audit trail purposes.
- **Credential Management**: Authentication tokens and database credentials should be managed using secret management services (e.g., AWS Secrets Manager, HashiCorp Vault) and rotated periodically.
