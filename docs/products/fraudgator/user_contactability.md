# User Contactability API

The User Contactability API provides fraud indicator signals for a user based on their phone number, email, name, and pincode. It returns a fraud indicator score along with digital footprint and name-linkage insights to help assess contactability risk during onboarding and credit journeys.

```bash
POST /api/user-contactability
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
curl --location 'https://fraudgator.credeau.com/api/user-contactability' \
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

| Field Name                          | Type   | Description |
|-------------------------------------|--------|-------------|
| `request_id`                        | string | Unique request identifier for reference |
| `user_id`                           | string | Unique identifier of the user (as sent in the request) |
| `enrichment_success`                | bool   | Flag indicating if the enrichment was successful |
| `enriched_FraudIndicatorScore`      | int    | Fraud indicator score of the user (higher score indicates higher fraud risk) |
| `enriched_phoneFirstSeenYear`       | int    | Year when the phone number was first seen |
| `enriched_samePhoneNameCount`       | int    | Count of records where the same phone is linked to the same name |
| `enriched_totalPhoneNameCount`      | int    | Total count of records where the phone is linked to any name |
| `enriched_nameMatchScore`           | int    | Name match score (0–100) |
| `enriched_digitalFootprint`         | string | Digital footprint classification (e.g., `High`, `Medium`, `Low`) |
| `enriched_phoneNameFirstSeenDate`   | string | Date when the phone-name combination was first seen (ISO 8601) |
| `enriched_emailFirstSeenYear`       | int    | Year when the email was first seen |

### Success Response

#### HTTP 200 OK (Success)

When the enrichment is successful:

```json
{
    "request_id": "be499d2e425043e98dcbc3f299f309b6",
    "user_id": "sample_user",
    "enrichment_success": true,
    "enriched_FraudIndicatorScore": 47,
    "enriched_phoneFirstSeenYear": 2018,
    "enriched_samePhoneNameCount": 5,
    "enriched_totalPhoneNameCount": 5,
    "enriched_nameMatchScore": 72,
    "enriched_digitalFootprint": "Medium",
    "enriched_phoneNameFirstSeenDate": "2018-02-01T00:00:00",
    "enriched_emailFirstSeenYear": 2020
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
