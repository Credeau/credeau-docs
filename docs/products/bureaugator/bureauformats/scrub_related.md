# Bureau Scrub Formats

Scrub formats let you submit bureau data that has already been extracted into tabular form (pre-parsed tradelines, enquiries, scores, etc.) instead of a raw bureau report. Each bureau below documents the tables it expects, the columns in each table, and a sample value for every column. The relevant format identifier goes as `format_type` in the request payload.

A few conventions apply across all scrub formats:

- **Tradelines / Loan Details** carry one row per loan account. A customer with multiple loans produces multiple rows.
- **Enquiries** carry one row per credit enquiry, so a customer can have multiple rows.
- **Scores** carry a single row per customer.
- In **Experian** and **CIBIL**, an account's month-by-month payment history is flattened into columns (so history stays on the same single account row). In **Equifax**, the payment history is kept at the row level in a separate **histories** table, producing multiple rows per account.

If your extracted data does not align with any of these scrub formats, please reach out to **tech@credeau.com** for guidance.

---

## `cibil_scrub_parser`

The scrub parser accepts pre-extracted bureau data as three tabular inputs — **loan details**, **enquiries**, and **scores**. Each table below lists its expected columns along with a description and a sample value to illustrate the expected data type and format.

`user_id` is the unique identifier of the customer and must be present in the **loan details** table.

