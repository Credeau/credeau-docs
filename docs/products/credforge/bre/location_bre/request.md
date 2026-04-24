# Location BRE — Request

Provides decision based on the provided location information.

## Endpoint

```bash
POST /execute/${client_id}/location_bre
```

## Authentication

Refer to the [BRE API authentication](../index.md#authentication) for headers required on all requests.

## Request Body

```json
{
    "user_id": "<user_id>",
    "reference_id": "<reference_id>",
    "input_data": {
        "lead_id": "<lead_id>",
        "latitude": <latitude>,
        "longitude": <longitude>
    }
}
```

### Input Data Parameters

| Parameter     | Type   | Required | Description                        |
| ------------- | ------ | -------- | ---------------------------------- |
| `lead_id`     | string | Yes      | Unique identifier for the lead     |
| `latitude`    | float  | Yes      | Latitude coordinate of the location |
| `longitude`   | float  | Yes      | Longitude coordinate of the location |

## Next

See [Location BRE — Response](response.md) for the response structure.
