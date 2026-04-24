# Repeat BRE — Request

Provides decision for a repeat customer based on the information already present in the LOS.

## Endpoint

```bash
POST /execute/${client_id}/repeat_bre
```

## Authentication

Refer to the [BRE API authentication](../index.md#authentication) for headers required on all requests.

## Request Body

```json
{
    "user_id": "<user_id>",
    "reference_id": "<reference_id>",
    "input_data": {
        "pan_number": "<pan_number>",
        "name_aadhar": "<name_aadhar>",
        "address_aadhar": "<address_aadhar>",
        "state_aadhar": "<state_aadhar>",
        "city_aadhar": "<city_aadhar>",
        "pincode_aadhar": "<pincode_aadhar>",
        "phone": "<phone>",
        "dob": "<dob>",
        "max_dpd_last_loan": <max_dpd_last_loan>,
        "max_dpd_ever_internal": <max_dpd_ever_internal>,
        "previous_loan_amount": <previous_loan_amount>,
        "decided_tenure_last_loan": <decided_tenure_last_loan>,
        "actual_tenure_last_loan": <actual_tenure_loan_last>,
        "days_since_last_loan_closed": <days_since_last_loan_closed>,
        "number_of_loans_closed": <number_of_loans_closed>,
        "days_since_last_loan_taken": <days_since_last_loan_taken>,
        "days_since_first_loan_taken": <days_since_first_loan_taken>,
        "flag_current_default": <flag_current_default>,
        "number_of_loans_closed_with_dpd_0_full_cycle": <number_of_loans_closed_with_dpd_0_full_cycle>
    }
}
```

## Input Data Parameters

| Parameter                                        | Type    | Required | Description                                              |
| ------------------------------------------------ | ------- | -------- | -------------------------------------------------------- |
| `pan_number`                                     | string  | Yes      | PAN number of the applicant                              |
| `name_aadhar`                                    | string  | Yes      | Name as per Aadhaar                                      |
| `address_aadhar`                                 | string  | Yes      | Address as per Aadhaar                                   |
| `state_aadhar`                                   | string  | Yes      | State as per Aadhaar                                     |
| `city_aadhar`                                    | string  | Yes      | City as per Aadhaar                                      |
| `pincode_aadhar`                                 | string  | Yes      | Pincode as per Aadhaar                                   |
| `phone`                                          | string  | Yes      | Phone number of the applicant                            |
| `dob`                                            | string  | Yes      | Date of birth of the applicant                           |
| `max_dpd_last_loan`                              | number  | Yes      | Maximum DPD on the last loan                             |
| `max_dpd_ever_internal`                          | number  | Yes      | Maximum DPD ever recorded internally                     |
| `previous_loan_amount`                           | number  | Yes      | Amount of the previous loan                              |
| `decided_tenure_last_loan`                       | number  | Yes      | Decided tenure of the last loan                          |
| `actual_tenure_last_loan`                        | number  | Yes      | Actual tenure of the last loan                           |
| `days_since_last_loan_closed`                    | number  | Yes      | Days since the last loan was closed                      |
| `number_of_loans_closed`                         | number  | Yes      | Total number of loans closed                             |
| `days_since_last_loan_taken`                     | number  | Yes      | Days since the last loan was taken                       |
| `days_since_first_loan_taken`                    | number  | Yes      | Days since the first loan was taken                      |
| `flag_current_default`                           | boolean | Yes      | Whether the customer is currently in default             |
| `number_of_loans_closed_with_dpd_0_full_cycle`   | number  | Yes      | Number of loans closed with DPD 0 for the full cycle     |

## Next

See [Repeat BRE — Response](response.md) for the response structure.
