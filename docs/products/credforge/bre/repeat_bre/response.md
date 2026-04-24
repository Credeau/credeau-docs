# Repeat BRE — Response

Response structure for the Repeat BRE workflow.

## Success Response

### HTTP 200 OK

```json
{
  "request_id": "<request_id>",
  "user_id": "<user_id>",
  "reference_id": "<reference_id>",
  "workflow_version_path": "workflow_repeat_v1",
  "engine_history": [],
  "output_data": {
    "ecm": {},
    "rules_output": {
      "final_decision": {
        "Decision": "Approve",
        "LoanAmount": 7000,
        "ReplaymentDate": "2025-05-03",
        "DecisionReason": "repeat bre passed with approval",
        "RulesEvaluation": {},
        "version": "v1",
        "rule_engine_name": "basic"
      }
    },
    "features": {
      "output_features": {
        "basic": {}
      },
      "basic": {},
      "prev_output_features": {}
    }
  }
}
```

## Response Fields

| Field                                                        | Type   | Description                                      |
| ------------------------------------------------------------ | ------ | ------------------------------------------------ |
| `request_id`                                                 | string | Unique identifier for the request                |
| `output_data.rules_output.final_decision.Decision`           | string | Final decision — `Approve`, `Reject`             |
| `output_data.rules_output.final_decision.LoanAmount`         | number | Approved loan amount                             |
| `output_data.rules_output.final_decision.ReplaymentDate`     | string | Repayment date for the approved loan             |
| `output_data.rules_output.final_decision.DecisionReason`     | string | Reason for the decision                          |
| `output_data.rules_output.final_decision.rule_engine_name`   | string | Name of the rule engine that made the decision   |

## Error Responses

Refer to the [BRE API error responses](../index.md#error-responses) for common error codes.

## Previous

See [Repeat BRE — Request](request.md) for the request structure.
