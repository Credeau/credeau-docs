# Bureau Mobile BRE — Request

Provides decision based on the Mobile & Bureau Intelligence (Credit Bureau + BureauGator + MobileGator).

## Endpoint

```bash
POST /execute/${client_id}/bureau_mobile_bre
```

## Authentication

Refer to the [BRE API authentication](../index.md#authentication) for headers required on all requests.

> 📖 **Reference**
>
> The bureau-related input parameters are derived from BureauGator. Refer to [BureauGator → Insights → Request Parameters](../../../bureaugator/bureau.md) for the full list of supported fields and their descriptions.

## Request Body

> ⚠️ **Note**
>
> The `input_data` differs based on how the bureau data is passed.

### Bureau API called from within the workflow

```json
{
    "user_id": "<user_id>",
    "reference_id": "<reference_id>",
    "input_data": {
        "lead_id": "<lead_id>",
        "app_user_id": "<app_user_id>",
        "declared_income": <income>,
        "pan_number": "<pan_number>",
        "name_aadhar": "<name_aadhar>",
        "address_aadhar": "<address_aadhar>",
        "state_aadhar": "<state_aadhar>",
        "city_aadhar": "<city_aadhar>",
        "pincode_aadhar": "<pincode_aadhar>",
        "phone": "<PHONE>",
        "pan_name": "<PAN_NAME>",
        "dob": "<DOB>",
        "profession": "<profession>",
        "salary_source": "<salary_source>",
        "declared_income": "<declared_income>",
        "loan_purpose": "<loan_purpose>",
        "income_type": "<income_type>",
        "gender": "<gender>"
    }
}
```

### Bureau API called externally

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
            "bureau_raw_json": "<base64_encoded_raw_bureau_report>"
        }
    }
}
```

> ⚠️ **Note**
>
> The `bureau_format_name` supports values like:
>
> - `cibil_json`
> - `crif_json`
> - `crif_json_v2`
> - `crif_xml`
> - `crif_hardpull`
> - `experian_softpull_json`
> - `equifax_softpull_json`
> - `experian_softpull_json_v2`

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

| Parameter         | Type   | Required | Description                                              |
| ----------------- | ------ | -------- | -------------------------------------------------------- |
| `lead_id`         | string | Yes      | Unique identifier for the lead                           |
| `app_user_id`     | string | Yes      | MobileGator SDK user identifier                          |
| `declared_income` | number | Yes      | Declared income of the applicant                         |
| `pan_number`      | string | Conditional | PAN number (required when bureau called within workflow) |
| `name_aadhar`     | string | Conditional | Name as per Aadhaar                                      |
| `address_aadhar`  | string | Conditional | Address as per Aadhaar                                   |
| `state_aadhar`    | string | Conditional | State as per Aadhaar                                     |
| `city_aadhar`     | string | Conditional | City as per Aadhaar                                      |
| `pincode_aadhar`  | string | Conditional | Pincode as per Aadhaar                                   |
| `phone`           | string | Conditional | Phone number of the applicant                            |
| `pan_name`        | string | Conditional | Name as per PAN                                          |
| `dob`             | string | Conditional | Date of birth of the applicant                           |
| `profession`      | string | Conditional | Profession of the applicant                              |
| `salary_source`   | string | Conditional | Source of salary                                         |
| `loan_purpose`    | string | Conditional | Purpose of the loan                                      |
| `income_type`     | string | Conditional | Type of income                                           |
| `gender`          | string | Conditional | Gender of the applicant                                  |
| `external.bureau_type` | string | Conditional | Bureau format name (required when bureau called externally) |
| `external.bureau_raw_json` | string | Conditional | Base64 encoded raw bureau report                    |

## Next

See [Bureau Mobile BRE — Response](response.md) for the response structure.
