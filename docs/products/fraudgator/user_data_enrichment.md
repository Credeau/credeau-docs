# User Data Enrichment API

The User Data Enrichment API provides digital identity signals for a user based on their phone number, email, name, and pincode. It enriches the user's profile with scores, footprint signals, and cross-linkage insights to help assess fraud risk during onboarding and credit journeys.

```bash
POST /api/user-data-enrichment
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
| `email`   | string | Yes      | Email address of the user |
| `name`    | string | Yes      | Full name of the user |
| `pincode` | string | Yes      | Pincode of the user's location |

### Request cURL

```bash
curl --location 'https://fraudgator.credeau.com/api/user-data-enrichment' \
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

| Field Name                              | Type    | Description |
|-----------------------------------------|---------|-------------|
| `request_id`                            | string  | Unique request identifier for reference |
| `user_id`                               | string  | Unique identifier of the user (as sent in the request) |
| `enrichment_success`                    | bool    | Flag indicating if the enrichment was successful |
| `enriched_digitalIdentityScore`         | int     | Overall digital identity score of the user |
| `enriched_digitalFootprint`             | string  | Digital footprint classification (e.g., `High`, `Medium`, `Low`) |
| `enriched_ecomFootprint`                | bool    | Flag indicating if the user has an e-commerce footprint |
| `enriched_socialFootprint`              | bool    | Flag indicating if the user has a social media footprint |
| `enriched_travelFootprint`              | string  | Travel footprint classification, if available |
| `enriched_ageBand`                      | string  | Age band of the user, if available |
| `enriched_gender`                       | string  | Gender of the user, if available |
| `enriched_firstNameMatch`               | bool    | Flag indicating if the first name matches the enriched profile |
| `enriched_lastNameMatch`                | bool    | Flag indicating if the last name matches the enriched profile |
| `enriched_nameMatchScore`               | int     | Name match score (0–100) |
| `enriched_phoneFirstSeenYear`           | int     | Year when the phone number was first seen |
| `enriched_emailFirstSeenYear`           | int     | Year when the email was first seen |
| `enriched_phoneEmailMatch`              | bool    | Flag indicating if the phone and email are linked |
| `enriched_phoneEmailFirstSeenYear`      | int     | Year when the phone-email combination was first seen |
| `enriched_phoneEmailLastSeenYear`       | int     | Year when the phone-email combination was last seen |
| `enriched_phoneNameFirstSeenYear`       | int     | Year when the phone-name combination was first seen |
| `enriched_phoneNameLastSeenYear`        | int     | Year when the phone-name combination was last seen |
| `enriched_emailNameFirstSeenYear`       | int     | Year when the email-name combination was first seen |
| `enriched_emailNameLastSeenYear`        | int     | Year when the email-name combination was last seen |
| `enriched_upiScore`                     | int     | UPI activity score of the user |
| `enriched_twitterMatch`                 | string  | Twitter profile match, if available |
| `enriched_linkedinMatch`                | string  | LinkedIn profile match, if available |
| `enriched_jobPortal`                    | string  | Job portal presence, if available |
| `enriched_language`                     | string  | Preferred language of the user, if available |
| `enriched_dmatAccount`                  | string  | Demat account presence, if available |
| `enriched_morePhonesMappedWithEmail`    | int     | Count of additional phones mapped to the same email |
| `enriched_moreEmailsMappedWithPhone`    | int     | Count of additional emails mapped to the same phone |
| `enriched_emailMappedWithPhone`         | int     | Count of emails mapped with the given phone |
| `enriched_upiVPACount`                  | int     | Number of UPI VPAs linked to the user |
| `enriched_badUglyMatchFound`            | string  | Flag indicating any bad/ugly match found, if available |
| `enriched_phoneFirstSeenDate`           | string  | Date when the phone number was first seen (ISO 8601) |
| `enriched_emailFirstSeenDate`           | string  | Date when the email was first seen (ISO 8601) |
| `enriched_phoneEmailFirstSeenDate`      | string  | Date when the phone-email combination was first seen (ISO 8601) |
| `enriched_phoneNameFirstSeenDate`       | string  | Date when the phone-name combination was first seen (ISO 8601) |
| `enriched_emailNameFirstSeenDate`       | string  | Date when the email-name combination was first seen (ISO 8601) |
| `enriched_phonePincodeFirstSeenDays`    | int     | Days since the phone-pincode combination was first seen |
| `enriched_phonePincodeLastSeenDays`     | int     | Days since the phone-pincode combination was last seen |
| `enriched_phonePincodeMatchCount`       | int     | Number of times the phone-pincode combination was matched |
| `enriched_phoneUniquePincodesCount`     | int     | Number of unique pincodes associated with the phone |
| `enriched_emailPincodeFirstSeenDays`    | int     | Days since the email-pincode combination was first seen |
| `enriched_emailPincodeLastSeenDays`     | int     | Days since the email-pincode combination was last seen |
| `enriched_emailPincodeMatchCount`       | int     | Number of times the email-pincode combination was matched |
| `enriched_emailUniquePincodesCount`     | int     | Number of unique pincodes associated with the email |
| `enriched_qcomFootprint`                | bool    | Flag indicating if the user has a quick commerce footprint |

