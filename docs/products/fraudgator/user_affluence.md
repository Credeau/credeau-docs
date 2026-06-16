# User Affluence API

The User Affluence API provides wealth and lifestyle signals for a user based on their phone number, email, name, and pincode. It returns affluence indicators such as asset ownership, investment footprint, credit profile, and digital spending behavior to support risk and credit assessment journeys.

```bash
POST /api/user-affluense
```

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

## Request Parameters

### Request Body (JSON)

| Parameter | Type   | Required | Description |
|-----------|--------|----------|-------------|
| `user_id` | string | Yes      | Unique identifier of the user |
| `phone`   | string | Yes      | Phone number of the user |
| `email`   | string | Optional | Email address of the user |
| `name`    | string | Optional | Full name of the user |
| `pincode` | string | Optional | Pincode of the user's location |

### Request cURL

```bash
curl --location 'https://fraudgator.credeau.com/api/user-affluense' \
--header 'x-client-id: <client_id>' \
--header 'x-auth-token: <auth_token>' \
--header 'Content-Type: application/json' \
--data-raw '{
    "user_id": "sample_user",
    "phone": "<phone_number>",
    "email": "<email>",
    "name": "<name>",
    "pincode": "147101"
}'
```

## Response

### Response Fields (JSON)

| Field Name                        | Type   | Description |
|-----------------------------------|--------|-------------|
| `request_id`                      | string | Unique request identifier for reference |
| `user_id`                         | string | Unique identifier of the user (as sent in the request) |
| `enrichment_success`              | bool   | Flag indicating if the enrichment was successful |
| `enriched_affluenceBand`          | string | Affluence band classification of the user, if available |
| `enriched_ITR`                    | string | Income Tax Return filing status, if available |
| `enriched_carOwner`               | string | Flag indicating car ownership, if available |
| `enriched_houseOwner`             | string | Flag indicating house ownership, if available |
| `enriched_investmentFootprint`    | string | Investment activity classification (e.g., `NA`, `Low`, `High`) |
| `enriched_ecomFootprint`          | string | E-commerce spending footprint classification (e.g., `Low`, `Mid`, `High`) |
| `enriched_qcomFootprint`          | string | Quick commerce spending footprint classification (e.g., `Low`, `Mid`, `High`) |
| `enriched_hasCreditCard`          | string | Flag indicating credit card ownership, if available |
| `enriched_dmatAccount`            | string | Demat account presence, if available |
| `enriched_BFSICount`              | int    | Count of BFSI (Banking, Financial Services & Insurance) interactions |
| `enriched_socialFootprint`        | string | Social media footprint classification (e.g., `Low`, `Mid`, `High`) |
| `enriched_digitalFootprint`       | string | Overall digital footprint classification (e.g., `Low`, `Medium`, `High`) |
| `enriched_ageBand`                | string | Age band of the user, if available |
| `enriched_riskyFintechCount`      | int    | Count of risky fintech interactions |
| `enriched_nonRiskyFintechCount`   | int    | Count of non-risky fintech interactions |
| `enriched_hasMF`                  | string | Flag indicating mutual fund investment presence, if available |
| `enriched_amcCount`               | string | Count of AMC (Asset Management Company) associations, if available |
| `enriched_amcFound`               | bool   | Flag indicating if any AMC association was found |
| `enriched_numberOfAccounts`       | int    | Total number of credit accounts |
| `enriched_activeAccounts`         | int    | Number of currently active credit accounts |
| `enriched_emailFirstSeenDays`     | int    | Days since the email was first seen |
| `enriched_closedAccounts`         | int    | Number of closed credit accounts |
| `enriched_phoneNameFirstSeenDays` | int    | Days since the phone-name combination was first seen |
| `enriched_creditUtilisationCC`    | string | Credit card utilisation percentage, if available |
| `enriched_oldestAccount`          | string | Age of the oldest credit account, if available |
| `enriched_newestAccount`          | string | Age of the newest credit account, if available |
| `enriched_avgAccountAge`          | string | Average age of credit accounts, if available |
| `enriched_creditMixEver`          | object | Credit mix across all accounts ever held |
| `enriched_creditMixActive`        | object | Credit mix across currently active accounts |
| `enriched_snapShotDate`           | string | Date of the credit snapshot, if available |
| `enriched_homeLoanValue`          | string | Home loan value, if available |
| `enriched_carLoanValue`           | string | Car loan value, if available |
| `enriched_ccCount`                | int    | Number of credit cards held |
| `enriched_ccLimit`                | string | Total credit card limit, if available |
| `enriched_cinCount`               | string | Count of CIN (Company Identification Number) associations, if available |

### Success Response

#### HTTP 200 OK (Success)

When the enrichment is successful:

```json
{
    "request_id": "3e5ac64bc3344e5584924e6beb5dc338",
    "user_id": "sample_user",
    "enrichment_success": true,
    "enriched_affluenceBand": "",
    "enriched_ITR": "",
    "enriched_carOwner": "",
    "enriched_houseOwner": "",
    "enriched_investmentFootprint": "NA",
    "enriched_ecomFootprint": "Low",
    "enriched_qcomFootprint": "Mid",
    "enriched_hasCreditCard": "",
    "enriched_dmatAccount": "",
    "enriched_BFSICount": 0,
    "enriched_socialFootprint": "Low",
    "enriched_digitalFootprint": "Medium",
    "enriched_ageBand": "",
    "enriched_riskyFintechCount": 0,
    "enriched_nonRiskyFintechCount": 0,
    "enriched_hasMF": "",
    "enriched_amcCount": "",
    "enriched_amcFound": false,
    "enriched_numberOfAccounts": 0,
    "enriched_activeAccounts": 0,
    "enriched_emailFirstSeenDays": 2080,
    "enriched_closedAccounts": 0,
    "enriched_phoneNameFirstSeenDays": 3053,
    "enriched_creditUtilisationCC": "",
    "enriched_oldestAccount": "",
    "enriched_newestAccount": "",
    "enriched_avgAccountAge": "",
    "enriched_creditMixEver": {},
    "enriched_creditMixActive": {},
    "enriched_snapShotDate": "",
    "enriched_homeLoanValue": "",
    "enriched_carLoanValue": "",
    "enriched_ccCount": 0,
    "enriched_ccLimit": "",
    "enriched_cinCount": ""
}
```

### Error Responses

#### HTTP 401 Unauthorized

When authentication credentials are missing or invalid:

```json
{
    "detail": "Unauthorized"
}
```

#### HTTP 422 Unprocessable Content (Wrong Request Payload)

When a required field is missing:

```json
{
    "detail": [
        {
            "type": "missing",
            "loc": [
                "body",
                "user_id"
            ],
            "msg": "Field required",
            "input": {
                "phone": "<phone_number>",
                "email": "<email>",
                "name": "<name>",
                "pincode": "147101"
            }
        }
    ]
}
```

#### HTTP 429 Too Many Requests

When the rate limit is exceeded (1000 requests/minute per IP):

```json
{
    "detail": "Too Many Requests"
}
```

#### HTTP 500 Internal Server Error

When an unexpected server error occurs:

```json
{
    "detail": "Internal Server Error"
}
```
