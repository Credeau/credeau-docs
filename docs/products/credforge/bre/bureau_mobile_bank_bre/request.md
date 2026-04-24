# Bureau Mobile Bank BRE — Request

Provides decision based on the Account, Mobile & Bureau Intelligence (Account Aggregator + Credit Bureau + BureauGator + MobileGator).

## Endpoint

```bash
POST /execute/${client_id}/bureau_mobile_bank_bre
```

## Authentication

Refer to the [BRE API authentication](../index.md#authentication) for headers required on all requests.

> 📖 **Reference**
>
> The bureau-related input parameters are derived from BureauGator. Refer to [BureauGator → Insights → Request Parameters](../../../bureaugator/bureau.md) for the full list of supported fields and their descriptions.

## Request Body

```json
{
    "user_id": "<user_id>",
    "reference_id": "<reference_id>",
    "input_data": {
        "lead_id": "<lead_id>",
        "app_user_id": "<app_user_id>",
        "declared_income": <income>,
        "external": {
            "bureau_type": "<bureau_format_name>",
            "bureau_raw_json": "<base64_encoded_raw_bureau_report>",
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
                    },
                    {
                        "type": "DEBIT",
                        "amount": 35,
                        "currentBalance": "52304.77",
                        "transactionTimestamp": "2025-06-11 16:49:35",
                        "txnId": "S99003246",
                        "narration": "UPI/KANTIBHAI DHAMO/106299053289/UPI"
                    }
                ]
            }
        }
    }
}
```

> ⚠️ **Note**
>
> We support multiple bureau formats. Please explore the format types for each bureau to find the one that matches your report structure and will go as `bureau_format_name` in request_payload:
> 
> - **CIBIL (TransUnion)**: [View supported formats](./bureauformats/cibil_related.md) - JSON format with TUEF structure
> - **CRIF**: [View supported formats](./bureauformats/crif_related.md) - Multiple JSON variations and XML formats
> - **Experian**: [View supported formats](./bureauformats/experian_related.md) - JSON and XML formats with CAIS/CAPS structure
> - **Equifax**: [View supported formats](./bureauformats/equifax_related.md) - JSON formats with ERS scoring
>
> If none of these formats match your bureau report structure, please send your sample bureau report file to **tech@credeau.com** for format analysis and support.

Encoding a bureau report (Python):

```python
import base64

def encode_base64(data: str, encoding: str='utf-8') -> str:
    '''
    Convert given string into base64 encoded string
    '''
    b64_encoded_data = base64.b64encode(bytes(data, encoding=encoding))
    return b64_encoded_data.decode(encoding)
```

## Input Data Parameters

| Parameter                          | Type   | Required | Description                                      |
| ---------------------------------- | ------ | -------- | ------------------------------------------------ |
| `lead_id`                          | string | Yes      | Unique identifier for the lead                   |
| `app_user_id`                      | string | Yes      | MobileGator SDK user identifier                  |
| `declared_income`                  | number | Yes      | Declared income of the applicant                 |
| `external.bureau_type`             | string | Yes      | Bureau format name                               |
| `external.bureau_raw_json`         | string | Yes      | Base64 encoded raw bureau report                 |
| `external.bank_type`               | string | Yes      | `bank_aa` or `bank_bsa`                          |
| `external.bank_data.metadata`      | object | Yes      | Account metadata                                 |
| `external.bank_data.transaction_data` | array | Yes   | List of transactions                             |

## Next

See [Bureau Mobile Bank BRE — Response](response.md) for the response structure.