Columns that accept a fixed set of values are linked to their allowed values — see [`AccountType`](#cibil-expected-values-for-accounttype), [`OwnershipIndicator`](#cibil-expected-values-for-ownershipindicator), [`paymt_freq`](#cibil-expected-values-for-paymt_freq), [`collateral_type`](#cibil-expected-values-for-collateral_type), [`Credit_Facility_Status`](#cibil-expected-values-for-credit_facility_status), and [`suit_filed_status`](#cibil-expected-values-for-suit_filed_status).

The `Paymt_hst_01` … `Paymt_hst_36` columns hold up to 36 months of payment history in reverse-chronological order — `Paymt_hst_01` is the **most recent** reported month and `Paymt_hst_36` is the **oldest**.

### Loan Details

This table holds the customer's loan accounts, with **one row per loan account**. A customer holding multiple loans will have multiple rows — one for each account. As in Experian, the month-by-month payment history is **flattened into the same row**: the `Paymt_hst_01`–`Paymt_hst_36` columns carry the 36-month history for that account, so a single row fully describes both the account and its history.

**Example** — a customer with two loan accounts (one row each; payment history spread across columns):

| user_id | accountNumber | AccountType | CurrentBalance | Paymt_hst_01 | Paymt_hst_02 | … | Paymt_hst_36 |
|---|---|---|---|---|---|---|---|
| ABC3920 | XXXX1234 | Personal Loan | 42000 | 000 | 000 | … | XXX |
| ABC3920 | XXXX9876 | Credit Card | 8000 | 030 | 000 | … | XXX |

| Column | Description | Sample Value |
|---|---|---|
| `user_id` | Unique identifier of the customer | ABC3920 |
| [`AccountType`](#cibil-expected-values-for-accounttype) | Type of loan account (e.g. Personal Loan, Credit Card) | Personal Loan |
| `ReportingMemberShortName` | Short name of the reporting member institution | HDFC BANK |
| [`OwnershipIndicator`](#cibil-expected-values-for-ownershipindicator) | Ownership indicator for the account | 1 |
| [`paymt_freq`](#cibil-expected-values-for-paymt_freq) | Payment frequency code (e.g. M for Monthly) | M |
| [`collateral_type`](#cibil-expected-values-for-collateral_type) | Collateral type code for the account | 00 |
| [`Credit_Facility_Status`](#cibil-expected-values-for-credit_facility_status) | Credit facility status code | 00 |
| [`suit_filed_status`](#cibil-expected-values-for-suit_filed_status) | Suit filed status code | 00 |
| `DateOpenedDisbursed` | The date on which the account was opened or disbursed | 2024-01-15 |
| `DateClosed` | The date on which the account was closed | null |
| `DateReported_trades` | The date on which the trade line was last reported | 2026-06-30 |
| `DateofLastPayment` | The date on which the last payment made | 2026-06-05 |
| `HighCreditSanctionedAmount` | High credit or sanctioned amount on the account | 100000 |
| `credit_limit` | Credit limit on the account | null |
| `cash_limit` | Cash withdrawal limit on the account | null |
| `CurrentBalance` | Current outstanding balance on the account | 42000 |
| `actual_paymt_amt` | Actual payment amount made | 5000 |
| `collateral_value` | Value of the collateral, if applicable | null |
| `AmountOverdue` | Amount currently overdue on the account | 0 |
| `writeoff_amt_tot` | Total written-off amount | 0 |
| `writeoff_amt_prin` | Written-off principal amount | 0 |
| `settlement_amt` | Settlement amount, if the account was settled | 0 |
| `ROI` | Rate of interest on the account | 14.5 |
| `tenure` | Repayment tenure in months | 24 |
| `emi_amt` | EMI amount on the account | 5000 |
| `accountNumber` | Account reference id of the loan account | XXXX1234 |
| `Pay_Hist_Start_Date` | Start date of the payment history period | 2026-06-01 |
| `pay_hist_end_date` | End date of the payment history period | 2025-07-01 |
| `Paymt_hst_01` | Payment history status code for month 1 | 000 |
| `Paymt_hst_02` | Payment history status code for month 2 | 000 |
| `Paymt_hst_03` | Payment history status code for month 3 | 030 |
| `Paymt_hst_04` | Payment history status code for month 4 | 000 |
| `Paymt_hst_05` | Payment history status code for month 5 | 000 |
| `Paymt_hst_06` | Payment history status code for month 6 | 000 |
| `Paymt_hst_07` | Payment history status code for month 7 | 000 |
| `Paymt_hst_08` | Payment history status code for month 8 | 000 |
| `Paymt_hst_09` | Payment history status code for month 9 | 000 |
| `Paymt_hst_10` | Payment history status code for month 10 | 000 |
| `Paymt_hst_11` | Payment history status code for month 11 | 000 |
| `Paymt_hst_12` | Payment history status code for month 12 | 000 |
| `Paymt_hst_13` | Payment history status code for month 13 | XXX |
| `Paymt_hst_14` | Payment history status code for month 14 | XXX |
| `Paymt_hst_15` | Payment history status code for month 15 | XXX |
| `Paymt_hst_16` | Payment history status code for month 16 | XXX |
| `Paymt_hst_17` | Payment history status code for month 17 | XXX |
| `Paymt_hst_18` | Payment history status code for month 18 | XXX |
| `Paymt_hst_19` | Payment history status code for month 19 | XXX |
| `Paymt_hst_20` | Payment history status code for month 20 | XXX |
| `Paymt_hst_21` | Payment history status code for month 21 | XXX |
| `Paymt_hst_22` | Payment history status code for month 22 | XXX |
| `Paymt_hst_23` | Payment history status code for month 23 | XXX |
| `Paymt_hst_24` | Payment history status code for month 24 | XXX |
| `Paymt_hst_25` | Payment history status code for month 25 | XXX |
| `Paymt_hst_26` | Payment history status code for month 26 | XXX |
| `Paymt_hst_27` | Payment history status code for month 27 | XXX |
| `Paymt_hst_28` | Payment history status code for month 28 | XXX |
| `Paymt_hst_29` | Payment history status code for month 29 | XXX |
| `Paymt_hst_30` | Payment history status code for month 30 | XXX |
| `Paymt_hst_31` | Payment history status code for month 31 | XXX |
| `Paymt_hst_32` | Payment history status code for month 32 | XXX |
| `Paymt_hst_33` | Payment history status code for month 33 | XXX |
| `Paymt_hst_34` | Payment history status code for month 34 | XXX |
| `Paymt_hst_35` | Payment history status code for month 35 | XXX |
| `Paymt_hst_36` | Payment history status code for month 36 | XXX |

### Enquiries

The enquiries table lists credit enquiries raised against the customer, with **one row per enquiry**. A customer can be enquired about many times, so this table typically has **multiple rows per customer**.

| Column | Description | Sample Value |
|---|---|---|
| `DateofEnquiry` | Date of the loan enquiry | 2024-03-18 |
| `EnquiryPurpose` | Purpose code of the enquiry | 05 |
| `EnquiryAmount` | Amount for which the enquiry was made | 40000 |
| `EnquiringMemberShortName` | Short name of the enquiring member institution | HDFC BANK |

### Scores

The scores table carries the customer's bureau score. It holds a **single row per customer**.

| Column | Description | Sample Value |
|---|---|---|
| `scorename` | Name of the bureau score (e.g. CIBILTUSC3) | CIBILTUSC3 |
| `ScoreCardVersion` | Version of the scorecard used | 10 |
| `score` | Bureau credit score of the customer | 786 |

### CIBIL Expected Values for `AccountType`

1. Auto Lease
2. Auto Loan
3. Auto Loan (Personal)
4. Business Loan
5. Business Loan - General
6. Business Loan - Priority Sector - Agriculture
7. Business Loan - Priority Sector - Others
8. Business Loan - Priority Sector - Small Business
9. Business Loan - Secured
10. Business Loan - Unsecured
11. Business Loan Against Bank Deposits
12. Business Non-Funded Credit Facility
13. Business Non-Funded Credit Facility - General
14. Business Non-Funded Credit Facility - Priority Sector - Agriculture
15. Business Non-Funded Credit Facility - Priority Sector - Other
16. Business Non-Funded Credit Facility - Priority Sector - Small Business
17. Commercial Vehicle Loan
18. Construction Equipment Loan
19. Consumer Loan
20. Corporate Credit Card
21. Credit Card
22. Disclosure
23. Education Loan
24. Fleet Card
25. GECL Loan Secured
26. GECL Loan Unsecured
27. Gold Loan
28. Housing Loan
29. JLG Group
30. JLG Individual
31. Kisan Credit Card
32. Lease
33. Loan Against Bank Deposits
34. Loan Against Shares / Securities
35. Loan on Credit Card
36. Loan to Professional
37. Microfinance Business Loan
38. Microfinance Housing Loan
39. Microfinance Others
40. Microfinance Personal Loan
41. Mudra Loans - Shishu / Kishor / Tarun
42. Non-Funded Credit Facility
43. Other
44. Overdraft
45. P2P Auto Loan
46. P2P Education Loan
47. P2P Personal Loan
48. Personal Loan
49. Pradhan Mantri Awas Yojana - CLSS
50. Pradhan Mantri Awas Yojana - Credit Link Subsidy Scheme MAY CLSS
51. Prime Minister Jaan Dhan Yojana - Overdraft
52. Priority Sector - Gold Loan
53. Property Loan
54. Secured Credit Card
55. Seller Financing
56. Short Term Personal Loan
57. Staff Loan
58. Telco - Broadband
59. Telco - Landline
60. Telco - Wireless
61. Temporary Overdraft
62. Tractor Loan
63. Two-Wheeler Loan
64. Used Car Loan

### CIBIL Expected Values for `OwnershipIndicator`

1. Authorized User
2. Guarantor
3. Individual
4. Joint

### CIBIL Expected Values for `paymt_freq`

1. Fortnightly
2. Monthly
3. Quarterly
4. Unknown
5. Weekly

### CIBIL Expected Values for `collateral_type`

1. Gold
2. No Collateral
3. Property
4. Saving Account and Fixed Deposit
5. Shares
6. Unknown

### CIBIL Expected Values for `Credit_Facility_Status`

1. Account Purchased
2. Account Purchased and Restructured
3. Account Purchased and Settled
4. Account Purchased and Written Off
5. Account Sold
6. Post (WO) Settled
7. Restructured Loan
8. Restructured Loan (Govt. Mandated)
9. Restructured due to COVID-19
10. Restructured due to Natural Calamity
11. Settled
12. Unknown
13. Written Off and Account Sold
14. Written-off

### CIBIL Expected Values for `suit_filed_status`

1. No Suit Filed
2. Suit Filed
3. Suit filed (Wilful default)
4. Wilful default

---

## `experian_scrub_parser`

The scrub parser accepts pre-extracted bureau data as three tabular inputs — **tradelines**, **enquiries**, and **scores**. Each table below lists its expected columns along with a description and a sample value to illustrate the expected data type and format.

`customer_id` is the unique identifier of the customer and must be present in all three tables.

Columns that accept a fixed set of values are linked to their allowed values — see [`account_type`](#experian-expected-values-for-account_type), [`payment_frequency`](#experian-expected-values-for-payment_frequency), [`written_off_and_settled_status`](#experian-expected-values-for-written_off_and_settled_status), and [`suit_filed_willful_dflt`](#experian-expected-values-for-suit_filed_willful_dflt).

The `days_past_due_01` … `days_past_due_36` columns hold up to 36 months of payment history in reverse-chronological order — `days_past_due_01` is the **most recent** reported month and `days_past_due_36` is the **oldest**.

### Tradelines and Histories

This table holds the customer's loan accounts, with **one row per loan account**. A customer holding multiple loans will have multiple rows — one for each account. In Experian, the month-by-month payment history is **flattened into the same row**: the `days_past_due_01`–`days_past_due_36` columns carry the 36-month history for that account, so a single row fully describes both the account and its history (hence "Tradelines and Histories" are combined).

**Example** — a customer with two loan accounts (one row each; DPD history spread across columns):

| customer_id | account_nb | account_type | balance_am | days_past_due_01 | days_past_due_02 | … | days_past_due_36 |
|---|---|---|---|---|---|---|---|
| AB32843931 | XXXX1 | Consumer Loan | 0.0 | 0.0 | 0.0 | … | 0.0 |
| AB32843931 | XXXX2 | Personal Loan | 12000.0 | 30.0 | 0.0 | … | 0.0 |

| Column | Description | Sample Value |
|---|---|---|
| `customer_id` | Unique identifier of the customer | AB32843931 |
| `account_nb` | Account reference id of the loan account | XXXX |
| [`account_type`](#experian-expected-values-for-account_type) | Type of loan account (e.g. Consumer Loan, Personal Loan) | Consumer Loan |
| `m_sub_id` | Subscriber or member identifier of the reporting institution | NBF |
| `open_dt` | The date on which the account was opened | 2025-01-24 |
| `closed_dt` | The date on which the account was closed | 2026-02-01 |
| `balance_dt` | The date on which the balance was last reported | 2026-02-28 |
| `balance_am` | Current outstanding balance on the account | 0.0 |
| `orig_loan_am` | Original loan amount sanctioned | 1499.0 |
| `credit_limit_am` | Credit limit on the account | 1499.0 |
| `past_due_am` | Amount currently past due on the account | 0.0 |
| `written_off_amt_total` | Total written-off amount on the account | NaN |
| `written_off_amt_principal` | Written-off principal amount on the account | NaN |
| `last_payment_dt` | Date of the last payment made | 2026-02-01 |
| `actual_payment_am` | Amount of the last actual payment made | 0.0 |
| `interest_rate` | Rate of interest on the account | NaN |
| `cash_limit` | Cash withdrawal limit on the account | NaN |
| `tenure` | Repayment tenure of the account | NaN |
| [`payment_frequency`](#experian-expected-values-for-payment_frequency) | Frequency of payments (e.g. Monthly, Weekly) | Monthly |
| `settlement_amount` | Settlement amount, if the account was settled | NaN |
| [`written_off_and_settled_status`](#experian-expected-values-for-written_off_and_settled_status) | Written-off or settled status of the account | Settled |
| [`suit_filed_willful_dflt`](#experian-expected-values-for-suit_filed_willful_dflt) | Suit filed or wilful default status on the account | NaN |
| `asset_class` | Asset classification for the account | NaN |
| `days_past_due_01` | Days past due for month 1 (historical payment history) | 0.0 |
| `days_past_due_02` | Days past due for month 2 (historical payment history) | 0.0 |
| `days_past_due_03` | Days past due for month 3 (historical payment history) | 0.0 |
| `days_past_due_04` | Days past due for month 4 (historical payment history) | 0.0 |
| `days_past_due_05` | Days past due for month 5 (historical payment history) | 0.0 |
| `days_past_due_06` | Days past due for month 6 (historical payment history) | 0.0 |
| `days_past_due_07` | Days past due for month 7 (historical payment history) | 0.0 |
| `days_past_due_08` | Days past due for month 8 (historical payment history) | 0.0 |
| `days_past_due_09` | Days past due for month 9 (historical payment history) | 0.0 |
| `days_past_due_10` | Days past due for month 10 (historical payment history) | 0.0 |
| `days_past_due_11` | Days past due for month 11 (historical payment history) | 0.0 |
| `days_past_due_12` | Days past due for month 12 (historical payment history) | 0.0 |
| `days_past_due_13` | Days past due for month 13 (historical payment history) | 0.0 |
| `days_past_due_14` | Days past due for month 14 (historical payment history) | 0.0 |
| `days_past_due_15` | Days past due for month 15 (historical payment history) | 0.0 |
| `days_past_due_16` | Days past due for month 16 (historical payment history) | 0.0 |
| `days_past_due_17` | Days past due for month 17 (historical payment history) | 0.0 |
| `days_past_due_18` | Days past due for month 18 (historical payment history) | 0.0 |
| `days_past_due_19` | Days past due for month 19 (historical payment history) | 0.0 |
| `days_past_due_20` | Days past due for month 20 (historical payment history) | 0.0 |
| `days_past_due_21` | Days past due for month 21 (historical payment history) | 0.0 |
| `days_past_due_22` | Days past due for month 22 (historical payment history) | 0.0 |
| `days_past_due_23` | Days past due for month 23 (historical payment history) | 0.0 |
| `days_past_due_24` | Days past due for month 24 (historical payment history) | 0.0 |
| `days_past_due_25` | Days past due for month 25 (historical payment history) | 0.0 |
| `days_past_due_26` | Days past due for month 26 (historical payment history) | 0.0 |
| `days_past_due_27` | Days past due for month 27 (historical payment history) | 0.0 |
| `days_past_due_28` | Days past due for month 28 (historical payment history) | 0.0 |
| `days_past_due_29` | Days past due for month 29 (historical payment history) | 0.0 |
| `days_past_due_30` | Days past due for month 30 (historical payment history) | 0.0 |
| `days_past_due_31` | Days past due for month 31 (historical payment history) | 0.0 |
| `days_past_due_32` | Days past due for month 32 (historical payment history) | 0.0 |
| `days_past_due_33` | Days past due for month 33 (historical payment history) | 0.0 |
| `days_past_due_34` | Days past due for month 34 (historical payment history) | 0.0 |
| `days_past_due_35` | Days past due for month 35 (historical payment history) | 0.0 |
| `days_past_due_36` | Days past due for month 36 (historical payment history) | 0.0 |

### Enquiries

The enquiries table lists credit enquiries raised against the customer, with **one row per enquiry**. A customer can be enquired about many times, so this table typically has **multiple rows per customer**.

| Column | Description | Sample Value |
|---|---|---|
| `customer_id` | Unique identifier of the customer | AB32843931 |
| `inquiry_purpose` | Purpose of the loan inquiry | Personal Loan |
| `m_sub_id` | Subscriber or member identifier of the inquiring institution | NBF |
| `amount` | Amount for which the inquiry was made | 20000 |
| `inq_date` | Date of the inquiry | 2025-12-13 |

### Scores

The scores table carries the customer's bureau score. It holds a **single row per customer**.

| Column | Description | Sample Value |
|---|---|---|
| `customer_id` | Unique identifier of the customer | AB32843931 |
| `score` | Bureau credit score of the customer | 628 |

### Experian Expected Values for `account_type`

1. Auto Loan
2. Business Loan - Secured
3. Business Loan - Unsecured
4. Business Loan – General
5. Business Loan – Priority Sector – Agriculture
6. Business Loan – Priority Sector – Others
7. Business Loan – Priority Sector – Small Business
8. Business Loans Against Bank Deposits
9. Business Non-Funded Credit Facility – General
10. Business Non-Funded Credit Facility – Priority Sector – Agriculture
11. Business Non-Funded Credit Facility – Priority Sector – Others
12. Business Non-Funded Credit Facility – Priority Sector – Small Business
13. Commercial Vehicle Loan
14. Construction Equipment Loan
15. Consumer Loan
16. Corporate Credit Card
17. Credit Card
18. Educational Loan
19. Fleet Card
20. GECL Loan Secured
21. GECL Loan Unsecured
22. Gold Loan
23. Housing Loan
24. Kisan Credit Card
25. Leasing
26. Loan Against Bank Deposits
27. Loan Against Shares/Securities
28. Loan On Credit Card
29. Loan To Professional
30. Microfinance - Business Loan
31. Microfinance - Housing Loan
32. Microfinance - Personal Loan
33. Microfinance – Others
34. Mudra Loans – Shishu / Kishor / Tarun
35. Non-Funded Credit Facility
36. Other
37. Overdraft
38. P2P Education Loan
39. P2P Personal Loan
40. Personal Loan
41. Pradhan Mantri Awas Yojana - CLSS
42. Prime Minister Jaan Dhan Yojana - Overdraft
43. Priority Sector - Gold Loan
44. Property Loan
45. Secured Credit Card
46. Short Term Personal Loan
47. Staff Loan
48. Telco – Broadband
49. Telco – Landline
50. Telco – Wireless
51. Temporary Overdraft
52. Tractor Loan
53. Two-Wheeler Loan
54. Used Car Loan

### Experian Expected Values for `payment_frequency`

1. Fortnightly
2. Monthly
3. Quarterly
4. Weekly

### Experian Expected Values for `written_off_and_settled_status`

1. Account Purchased
2. Account Purchased and Restructured
3. Account Purchased and Settled
4. Account Purchased and Written Off
5. Account Sold
6. Post (WO) Settled
7. Restructured
8. Restructured Loan
9. Restructured Loan (Govt. Mandated)
10. Settled
11. Written Off and Account Sold
12. Written-off

### Experian Expected Values for `suit_filed_willful_dflt`

1. No Suit Filed
2. Suit Filed
3. Suit filed (Wilful default)
4. Wilful default

---

## `equifax_scrub_parser`

The scrub parser accepts pre-extracted bureau data as four tabular inputs — **tradelines**, **histories**, **enquiries**, and **scores**. Each table below lists its expected columns along with a description and a sample value to illustrate the expected data type and format.

`mobile_hash` is the unique identifier of the customer, and `acct_uniq_id` is the unique loan identifier for the customer. Both the **tradelines** and **histories** tables must include these columns.

Columns that accept a fixed set of values are linked to their allowed values — see [`accounttype`](#equifax-expected-values-for-accounttype), [`terms_frequency`](#equifax-expected-values-for-terms_frequency), [`collateraltype`](#equifax-expected-values-for-collateraltype), and [`suitfiledstatus`](#equifax-expected-values-for-suitfiledstatus).

### Equifax Tradelines

This table holds the customer's loan accounts, with **one row per loan account**. A customer holding multiple loans will have multiple rows — one for each account. Unlike Experian and CIBIL, the month-by-month payment history is **not** flattened into this row; it is captured separately in the [Histories](#equifax-histories) table and linked back via `acct_uniq_id` (and `mobile_hash`).

**Example** — a customer with two loan accounts (one row each):

| mobile_hash | acct_uniq_id | acct_number | accounttype | balance |
|---|---|---|---|---|
| 1521168 | 2129487187 | 12564351 | Personal Loan | 0 |
| 1521168 | 2129487999 | 12564352 | Two-Wheeler Loan | 15000 |

| Column | Description | Sample Value |
|---|---|---|
| `mobile_hash` | Unique identifier of the customer | 1521168 |
| `acct_uniq_id` | Unique loan identifier for the customer | 2129487187 |
| `acct_number` | Account reference id of the loan account | 12564351 |
| `accountstatus` | Current status of the account (e.g. New Account, Closed) | Closed Account |
| [`accounttype`](#equifax-expected-values-for-accounttype) | Type of loan account (e.g. Personal Loan, Credit Card) | Personal Loan |
| `assetclassification` | Asset classification status for the account | NaN |
| `balance` | Current outstanding balance on the account | 0 |
| `sanctionamount` | Original sanctioned or approved loan amount | 1200000 |
| [`collateraltype`](#equifax-expected-values-for-collateraltype) | Type of collateral securing the account, if any | NaN |
| `collateralvalue` | Value of the collateral, if applicable | 0 |
| `creditlimit` | Credit limit on the account (for revolving credit) | 0 |
| `dateclosed` | The date on which the account was closed | 22-01-2022 |
| `dateopened` | The date on which the account was opened | 08-11-2021 |
| `datereported` | The date on which the account was last reported to the bureau | 31-03-2022 |
| `highcredit` | Highest credit amount utilized or sanctioned on the account | 1200000 |
| `cash_limit` | Cash withdrawal limit on the account | NaN |
| `settlement_amt` | Settlement amount, if the account was settled | NaN |
| `installmentamount` | EMI or installment amount on the account | 0 |
| `interestrate` | Rate of interest on the account | 1.0 |
| `lastpayment` | Amount of the last payment made | 0 |
| `lastpaymentdate` | Date of the last payment made | 22-01-2022 |
| `ownershiptype` | Ownership type of the account (e.g. Individual, Joint) | Individual |
| `pastdueamount` | Amount currently past due on the account | 0 |
| `repaymenttenure` | Repayment tenure in months | 1200000.0 |
| [`terms_frequency`](#equifax-expected-values-for-terms_frequency) | Frequency of payment terms (e.g. Monthly) | Monthly |
| [`suitfiledstatus`](#equifax-expected-values-for-suitfiledstatus) | Suit filed status on the account | NaN |
| `writeoffamount` | Written-off amount on the account | 0 |
| `sector` | Lending sector or institution category | NBFC |

### Equifax Histories

This table holds the month-by-month payment history, with **multiple rows per loan account** — one row for each reported month. In Equifax the days-past-due history is kept at the row level (not flattened into columns), so an account with 12 reported months contributes 12 rows here. Each row links back to its account in the [Tradelines](#equifax-tradelines) table via `acct_uniq_id` (and `mobile_hash`). For each account, the rows must be ordered chronologically from **most recent** to **oldest**.

**Example** — a single loan account (`acct_uniq_id` 2129487187) with one row per reported month, most recent first:

| mobile_hash | acct_uniq_id | accounttype | pastdueamount | days_past_due |
|---|---|---|---|---|
| 1521168 | 2129487187 | Personal Loan | 0 | 0 |
| 1521168 | 2129487187 | Personal Loan | 4200 | 18 |
| 1521168 | 2129487187 | Personal Loan | 4200 | 30 |

| Column | Description | Sample Value |
|---|---|---|
| `mobile_hash` | Unique identifier of the customer | 1521168 |
| `acct_uniq_id` | Unique loan identifier for the customer | 2129487187 |
| `pastdueamount` | Past due amount for the history period | 4200 |
| [`accounttype`](#equifax-expected-values-for-accounttype) | Type of loan account | Personal Loan |
| `days_past_due` | Number of days past due for the history period | 18 |

### Equifax Enquiries

The enquiries table lists credit enquiries raised against the customer, with **one row per enquiry**. A customer can be enquired about many times, so this table typically has **multiple rows per customer**.

| Column | Description | Sample Value |
|---|---|---|
| `mobile_hash` | Unique identifier of the customer | 1521168 |
| `inquiry_purpose` | Purpose of the loan inquiry | Personal Loan |
| `m_sub_id` | Subscriber or member identifier of the inquiring institution | NBFC |
| `amount` | Amount for which the inquiry was made | 500000 |
| `inq_date` | Date of the inquiry | 12-10-2021 |

### Equifax Scores

The scores table carries the customer's bureau score. It holds a **single row per customer**.

| Column | Description | Sample Value |
|---|---|---|
| `mobile_hash` | Unique identifier of the customer | 1521168 |
| `score` | Bureau credit score of the customer | 628 |

### Equifax Expected Values for `accounttype`

1. Auto Loan
2. Business Loan - Secured
3. Business Loan - Unsecured
4. Business Loan – General
5. Business Loan – Priority Sector – Agriculture
6. Business Loan – Priority Sector – Others
7. Business Loan – Priority Sector – Small Business
8. Business Loans Against Bank Deposits
9. Business Non-Funded Credit Facility – General
10. Business Non-Funded Credit Facility – Priority Sector – Agriculture
11. Business Non-Funded Credit Facility – Priority Sector – Others
12. Business Non-Funded Credit Facility – Priority Sector – Small Business
13. Commercial Vehicle Loan
14. Construction Equipment Loan
15. Consumer Loan
16. Corporate Credit Card
17. Credit Card
18. Educational Loan
19. Fleet Card
20. GECL Loan Secured
21. GECL Loan unsecured
22. Gold Loan
23. Housing Loan
24. Kisan Credit Card
25. Leasing
26. Loan Against Bank Deposits
27. Loan Against Shares/Securities
28. Loan On Credit Card
29. Loan To Professional
30. Microfinance - Business Loan
31. Microfinance - Housing Loan
32. Microfinance - Other
33. Microfinance - Personal Loan
34. Mudra Loans – Shishu / Kishor / Tarun
35. Non-Funded Credit Facility
36. Other
37. Overdraft
38. P2P Auto Loan
39. P2P Personal Loan
40. Personal Loan
41. Pradhan Mantri Awas Yojana - CLSS
42. Prime Minister Jaan Dhan Yojana - Overdraft
43. Priority Sector - Gold Loan
44. Property Loan
45. Secured Credit Card
46. Short Term Personal Loan
47. Staff Loan
48. Telco – Broadband
49. Telco – Landline
50. Telco – Wireless
51. Temporary Overdraft
52. Tractor Loan
53. Two-Wheeler Loan
54. Used Car Loan

### Equifax Expected Values for `terms_frequency`

1. Fortnightly
2. Monthly
3. Quarterly
4. Weekly

### Equifax Expected Values for `collateraltype`

1. Gold
2. No Collateral
3. Property
4. Saving Account and Fixed Deposit
5. Shares

### Equifax Expected Values for `suitfiledstatus`

1. Post Written Off / Settled
2. Restructured Loan
3. Settled
4. Suit Filed
5. Suit Filed and Written Off
6. Suit Filed-Willful Default
7. Suit, Filed, Willful Default and Written Off
8. Willful Default
9. Willful Default and Written Off
10. Written Off
