# Describe API — Request

Retrieves previously persisted workflow data. This read-only endpoint does not execute a workflow or return workflow configuration, request IDs, engine history, SQL data, or sandbox metadata.

## Endpoint

```bash
POST /api/describe/{client_id}
```

## Authentication

Refer to the [BRE API authentication](../index.md#authentication) for headers required on all requests.

## Request Body

### Request Template

```json
{
  "user_id": "string, required",
  "reference_id": "string, optional",
  "workflow_endpoint": "string, optional",
  "ecm": ["optional engine names or *"],
  "features": ["optional feature names or *"],
  "rules_output": ["optional rule-output names or *"]
}
```

### Example: Retrieve All Available Values

```json
{
  "user_id": "<user_id>",
  "reference_id": "<reference_id>",
  "workflow_endpoint": "credit-decision",
  "ecm": ["*"],
  "features": ["*"],
  "rules_output": ["*"]
}
```

## Request Fields

| Field | Required | Description |
| --- | --- | --- |
| `user_id` | Yes | User identifier used to retrieve ECM and workflow state. |
| `reference_id` | Conditional | Required when requesting `features`, `rules_output`, or `workflow_endpoint`. |
| `workflow_endpoint` | No | Limits state retrieval to this workflow endpoint. |
| `ecm` | No | ECM engine names to return. |
| `features` | No | Persisted feature names to return. |
| `rules_output` | No | Persisted rule-output names to return. |

For each selection list: omit it or send `[]` for `{}`, use `["*"]` for all values, or provide named values. Missing named values return `null`; `*` takes precedence when present.

## Next

See [Describe API — Response](response.md) for the response structure.
