# Bureau Mobile BRE — Response

Response structure for the Bureau Mobile BRE workflow.

## Success Response

### HTTP 200 OK

```json
{
  "request_id": "<request_id>",
  "user_id": "<user_id>",
  "reference_id": "<reference_id>",
  "workflow_version_path": "workflow_bureau_v1",
  "engine_history": [],
  "output_data": {
    "ecm": {},
    "rules_output": {
      "final_decision": {
        "Decision": "Approve",
        "LoanAmount": 5000,
        "RulesEvaluation": {
          "mobile bre checked": true
        },
        "DecisionReason": "mobile bre checked",
        "version": "v1",
        "rule_engine_name": "mobilegator"
      },
      "basic": {},
      "mobilegator": {}
    },
    "features": {
      "output_features": {
        "bureaugator": {
          "bureau_score": 700,
          "cbs_risk_grade": 1,
          "cbs_stpl_v1": 0.083,
          "cbs_monthly_affordability_v1": 7000,
          "bureau_affordability": 6000
        },
        "mobilegator": {
          "fraud_flag": false,
          "all_sms_count": 1000,
          "credeau_payday_score": 0.85,
          "mobilegator_affordability": 5000,
          "estimated_salary": 20000
        }
      },
      "bureaugator": {},
      "mobilegator": {},
      "prev_output_features": {}
    }
  }
}
```

## Response Fields

| Field                                                              | Type    | Description                                      |
| ------------------------------------------------------------------ | ------- | ------------------------------------------------ |
| `request_id`                                                       | string  | Unique identifier for the request                |
| `output_data.rules_output.final_decision.Decision`                 | string  | Final decision (e.g., `Approve`, `Reject`)       |
| `output_data.rules_output.final_decision.LoanAmount`               | number  | Approved loan amount                             |
| `output_data.rules_output.final_decision.DecisionReason`           | string  | Reason for the decision                          |
| `output_data.features.output_features.bureaugator.bureau_score`    | number  | Credit bureau score                              |
| `output_data.features.output_features.bureaugator.cbs_risk_grade`  | number  | CBS risk grade                                   |
| `output_data.features.output_features.bureaugator.bureau_affordability` | number | Bureau-based affordability estimate         |
| `output_data.features.output_features.mobilegator.fraud_flag`      | boolean | Whether fraud was detected                       |
| `output_data.features.output_features.mobilegator.credeau_payday_score` | float | Credeau payday score                        |
| `output_data.features.output_features.mobilegator.mobilegator_affordability` | number | MobileGator-based affordability estimate |
| `output_data.features.output_features.mobilegator.estimated_salary` | number | Estimated salary from mobile data               |

## Error Responses

Refer to the [BRE API error responses](../index.md#error-responses) for common error codes.

## Previous

See [Bureau Mobile BRE — Request](request.md) for the request structure.
