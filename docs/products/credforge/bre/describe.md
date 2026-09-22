# Describe API

Retrieves previously persisted workflow data. This read-only endpoint does not execute a workflow or return workflow configuration, request IDs, engine history, SQL data, or sandbox metadata.

## Endpoint

```bash
POST /api/describe/{client_id}
```

## Authentication

Use normal Core API authentication. Send `x-auth-token` as a request header; it takes precedence over an `auth_token` provided in the request body.

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

| Field               | Required    | Description                                                                  |
| ------------------- | ----------- | ---------------------------------------------------------------------------- |
| `user_id`           | Yes         | User identifier used to retrieve ECM and workflow state.                     |
| `reference_id`      | Conditional | Required when requesting `features`, `rules_output`, or `workflow_endpoint`. |
| `workflow_endpoint` | No          | Limits state retrieval to this workflow endpoint.                            |
| `ecm`               | No          | ECM engine names to return.                                                  |
| `features`          | No          | Persisted feature names to return.                                           |
| `rules_output`      | No          | Persisted rule-output names to return.                                       |

For each selection list: omit it or send `[]` for `{}`, use `["*"]` for all values, or provide named values. Missing named values return `null`; `*` takes precedence when present.

## Response

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

`execution_timestamp` is the selected persisted state's creation time. The endpoint returns the newest matching state for the supplied client, user, reference, and—when supplied—workflow endpoint.

## Errors

| Condition                                                                          | HTTP status | `error`                     |
| ---------------------------------------------------------------------------------- | ----------: | --------------------------- |
| `features`, `rules_output`, or `workflow_endpoint` supplied without `reference_id` |         200 | `REFERENCE_ID_ABSENT`       |
| No persisted state for the supplied endpoint                                       |         200 | `INVALID_WORKFLOW_ENDPOINT` |
| Required data access fails                                                         |         500 | `DATA_ACCESS_ERROR`         |
| Invalid request body                                                               |         422 | FastAPI validation response |

For `REFERENCE_ID_ABSENT` and `DATA_ACCESS_ERROR`, all result categories are empty. For `INVALID_WORKFLOW_ENDPOINT`, any selected ECM data is preserved but features and rule outputs are empty.
