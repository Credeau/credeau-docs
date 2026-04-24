# Bank BRE — Response

Response structure for the Bank BRE workflow.

## Success Response

### HTTP 200 OK

```json
{
  "request_id": "<request_id>",
  "user_id": "<user_id>",
  "reference_id": "<reference_id>",
  "workflow_version_path": "workflow_bank_v1",
  "engine_history": [],
  "output_data": {
    "ecm": {},
    "rules_output": {
      "final_decision": {
        "Decision": "Reject",
        "LoanAmount": null,
        "DecisionReason": "bank bre checked",
        "RulesEvaluation": {},
        "version": "v1",
        "rule_engine_name": "bank"
      },
      "pre_bureau": {}
    },
    "features": {
      "output_features": {}
    },
    "prev_output_features": {}
  }
}
```

## Response Fields

| Field                                                    | Type   | Description                                      |
| -------------------------------------------------------- | ------ | ------------------------------------------------ |
| `request_id`                                             | string | Unique identifier for the request                |
| `output_data.rules_output.final_decision.Decision`       | string | Final decision — `Approve`, `Reject`             |
| `output_data.rules_output.final_decision.LoanAmount`     | number | Approved loan amount, `null` if rejected         |
| `output_data.rules_output.final_decision.DecisionReason` | string | Reason for the decision                          |
| `output_data.rules_output.final_decision.rule_engine_name` | string | Name of the rule engine that made the decision |

## EMI Strategy

For EMI-based strategies, the `final_decision` will contain different keys instead of `Decision` and `LoanAmount`:

| Field                                                              | Type   | Description                                      |
| ------------------------------------------------------------------ | ------ | ------------------------------------------------ |
| `output_data.rules_output.final_decision.EmiDecision`              | string | Final decision for EMI strategy — `Approve`, `Reject` |
| `output_data.rules_output.final_decision.LoanOffers`               | array  | List of approved EMI loan offers                 |

Example `LoanOffers` entry:

```json
{
  "product_code": "PL_EMI_LT_25K",
  "tenure_months": 3,
  "pf_percent": 4,
  "interest_rate": 25,
  "emi_amount": 4000,
  "loan_amount": 10000
}
```

## Error Responses

Refer to the [BRE API error responses](../index.md#error-responses) for common error codes.

## Previous

See [Bank BRE — Request](request.md) for the request structure.