### Success Response

#### HTTP 200 OK (Success)

When the enrichment is successful:

```json
{
    "request_id": "58cd5b7766fb4413b5e553e9bd4c6e60",
    "user_id": "sample_user",
    "enrichment_success": true,
    "enriched_digitalIdentityScore": 713,
    "enriched_digitalFootprint": "High",
    "enriched_ecomFootprint": true,
    "enriched_socialFootprint": true,
    "enriched_travelFootprint": "",
    "enriched_ageBand": "",
    "enriched_gender": "Male",
    "enriched_firstNameMatch": true,
    "enriched_lastNameMatch": true,
    "enriched_nameMatchScore": 73,
    "enriched_phoneFirstSeenYear": 2018,
    "enriched_emailFirstSeenYear": 2020,
    "enriched_phoneEmailMatch": true,
    "enriched_phoneEmailFirstSeenYear": 2020,
    "enriched_phoneEmailLastSeenYear": 2025,
    "enriched_phoneNameFirstSeenYear": 2018,
    "enriched_phoneNameLastSeenYear": 2025,
    "enriched_emailNameFirstSeenYear": 2020,
    "enriched_emailNameLastSeenYear": 2025,
    "enriched_upiScore": 6,
    "enriched_twitterMatch": "",
    "enriched_linkedinMatch": "",
    "enriched_jobPortal": "",
    "enriched_language": "",
    "enriched_dmatAccount": "",
    "enriched_morePhonesMappedWithEmail": 0,
    "enriched_moreEmailsMappedWithPhone": 0,
    "enriched_emailMappedWithPhone": 2,
    "enriched_upiVPACount": 1,
    "enriched_badUglyMatchFound": "",
    "enriched_phoneFirstSeenDate": "2018-02-01T00:00:00",
    "enriched_emailFirstSeenDate": "2020-10-01T00:00:00",
    "enriched_phoneEmailFirstSeenDate": "2020-10-01T00:00:00",
    "enriched_phoneNameFirstSeenDate": "2018-02-01T00:00:00",
    "enriched_emailNameFirstSeenDate": "2020-10-01T00:00:00",
    "enriched_phonePincodeFirstSeenDays": 3053,
    "enriched_phonePincodeLastSeenDays": 943,
    "enriched_phonePincodeMatchCount": 2,
    "enriched_phoneUniquePincodesCount": 3,
    "enriched_emailPincodeFirstSeenDays": "",
    "enriched_emailPincodeLastSeenDays": "",
    "enriched_emailPincodeMatchCount": 0,
    "enriched_emailUniquePincodesCount": 1,
    "enriched_qcomFootprint": true
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
