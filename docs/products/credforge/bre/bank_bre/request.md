# Bank BRE — Request

Provides decision based on banking data transactions (Account Aggregator or Bank Statement Analyser).

## Endpoint

```bash
POST /execute/${client_id}/bank_bre
```

## Authentication

Refer to the [BRE API authentication](../index.md#authentication) for headers required on all requests.

## Request Body

> ⚠️ **Note**
>
> The `input_data` differs based on how the banking data is passed.

### Account Aggregator API called from within the workflow

```json
{
  "user_id": "<user_id>",
  "reference_id": "<reference_id>",
  "input_data": {
    "request_id": "bank_aa_request_id",
    "bank_type": "bank_aa"
  }
}
```

### Bank Statement Analyzer API called from within the workflow

```json
{
  "user_id": "<user_id>",
  "reference_id": "<reference_id>",
  "input_data": {
    "report_id": "bank_bsa_report_id",
    "auth_token": "bank_bsa_auth_token",
    "bank_type": "bank_bsa"
  }
}
```

### Account Aggregator / Bank Statement Analyser API called externally

#### Single Account

The aggregator processes data for a single account.

```json
{
    "user_id": "<user_id>",
    "reference_id": "<reference_id>",
    "input_data": {
        "lead_id": "<lead_id>",
        "declared_income": <income>,
        "external": {
            "bank_type": "bank_aa/bank_bsa",
            "bank_data": {
                "metadata": {
                    "currency": "<currency>",
                    "bank_name": "<bank_name>",
                    "ifsc_code": "<ifsc_code>",
                    "account_type": "<account_type>",
                    "employer_name": "<employer_name>",
                    "account_number": "<account_number>",
                    "account_holder_name": "<account_holder_name>",
                    "statement_fetch_date": "<statement_fetch_date>",
                    "statement_start_date": "<statement_start_date>",
                    "statement_end_date": "<statement_end_date>"
                },
                "transaction_data": [
                    {
                        "txnId": "S99114288",
                        "type": "DEBIT",
                        "amount": 262.5,
                        "currentBalance": "30585.51",
                        "transactionTimestamp": "2025-05-24 02:45:58",
                        "narration": "UPI/MPOKKET FINANCI/514408328499/OidmpokketVA1b8"
                    },
                    {
                        "txnId": "S63581773",
                        "type": "DEBIT",
                        "amount": 32,
                        "currentBalance": "52339.77",
                        "transactionTimestamp": "2025-06-10 19:42:06",
                        "narration": "UPI/Ganesh Kirana S/106258920869/UPI"
                    }
                ]
            }
        }
    }
}
```

#### Multiple Accounts

The aggregator processes data for multiple accounts, provided as a list.

```json
{
    "user_id": "<user_id>",
    "reference_id": "<reference_id>",
    "input_data": {
        "lead_id": "<lead_id>",
        "declared_income": <income>,
        "external": {
            "bank_type": "bank_aa/bank_bsa",
            "bank_data": [
                {
                    "metadata": {
                        "currency": "<currency>",
                        "bank_name": "<bank_name>",
                        "ifsc_code": "<ifsc_code>",
                        "account_type": "<account_type>",
                        "employer_name": "<employer_name>",
                        "account_number": "<account_number>",
                        "account_holder_name": "<account_holder_name>",
                        "statement_fetch_date": "<statement_fetch_date>",
                        "statement_start_date": "<statement_start_date>",
                        "statement_end_date": "<statement_end_date>"
                    },
                    "transaction_data": [
                        {
                            "txnId": "S99114288",
                            "type": "DEBIT",
                            "amount": 262.5,
                            "currentBalance": "30585.51",
                            "transactionTimestamp": "2025-05-24 02:45:58",
                            "narration": "UPI/MPOKKET FINANCI/514408328499/OidmpokketVA1b8"
                        },
                        {
                            "txnId": "S63581773",
                            "type": "DEBIT",
                            "amount": 32,
                            "currentBalance": "52339.77",
                            "transactionTimestamp": "2025-06-10 19:42:06",
                            "narration": "UPI/Ganesh Kirana S/106258920869/UPI"
                        }
                    ]
                }
            ]
        }
    }
}
```

## Input Data Parameters

| Parameter                          | Type   | Required    | Description                                                    |
| ---------------------------------- | ------ | ----------- | -------------------------------------------------------------- |
| `request_id`                       | string | Conditional | AA request ID (when AA called within workflow)                 |
| `report_id`                        | string | Conditional | BSA report ID (when BSA called within workflow)                |
| `auth_token`                       | string | Conditional | BSA auth token (when BSA called within workflow)               |
| `bank_type`                        | string | Yes         | `bank_aa` for Account Aggregator, `bank_bsa` for Bank Statement Analyser |
| `lead_id`                          | string | Conditional | Unique identifier for the lead (when called externally)        |
| `declared_income`                  | number | Conditional | Declared income of the applicant (when called externally)      |
| `external.bank_data.metadata`      | object | Conditional | Account metadata (when called externally)                      |
| `external.bank_data.transaction_data` | array | Conditional | List of transactions (when called externally)               |

## Next

See [Bank BRE — Response](response.md) for the response structure.
