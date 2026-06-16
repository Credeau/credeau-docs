# User WhatsApp Insights API

The User WhatsApp Insights API checks whether a given phone number is registered on WhatsApp and returns profile signals such as account existence and business account status. This helps assess digital presence and authenticity during fraud risk evaluation.

```bash
POST /api/user-whatsapp-txn
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

### Request cURL

```bash
curl --location 'https://fraudgator.credeau.com/api/user-whatsapp-txn' \
--header 'x-client-id: <client_id>' \
--header 'x-auth-token: <auth_token>' \
--header 'Content-Type: application/json' \
--data '{
    "user_id": "sample_user",
    "phone": "<phone_number>"
}'
```

## Response

### Response Fields (JSON)

| Field Name               | Type   | Description |
|--------------------------|--------|-------------|
| `request_id`             | string | Unique request identifier for reference |
| `user_id`                | string | Unique identifier of the user (as sent in the request) |
| `enrichment_success`     | bool   | Flag indicating if the enrichment was successful |
| `enriched_image`         | string | Profile image URL of the WhatsApp account, if available |
| `enriched_user_exist`    | bool   | Flag indicating if the phone number is registered on WhatsApp |
| `enriched_is_business`   | string | Flag indicating if the WhatsApp account is a business account, if available |

### Success Response

#### HTTP 200 OK (Success)

When the enrichment is successful:

```json
{
    "request_id": "bbec4351e762444ab38d813601f9c04e",
    "user_id": "sample_user",
    "enrichment_success": true,
    "enriched_image": "",
    "enriched_user_exist": true,
    "enriched_is_business": ""
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
                "phone": "<phone_number>"
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
