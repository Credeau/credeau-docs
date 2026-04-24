# Location BRE — Response

Response structure for the Location BRE workflow.

## Success Response

### HTTP 200 OK

```json
{
  "request_id": "<request_id>",
  "user_id": "<user_id>",
  "reference_id": "<reference_id>",
  "workflow_version_path": "workflow_location_v1",
  "engine_history": [],
  "output_data": {
    "ecm": {},
    "rules_output": {
      "final_decision": {
        "Decision": "Proceed to Next Rule",
        "DecisionReason": "geocoding bre checked",
        "RulesEvaluation": {},
        "version": "v1",
        "rule_engine_name": "geocoding"
      }
    },
    "features": {
      "output_features": {
        "geocoding": {
          "state": "uttar pradesh",
          "pincode": "201301",
          "city": "noida"
        }
      },
      "prev_output_features": {},
      "geocoding": {}
    }
  }
}
```

## Response Fields

| Field                                                  | Type   | Description                                      |
| ------------------------------------------------------ | ------ | ------------------------------------------------ |
| `request_id`                                           | string | Unique identifier for the request                |
| `user_id`                                              | string | User identifier from the request                 |
| `reference_id`                                         | string | Reference identifier from the request            |
| `workflow_version_path`                                | string | Version of the workflow executed                 |
| `output_data.rules_output.final_decision.Decision`     | string | Final decision — `Proceed to Next Rule`, `Reject`    |
| `output_data.rules_output.final_decision.DecisionReason` | string | Reason for the decision                          |
| `output_data.features.output_features.geocoding.state` | string | State extracted from location                    |
| `output_data.features.output_features.geocoding.pincode` | string | Pincode extracted from location                  |
| `output_data.features.output_features.geocoding.city`  | string | City extracted from location                     |

## Error Responses

Refer to the [BRE API error responses](../index.md#error-responses) for common error codes.

## Previous

See [Location BRE — Request](request.md) for the request structure.
