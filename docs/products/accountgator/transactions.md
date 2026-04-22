# AccountGator Transaction APIs

The AccountGator Transaction APIs provides programmatic access to fetch bank account transactions (Account Aggregators or Bank Statement Analysers) with consent collected using Account Gator SDK, and on top of these transactions our intelligent transaction analysis engine, delivers actionable insights and financial intelligence for enhanced credit decisioning, fraud detection, and customer financial profiling.

## Base URL

```bash
https://insights.account-gator.credeau.com
```

## Variables

The following variables will be referenced throughout this documentation:

| Variable                 | Description                             | Format                                                       | Source                                             |
|--------------------------|-----------------------------------------|--------------------------------------------------------------|----------------------------------------------------|
| `client_id`              | Unique identifier for your organisation | Alphanumeric string                                          | Provided by Credeau during onboarding              |
| `auth_token`             | Secret token for API authentication     | Alphanumeric string                                          | Provided by Credeau during onboarding              |
| `user_id`                | Unique identifier for an end user       | Alphanumeric string                                          | Provided by Credeau during onboarding              |
| `redirect_url`           | URL to redirect to post process         | Like, https://yourdomain.com/redirection/path                | Set by client as per requirement                   |
| `template_name`          | Account Aggregator template name        | Either `BANK_STATEMENT_PERIODIC` or `BANK_STATEMENT_ONETIME` | Set by client as per requirement                   |
| `customer_mobile_number` | End user's mobile number                | Like, 9999999999                                             | Provided by customer during journey                |
| `request_id`             | Unique request identifier               | Alphanumeric string                                          | Received in API response                           |
| `aa_session_id`          | [AA Session ID ↗](./sdk/web.md#output)    | Alphanumeric string                                          | Received after consent journey on AccountGator SDK |

> ⚠️ **Note**
>
> Keep these credentials secure and never share them publicly. These credentials are unique to your organization and will be used to authenticate all API requests.

## Authentication

The API requires two authentication headers:

| Header | Value |
|--------|-------|
| `x-client-id` | `<client_id>` |
| `x-auth-token` | `<auth_token>` |

and, one content type header:

| Header | Value |
|--------|-------|
| `Content-Type` | `application/json` |

## Account Aggregator Endpoints

### Fetch Transactions

```bash
/aa/fetch_data
```

#### Request

Request Body -

| Parameter           | Type   | Required   | Description                                                |
|---------------------|--------|------------|------------------------------------------------------------|
| `user_id`           | string | Yes | Test | `<user_id>`                                                |
| `aa_session_id`     | string | Yes | Test | `<aa_session_id>`                                          |
| `datetimerangefrom` | string | Yes | Test | Statement start date in `MM/DD/YYYY HH:MM:SS AM/PM` format |
| `datetimerangeto`   | string | Yes | Test | Statement end date in `MM/DD/YYYY HH:MM:SS AM/PM` format   |

cURL -

```bash
curl --location 'https://insights.account-gator.credeau.com/aa/fetch_data' \
--header 'x-client-id: <client_id>' \
--header 'x-auth-token: <auth_token>' \
--header 'Content-Type: application/json' \
--data '{
	"user_id": "<user_id>",
	"aa_session_id": "<aa_session_id>",
	"datetimerangefrom": "01/01/2026 12:00:00 AM",
	"datetimerangeto": "04/22/2026 11:59:59 PM"
}'
```

> ⚠️ **Note:**
>
> Account Aggregator APIs work well with time range up to 6 Months.

#### Success Response (HTTP 200)

Body parameters -

| Field Name         | Type   | Description                                                      |
|--------------------|--------|------------------------------------------------------------------|
| `user_id`          | string | `<user_id>`                                                      |
| `request_id`       | string | `<request_id>`                                                   |
| `aa_session_id`    | string | `<aa_session_id>`                                                |
| `success`          | bool   | Flag indicating if the request was success or not                |
| `service`          | string | Name of AccountAggregator Service used to fetch the transactions |
| `service_response` | object | Transactions response provided by the the Account Aggregator     |

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
  }
}
```

> ⚠️ **Note:**
>
> The structure of `service_response` field might differ across different Account Aggregator providers.


#### Error Response (HTTP 4xx/5xx)

Body Parameters -

| Field Name             | Type   | Description                        |
|------------------------|--------|------------------------------------|
| `detail`               | object | Details of the error occurred      |
| `detail.error`         | string | Error message indicating the issue |
| `detail.request_id`    | string | `<request_id>`                     |
| `detail.user_id`       | string | `<user_id>`                        |
| `detail.aa_session_id` | string | `aa_session_id`                    |

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