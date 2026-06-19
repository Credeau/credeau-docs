# AccountGator Transaction APIs

The AccountGator Transaction APIs provide programmatic access to fetch bank account transactions — sourced via Account Aggregators or Bank Statement Analyzers — using consent collected through the AccountGator SDK. Built on top of these transactions, our intelligent analysis engine delivers actionable insights and financial intelligence for credit decisioning, fraud detection, and customer financial profiling.

## Base URL

```bash
https://insights.account-gator.credeau.com
```

## Variables

The following variables will be referenced throughout this documentation:

| Variable                 | Description                             | Format                                                       | Source                                               |
| ------------------------ | --------------------------------------- | ------------------------------------------------------------ | ---------------------------------------------------- |
| `client_id`              | Unique identifier for your organisation | Alphanumeric string                                          | Provided by Credeau during onboarding                |
| `auth_token`             | Secret token for API authentication     | Alphanumeric string                                          | Provided by Credeau during onboarding                |
| `user_id`                | Unique identifier for an end user       | Alphanumeric string                                          | Provided by Credeau during onboarding                |
| `redirect_url`           | URL to redirect to post process         | Like, https://yourdomain.com/redirection/path                | Set by client as per requirement                     |
| `template_name`          | Account Aggregator template name        | Either `BANK_STATEMENT_PERIODIC` or `BANK_STATEMENT_ONETIME` | Set by client as per requirement                     |
| `customer_mobile_number` | End user's mobile number                | Like, 9999999999                                             | Provided by customer during journey                  |
| `request_id`             | Unique request identifier               | Alphanumeric string                                          | Received in API response                             |
| `aa_session_id`          | [AA Session ID ↗](./sdk/web.md#output)  | Alphanumeric string                                          | Received after consent journey on AccountGator SDK   |
| `consent_handle`         | Consent handle for a specific consent   | UUID string                                                  | Received from AccountGator SDK after consent journey |

> ⚠️ **Note**
>
> Keep these credentials secure and never share them publicly. These credentials are unique to your organization and will be used to authenticate all API requests.

## Authentication

The API requires two authentication headers:

| Header         | Value                          |
| -------------- | ------------------------------ |
| `x-client-id`  | [`<client_id>` ↗](#variables)  |
| `x-auth-token` | [`<auth_token>` ↗](#variables) |

and, one content type header:

| Header         | Value              |
| -------------- | ------------------ |
| `Content-Type` | `application/json` |

## Account Aggregator Endpoints

### Fetch Transactions

Once a customer provides consent successfully via the AccountGator SDK, use the details received in the SDK response to fetch bank account transactions for the customer.

**Single-consent flow** — when a single consent template was requested via the SDK (`template_name`), omit `consent_handle`. The API resolves the consent handle automatically.

**Multi-consent flow** — when multiple consent templates were requested via the SDK (`consent_templates`), the SDK returns multiple consent handles. Pass the relevant [`<consent_handle>` ↗](#variables) in each `fetch_data` call to fetch transactions for that specific consent.

```bash
/aa/fetch_data
```

#### Request

Request Body -

| Parameter           | Type   | Required | Description                                                                                                                                  |
| ------------------- | ------ | -------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `user_id`           | string | Yes      | [`<user_id>` ↗](#variables)                                                                                                                  |
| `aa_session_id`     | string | Yes      | [`<aa_session_id>` ↗](#variables)                                                                                                            |
| `datetimerangefrom` | string | Yes      | Statement start date in `MM/DD/YYYY HH:MM:SS AM/PM` format                                                                                   |
| `datetimerangeto`   | string | Yes      | Statement end date in `MM/DD/YYYY HH:MM:SS AM/PM` format                                                                                     |
| `consent_handle`    | string | No       | [`<consent_handle>` ↗](#variables). Required in multi-consent flows; omit in single-consent flows where the handle is resolved automatically |
| `generate_insights` | bool   | No       | If `true`, API returns transaction insights in `insights` response key                                                                       |

cURL (single-consent flow) -

```bash
curl --location 'https://insights.account-gator.credeau.com/aa/fetch_data' \
--header 'x-client-id: <client_id>' \
--header 'x-auth-token: <auth_token>' \
--header 'Content-Type: application/json' \
--data '{
	"user_id": "<user_id>",
	"aa_session_id": "<aa_session_id>",
	"datetimerangefrom": "01/01/2026 12:00:00 AM",
	"datetimerangeto": "04/22/2026 11:59:59 PM",
	"generate_insights": true
}'
```

cURL (multi-consent flow) -

```bash
curl --location 'https://insights.account-gator.credeau.com/aa/fetch_data' \
--header 'x-client-id: <client_id>' \
--header 'x-auth-token: <auth_token>' \
--header 'Content-Type: application/json' \
--data '{
	"user_id": "<user_id>",
	"aa_session_id": "<aa_session_id>",
	"datetimerangefrom": "01/01/2026 12:00:00 AM",
	"datetimerangeto": "06/01/2026 11:59:59 PM",
	"consent_handle": "<consent_handle>",
	"generate_insights": false
}'
```

> ⚠️ **Note:**
>
> Account Aggregator APIs work well with time range up to 6 Months.

#### Success Response (HTTP 200)

Body parameters -

| Field Name         | Type   | Description                                                      |
| ------------------ | ------ | ---------------------------------------------------------------- |
| `user_id`          | string | [`<user_id>` ↗](#variables)                                      |
| `request_id`       | string | [`<request_id>` ↗](#variables)                                   |
| `aa_session_id`    | string | [`<aa_session_id>` ↗](#variables)                                |
| `success`          | bool   | Flag indicating if the request was success or not                |
| `service`          | string | Name of AccountAggregator Service used to fetch the transactions |
| `service_response` | object | Transactions response provided by the the Account Aggregator     |
| `insights`         | object | Insights object returned when `generate_insights` is `true`      |

Raw JSON -

```json
{
  "user_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "request_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "aa_session_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "success": true,
  "service": "finvu",
  "service_response": {
    "consent_status": "ACCEPTED",
    "consent_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "fi_request_status": "ready",
    "fetched_data": {
      "header": {
        "channelId": "xxxxxxxxxx",
        "rid": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
        "ts": "2026-04-22T07:17:47.210+00:00"
      },
      "body": [
        {
          "fipId": "HDFC-FIP",
          "fipName": "HDFC Bank",
          "custId": "xxxxxxxxxx@xxxxx",
          "consentId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "sessionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
          "fiAccountInfo": [
            {
              "accountRefNo": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
              "linkRefNo": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
            }
          ],
          "fiObjects": [
            {
              "Profile": {
                "Holders": {
                  "Holder": {
                    "name": "CUSTOMER NAME",
                    "dob": "2000-01-01",
                    "mobile": "xxxxxxxxxx",
                    "nominee": "REGISTERED",
                    "landline": "",
                    "address": "xxxxxx xxxxxxxxx xxxx xxxxxxx xxxxx",
                    "email": "xxxxxxxxxx@xxxxx.xxx",
                    "pan": "xxxxxxxxxx",
                    "ckycRegistered": "YES"
                  },
                  "type": "SINGLE"
                }
              },
              "Summary": {
                "currentBalance": "100000",
                "currency": "INR",
                "balanceDateTime": "2026-04-22T12:47:45.000+00:00",
                "accountType": "REGULAR",
                "accountSubType": "SAVINGS",
                "branch": "xxxxxxxxxx",
                "facility": "OVERDRAFT",
                "ifsc": "xxxxxxxxxx",
                "micrCode": "xxxxxxxxx",
                "openingDate": "2020-01-01",
                "currentODLimit": "0",
                "drawingLimit": "0",
                "status": "ACTIVE",
                "pendingTxns": {
                  "PendingTxn": [
                    {
                      "transactionType": "UNKNOWN",
                      "amount": 0
                    }
                  ]
                }
              },
              "Transactions": {
                "Transaction": [
                  {
                    "type": "DEBIT",
                    "mode": "OTHERS",
                    "amount": 10000,
                    "transactionalBalance": "90000.00",
                    "transactionTimestamp": "2026-01-02T14:18:07.000+00:00",
                    "valueDate": "2026-01-02T14:18:07.000Z",
                    "txnId": "xxxxxxxxxxxxxxxx",
                    "narration": "UPI-ANOTHER_USER  NAME-xxxxxxxxxx@PTHDFC-xxxxxxxxxxx-xxxxxxxxxxxx-NA",
                    "reference": "xxxxxxxxxxxxxxxx"
                  },
                  {
                    "type": "CREDIT",
                    "mode": "OTHERS",
                    "amount": 10000,
                    "transactionalBalance": "100000.00",
                    "transactionTimestamp": "2026-01-08T17:06:52.000+00:00",
                    "valueDate": "2026-01-08T17:06:52.000Z",
                    "txnId": "xxxxxxxxxxxxxxxx",
                    "narration": "UPI-ANOTHER_USER  NAME-xxxxxxxxxx@PTHDFC-xxxxxxxxxxx-xxxxxxxxxxxx-NA",
                    "reference": "xxxxxxxxxxxxxxxx"
                  }
                ],
                "startDate": "2026-01-01",
                "endDate": "2026-04-22"
              },
              "type": "deposit",
              "maskedAccNumber": "XXXXXXXXXXzzzz",
              "version": "2.0.0",
              "linkedAccRef": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
              "schemaLocation": "http://api.rebit.org.in/FISchema/deposit https://specifications.rebit.org.in/api_schema/account_aggregator/FISchema/deposit_v2.0.0.xsd"
            }
          ]
        }
      ]
    }
  },
  "insights": {
    "user_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "request_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "data_requested_time": "2026-05-26 09:09:46",
    "cutoff_date": "2026-05-26 09:09:46",
    "format_type": "finvu_json",
    "fetch_extraction_report": false,
    "fetch_txn_data": false,
    "bank_name": "XXXXXXXXXX BANK",
    "account_number": "XXXXXX8434",
    "account_type": "REGULAR",
    "ifsc_code": "XXXXXXXXXXX",
    "account_branch": "XXXXXXXXXX",
    "account_open_date": "2023-07-24",
    "account_od_limit": 0.0,
    "account_drawing_limit": 28560.71,
    "account_status": "ACTIVE",
    "account_currency": "INR",
    "account_current_balance": 28560.71,
    "account_current_balance_datetime": "2026-05-26 20:09:43",
    "account_holder_name": "CUSTOMER NAME",
    "account_holder_dob": "2000-01-01",
    "account_holder_mobile": "xxxxxxxxxx",
    "account_holder_nominee": "NOT-REGISTERED",
    "account_holder_landline": ""
  }
}
```

> ⚠️ **Note:**
>
> The structure of `service_response` field might differ across different Account Aggregator providers.

#### Error Response (HTTP 4xx/5xx)

Body Parameters -

| Field Name             | Type   | Description                        |
| ---------------------- | ------ | ---------------------------------- |
| `detail`               | object | Details of the error occurred      |
| `detail.error`         | string | Error message indicating the issue |
| `detail.request_id`    | string | [`<request_id>` ↗](#variables)     |
| `detail.user_id`       | string | [`<user_id>` ↗](#variables)        |
| `detail.aa_session_id` | string | [`<aa_session_id>` ↗](#variables)  |

Raw JSON -

```json
{
  "detail": {
    "error": "error message indicating the issue",
    "request_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "user_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "aa_session_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
}
```

### Download Transactions Report

```bash
/aa/retrieve_report
```

#### Request

Get a link to download CSV report of the transactions fetched against a `user_id` and `aa_session_id` combination in the [Fetch Transactions API](#fetch-transactions).

Request Body -

| Parameter              | Type   | Required | Description                                                                           |
| ---------------------- | ------ | -------- | ------------------------------------------------------------------------------------- |
| `user_id`              | string | Yes      | [`<user_id>` ↗](#variables)                                                           |
| `aa_session_id`        | string | Yes      | [`<aa_session_id>` ↗](#variables)                                                     |
| `generate_insights`    | bool   | No       | If `true`, API returns transaction insights in `insights` response key                |
| `fetch_current_report` | bool   | No       | If `true`, fetches latest transactions for recurring consent before generating report |

cURL -

```bash
curl --location 'https://insights.account-gator.credeau.com/aa/retrieve_report' \
--header 'x-client-id: <client_id>' \
--header 'x-auth-token: <auth_token>' \
--header 'Content-Type: application/json' \
--data '{
	"user_id": "<user_id>",
	"aa_session_id": "<aa_session_id>",
	"generate_insights": true,
	"fetch_current_report": true
}'
```

#### Success Response (HTTP 200)

Body parameters -

| Field Name   | Type   | Description                                                 |
| ------------ | ------ | ----------------------------------------------------------- |
| `report_url` | string | URL to download the transactions report                     |
| `request_id` | string | [`<request_id>` ↗](#variables)                              |
| `insights`   | object | Insights object returned when `generate_insights` is `true` |

Raw JSON -

```json
{
  "report_url": "...",
  "request_id": "<request_id>",
  "insights": {
    "user_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "request_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "bank_name": "XXXXXXXXXX BANK",
    "account_number": "XXXXXX8434"
  }
}
```

#### Error Response (HTTP 4xx/5xx)

Body Parameters -

| Field Name             | Type   | Description                        |
| ---------------------- | ------ | ---------------------------------- |
| `detail`               | object | Details of the error occurred      |
| `detail.error`         | string | Error message indicating the issue |
| `detail.request_id`    | string | [`<request_id>` ↗](#variables)     |
| `detail.user_id`       | string | [`<user_id>` ↗](#variables)        |
| `detail.aa_session_id` | string | [`<aa_session_id>` ↗](#variables)  |

Raw JSON -

```json
{
  "detail": {
    "error": "error message indicating the issue",
    "request_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "user_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    "aa_session_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
}
```

> ⚠️ **Note:**
>
> The download URL is active for 7 Days. Post expiry, you can hit the API again to get a new URL.

## Bank Statement Analyzer (BSA) Endpoints

The Bank Statement Analyzer (BSA) flow is used when the customer’s statements are collected via **bank statement upload / analysis** (instead of the Account Aggregator consent pull). This flow is driven by the same `user_id` and `aa_session_id` that you receive after the consent/journey on the AccountGator SDK.

Typical flow:

1. Call [`/bsa/status_check`](#status-check) to confirm the session is ready / completed
2. (Optional) Call [`/bsa/fetch_uploaded`](#fetch-uploaded-files) to list uploaded statement files and download URLs
3. Call [`/bsa/fetch_data`](#fetch-analyzed-data) to fetch the parsed statement output (and optionally insights)

### Status Check

Use this endpoint to check whether the BSA session is ready/completed and whether you can call `fetch_data`.

```bash
/bsa/status_check
```

#### Request

Request Body -

| Parameter       | Type   | Required | Description                       |
| --------------- | ------ | -------- | --------------------------------- |
| `user_id`       | string | Yes      | [`<user_id>` ↗](#variables)       |
| `aa_session_id` | string | Yes      | [`<aa_session_id>` ↗](#variables) |

cURL -

```bash
curl --location 'https://insights.account-gator.credeau.com/bsa/status_check' \
--header 'x-client-id: <client_id>' \
--header 'x-auth-token: <auth_token>' \
--header 'Content-Type: application/json' \
--data '{
	"user_id":"<user_id>",
	"aa_session_id":"<aa_session_id>"
}'
```

#### Success Response (HTTP 200)

Body parameters -

| Field Name             | Type   | Description                                                  |
| ---------------------- | ------ | ------------------------------------------------------------ |
| `request_id`           | string | [`<request_id>` ↗](#variables)                               |
| `user_id`              | string | [`<user_id>` ↗](#variables)                                  |
| `aa_session_id`        | string | [`<aa_session_id>` ↗](#variables)                            |
| `ready_for_fetch_data` | bool   | `true` when `fetch_data` can be called                       |
| `status`               | string | Processing status for the session (for example: `completed`) |
| `error`                | object | Error details (null when request is successful)              |

Raw JSON -

```json
{
  "request_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "user_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "aa_session_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "ready_for_fetch_data": true,
  "status": "completed",
  "error": null
}
```

### Fetch Uploaded Files

Use this endpoint to list the statement files uploaded for a given `user_id` + `aa_session_id`.

```bash
/bsa/fetch_uploaded
```

#### Request

Request Body -

| Parameter       | Type   | Required | Description                       |
| --------------- | ------ | -------- | --------------------------------- |
| `user_id`       | string | Yes      | [`<user_id>` ↗](#variables)       |
| `aa_session_id` | string | Yes      | [`<aa_session_id>` ↗](#variables) |

cURL -

```bash
curl --location 'https://insights.account-gator.credeau.com/bsa/fetch_uploaded' \
--header 'x-client-id: <client_id>' \
--header 'x-auth-token: <auth_token>' \
--header 'Content-Type: application/json' \
--data '{
	"user_id":"<user_id>",
	"aa_session_id":"<aa_session_id>"
}'
```

#### Success Response (HTTP 200)

Body parameters -

| Field Name               | Type          | Description                                                    |
| ------------------------ | ------------- | -------------------------------------------------------------- |
| `request_id`             | string        | [`<request_id>` ↗](#variables)                                 |
| `user_id`                | string        | [`<user_id>` ↗](#variables)                                    |
| `aa_session_id`          | string        | [`<aa_session_id>` ↗](#variables)                              |
| `files`                  | array<object> | List of uploaded files (may be empty)                          |
| `files[].name`           | string        | Original filename provided by the end user                     |
| `files[].generated_name` | string        | System-generated filename/key (treat as sensitive identifier)  |
| `files[].uploaded_at`    | string        | Upload timestamp in ISO-8601 format                            |
| `files[].file_password`  | string        | Password for the statement file (if applicable). **Sensitive** |
| `files[].url`            | string        | Pre-signed download URL. **Sensitive**                         |

Raw JSON -

```json
{
  "request_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "user_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "aa_session_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "files": [
    {
      "name": "statement.pdf",
      "generated_name": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.pdf",
      "uploaded_at": "2026-06-02T07:12:00.143000",
      "file_password": "<redacted>",
      "url": "<redacted>"
    }
  ]
}
```

#### Error Response (HTTP 4xx/5xx)

Body Parameters -

| Field Name          | Type   | Description                        |
| ------------------- | ------ | ---------------------------------- |
| `detail`            | object | Details of the error occurred      |
| `detail.error`      | string | Error message indicating the issue |
| `detail.request_id` | string | [`<request_id>` ↗](#variables)     |
| `detail.user_id`    | string | [`<user_id>` ↗](#variables)        |

Raw JSON -

```json
{
  "detail": {
    "error": "no valid uploaded files found for this user and aa_session_id",
    "request_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "user_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  }
}
```

### Fetch Analyzed Data

Use this endpoint to fetch the analyzed statement output for the session. This returns parsed customer info, statement metadata, summary aggregates, and account transactions. Optionally, you can request additional derived insights using `generate_insights`.

```bash
/bsa/fetch_data
```

#### Request

Request Body -

| Parameter           | Type   | Required | Description                                                  |
| ------------------- | ------ | -------- | ------------------------------------------------------------ |
| `user_id`           | string | Yes      | [`<user_id>` ↗](#variables)                                  |
| `aa_session_id`     | string | Yes      | [`<aa_session_id>` ↗](#variables)                            |
| `generate_insights` | bool   | No       | If `true`, includes additional derived insights (if enabled) |

cURL -

```bash
curl --location 'https://insights.account-gator.credeau.com/bsa/fetch_data' \
--header 'x-client-id: <client_id>' \
--header 'x-auth-token: <auth_token>' \
--header 'Content-Type: application/json' \
--data '{
	"user_id":"<user_id>",
	"aa_session_id":"<aa_session_id>",
	"generate_insights": false
}'
```

#### Success Response (HTTP 200)

Body parameters -

| Field Name         | Type   | Description                                                          |
| ------------------ | ------ | -------------------------------------------------------------------- |
| `request_id`       | string | [`<request_id>` ↗](#variables)                                       |
| `user_id`          | string | [`<user_id>` ↗](#variables)                                          |
| `aa_session_id`    | string | [`<aa_session_id>` ↗](#variables)                                    |
| `status`           | string | Processing status for the session (for example: `completed`)         |
| `error`            | object | Error details (null when request is successful)                      |
| `service_response` | object | BSA output payload (structure may evolve based on upstream analyzer) |

Raw JSON -

```json
{
  "request_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "user_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "aa_session_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "status": "completed",
  "error": null,
  "service_response": {
    "customerInfo": {
      "name": "<redacted>",
      "address": "<redacted>",
      "landline": "<redacted>",
      "mobile": "<redacted>",
      "email": "<redacted>",
      "pan": "<redacted>",
      "perfiosTransactionId": "<redacted>",
      "customerTransactionId": "<redacted>",
      "bank": "HDFC Bank, India",
      "instId": 20
    },
    "statementdetails": [
      {
        "fileName": "statement.pdf",
        "statementStatus": "VERIFIED",
        "customerInfo": {
          "name": "<redacted>",
          "address": "<redacted>",
          "landline": "<redacted>",
          "mobile": "<redacted>",
          "email": "<redacted>",
          "pan": "<redacted>",
          "bank": "HDFC Bank, India"
        },
        "statementAccounts": [
          {
            "accountNo": "<redacted>",
            "accountType": "Bank",
            "xnsStartDate": "2025-02-01",
            "xnsEndDate": "2025-02-28"
          }
        ]
      }
    ],
    "summaryInfo": {
      "instName": "HDFC Bank, India",
      "accNo": "<redacted>",
      "accType": "Savings Account",
      "fullMonthCount": 24,
      "total": {
        "balAvg": 19769.84,
        "balMax": 48526.75,
        "balMin": 14105.2,
        "cashDeposits": 0,
        "cashWithdrawals": 0,
        "chqDeposits": 0,
        "chqIssues": 0,
        "credits": 12,
        "debits": 22,
        "emiOrLoans": 2,
        "inwBounces": 0,
        "loanDisbursals": 1,
        "outwBounces": 0,
        "salaries": 0,
        "totalCashDeposit": 0,
        "totalCashWithdrawal": 0,
        "totalChqDeposit": 0,
        "totalChqIssue": 0,
        "totalCredit": 104607,
        "totalDebit": 106366.55,
        "totalEmiOrLoan": 7310,
        "totalLoanDisbursal": 2834,
        "totalSalary": 0
      },
      "average": {
        "balAvg": 823.74,
        "balMax": 2021.95,
        "balMin": 587.72,
        "cashDeposits": 0,
        "cashWithdrawals": 0,
        "chqDeposits": 0,
        "chqIssues": 0,
        "credits": 0,
        "debits": 1,
        "emiOrLoans": 0,
        "inwBounces": 0,
        "loanDisbursals": 0,
        "outwBounces": 0,
        "salaries": 0,
        "totalCashDeposit": 0,
        "totalCashWithdrawal": 0,
        "totalChqDeposit": 0,
        "totalChqIssue": 0,
        "totalCredit": 4358.63,
        "totalDebit": 4431.94,
        "totalEmiOrLoan": 304.58,
        "totalLoanDisbursal": 118.08,
        "totalSalary": 0
      }
    },
    "monthlyDetails": [],
    "fCUAnalysis": {
      "possibleFraudIndicators": {
        "suspiciousBankEStatements": {
          "status": "false"
        }
      },
      "behaviouralTransactionalIndicators": {}
    },
    "accountXns": [
      {
        "accountNo": "<redacted>",
        "accountType": "Savings Account",
        "xns": [
          {
            "date": "2025-02-01",
            "chqNo": "<redacted>",
            "narration": "<redacted>",
            "amount": 4000,
            "balance": 5760.75
          },
          {
            "date": "2025-02-01",
            "chqNo": "<redacted>",
            "narration": "<redacted>",
            "amount": -1,
            "balance": 5759.75
          }
        ]
      }
    ]
  }
}
```

#### Error Response (HTTP 4xx/5xx)

Body Parameters -

| Field Name          | Type   | Description                        |
| ------------------- | ------ | ---------------------------------- |
| `detail`            | object | Details of the error occurred      |
| `detail.error`      | string | Error message indicating the issue |
| `detail.request_id` | string | [`<request_id>` ↗](#variables)     |
| `detail.user_id`    | string | [`<user_id>` ↗](#variables)        |

Raw JSON -

```json
{
  "detail": {
    "error": "no bsa sessions found for this user and aa_session_id",
    "request_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    "user_id": "null"
  }
}
```

> ⚠️ **Note:**
>
> The structure of `service_response` can vary based on the upstream statement analyzer and may include additional keys not documented here. You should parse defensively and avoid strict schema assumptions on nested fields unless explicitly contracted.

## Common API Errors

### Unauthorized (HTTP 401)

This error occurs when either an invalid client ID or authentication token is provided in the request headers.

Response -

```json
{
  "error": {
    "type": "unauthorized",
    "detail": "Invalid client credentials"
  }
}
```

> ⚠️ **Note**
>
> If you receive this error:
>
> 1. Verify that you're using the correct client ID and authentication token
> 2. Contact Credeau support

### Forbidden (HTTP 403)

This error can occur when the requesting IP address is not whitelisted in Credeau's firewall. For security reasons, all API requests must originate from pre-approved IP addresses.

Response -

```html
<html>
  <head>
    <title>403 Forbidden</title>
  </head>

  <body>
    <center>
      <h1>403 Forbidden</h1>
    </center>
  </body>
</html>
```

> ⚠️ **Note**
>
> To resolve this error:
>
> 1. Contact Credeau support to whitelist your IP address
> 2. Provide your organization's name and the IP address(es) that need access
> 3. Once whitelisted, you'll be able to access the API from the approved IP addresses

### Unprocessable Entity (HTTP 422)

This error is returned when any of the required parameters is missing from the request payload. The response includes details about which fields are missing and the received input.

Response -

```json
{
  "error": {
    "type": "validation_error",
    "detail": [
      {
        "type": "missing",
        "loc": ["body", "user_id"],
        "msg": "Field required",
        "input": {
          "aa_session_id": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        }
      }
    ]
  }
}
```

> ⚠️ **Note**
>
> If you receive this error:
>
> 1. Verify that you're passing all the required fields in the request payload
> 2. Contact Credeau support

### Too Many Requests (HTTP 429)

This error is returned when the rate of requests exceeds the allowed limit of requests per IP.

Best practice for rate limit handling -

When implementing retries for rate-limited requests:

1. Use exponential backoff: Start with a base delay (e.g., 1 second) and double it after each retry
2. Add jitter: Include random variation (±20%) to the delay to prevent thundering herd problems

Example implementation:

```python
import random
import time
def get_retry_delay(attempt, base_delay=1, max_delay=60):
    # Calculate exponential backoff
    delay = min(base_delay * (2 ** attempt), max_delay)
    # Add jitter (±20%)
    jitter = delay * 0.2
    return delay + random.uniform(-jitter, jitter)
```

This approach helps distribute retry attempts and prevents overwhelming the API when rate limits are hit.
