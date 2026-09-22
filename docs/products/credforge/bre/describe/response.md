# Describe API — Response

Response structure for persisted workflow data retrieved by the Describe API.

## Success Response

### HTTP 200 OK

```json
{
  "user_id": "<user_id>",
  "reference_id": "<reference_id>",
  "error": null,
  "workflow_endpoint": "credit-decision",
  "execution_timestamp": "2026-09-22T10:00:00",
  "ecm": {},
  "features": {},
  "rules_output": {}
}
```

The endpoint returns the newest matching persisted state for the supplied client, user, reference, and—when supplied—workflow endpoint. `execution_timestamp` is that selected state's creation time.

## Response Fields

| Field | Type | Description |
| --- | --- | --- |
| `user_id` | string | User identifier from the request. |
| `reference_id` | string or `null` | Reference identifier from the request. |
| `error` | string or `null` | `null` on success; otherwise a documented error code. |
| `workflow_endpoint` | string or `null` | Selected workflow endpoint, requested endpoint in endpoint-related errors, or `null`. |
| `execution_timestamp` | string or `null` | ISO-8601 creation time of the selected persisted state. |
| `ecm` | object | Selected ECM engine output entries. |
| `features` | object | Selected persisted feature values. |
| `rules_output` | object | Selected persisted rule-output values. |

## Error Responses

| Condition | HTTP status | `error` | Result |
| --- | ---: | --- | --- |
| `features`, `rules_output`, or `workflow_endpoint` supplied without `reference_id` | 200 | `REFERENCE_ID_ABSENT` | All categories empty; no persisted-state lookup. |
| No persisted state for the supplied endpoint | 200 | `INVALID_WORKFLOW_ENDPOINT` | ECM is preserved; features and rule outputs are empty. |
| Required data access fails | 500 | `DATA_ACCESS_ERROR` | All categories are empty. |
| Invalid request body | 422 | FastAPI validation response | Not a Describe response envelope. |

## Previous

See [Describe API — Request](request.md) for the request structure.
