# CIBIL Bureau Formats

CIBIL (TransUnion CIBIL) provides credit reports in JSON format featuring the TUEF (TransUnion Exchange Format) structure. The reports include CIBIL scores, account information with payment history strings, inquiry details, and consumer summary data. CIBIL formats are known for their standardized payment status codes and comprehensive account tracking with detailed EMI and tenure information.

### `cibil_json`

```json
{
    "controlData": {
        "success": true
    },
    "consumerCreditData": [
        {
            "tuefHeader": {
                "headerType": "",
                "version": "12",
                "memberRefNo": "",
                "enquiryMemberUserId": "",
                "subjectReturnCode": 1,
                "enquiryControlNumber": "",
                "dateProcessed": "18042026",
                "timeProcessed": "183235"
            },
            "scores": [
                {
                    "scoreName": "CIBILTUSC3",
                    "scoreCardName": "08",
                    "scoreCardVersion": "10",
                    "scoreDate": "18042026",
                    "score": "00786"
                }
            ],
            "accounts": [
                {
                    "index": "T001",
                    "memberShortName": "NOT DISCLOSED",
                    "accountType": "05",
                    "ownershipIndicator": 1,
                    "dateOpened": "28112024",
                    "lastPaymentDate": "17102025",
                    "dateReported": "31032026",
                    "highCreditAmount": 1330000,
                    "currentBalance": 1156281,
                    "paymentHistory": "STDSTDSTDSTDSTD029029029029029029029029029029STDSTD",
                    "paymentStartDate": "01032026",
                    "paymentEndDate": "01112024",
                    "interestRate": 12.6,
                    "paymentTenure": 84,
                    "emiAmount": 23908,
                    "paymentFrequency": "03"
                }
            ],
            "enquiries": [
                {
                    "index": "I001",
                    "enquiryDate": "18042026",
                    "memberShortName": "NOT DISCLOSED",
                    "enquiryPurpose": "05",
                    "enquiryAmount": 40000
                }
            ],
            "names": [],
            "ids": [],
            "telephones": [],
            "emails": []
        }
    ],
    "consumerSummaryData": {
        "accountSummary": {
            "totalAccounts": 12,
            "overdueAccounts": 0,
            "zeroBalanceAccounts": 11,
            "highCreditAmount": 4814499,
            "currentBalance": 1156281,
            "overdueBalance": 0,
            "recentDateOpened": "28112024",
            "oldestDateOpened": "15042009"
        },
        "inquirySummary": {
            "totalInquiry": 7,
            "inquiryPast30Days": 1,
            "inquiryPast12Months": 0,
            "inquiryPast24Months": 4,
            "recentInquiryDate": "18042026"
        }
    }
}
```

### `cibil_scrub_parser`

The scrub format expects 3 DataFrame tables — loan details, enquiries, and scores. The column descriptions for each are mentioned below.

#### Loan Details

| Column | Description |
|---|---|
| `user_id` | Unique identifier of the customer |
| `AccountType` | Type of credit account (e.g. Personal Loan, Credit Card) |
| `ReportingMemberShortName` | Short name of the reporting member institution |
| `OwnershipIndicator` | Ownership indicator for the account |
| `paymt_freq` | Payment frequency code (e.g. M for Monthly) |
| `collateral_type` | Collateral type code for the account |
| `Credit_Facility_Status` | Credit facility status code |
| `suit_filed_status` | Suit filed status code |
| `DateOpenedDisbursed` | Date the account was opened or disbursed |
| `DateClosed` | Date the account was closed |
| `DateReported_trades` | Date the trade line was last reported |
| `DateofLastPayment` | Date of the last payment made |
| `HighCreditSanctionedAmount` | High credit or sanctioned amount on the account |
| `credit_limit` | Credit limit on the account |
| `cash_limit` | Cash withdrawal limit on the account |
| `CurrentBalance` | Current outstanding balance on the account |
| `actual_paymt_amt` | Actual payment amount made |
| `collateral_value` | Value of the collateral, if applicable |
| `AmountOverdue` | Amount currently overdue on the account |
| `writeoff_amt_tot` | Total written-off amount |
| `writeoff_amt_prin` | Written-off principal amount |
| `settlement_amt` | Settlement amount, if the account was settled |
| `ROI` | Rate of interest on the account |
| `tenure` | Repayment tenure in months |
| `emi_amt` | EMI amount on the account |
| `accountNumber` | Account number reported by the lender |
| `Pay_Hist_Start_Date` | Start date of the payment history period |
| `pay_hist_end_date` | End date of the payment history period |
| `Paymt_hst_01` | Payment history status code for month 1 |
| `Paymt_hst_02` | Payment history status code for month 2 |
| `Paymt_hst_03` | Payment history status code for month 3 |
| `Paymt_hst_04` | Payment history status code for month 4 |
| `Paymt_hst_05` | Payment history status code for month 5 |
| `Paymt_hst_06` | Payment history status code for month 6 |
| `Paymt_hst_07` | Payment history status code for month 7 |
| `Paymt_hst_08` | Payment history status code for month 8 |
| `Paymt_hst_09` | Payment history status code for month 9 |
| `Paymt_hst_10` | Payment history status code for month 10 |
| `Paymt_hst_11` | Payment history status code for month 11 |
| `Paymt_hst_12` | Payment history status code for month 12 |
| `Paymt_hst_13` | Payment history status code for month 13 |
| `Paymt_hst_14` | Payment history status code for month 14 |
| `Paymt_hst_15` | Payment history status code for month 15 |
| `Paymt_hst_16` | Payment history status code for month 16 |
| `Paymt_hst_17` | Payment history status code for month 17 |
| `Paymt_hst_18` | Payment history status code for month 18 |
| `Paymt_hst_19` | Payment history status code for month 19 |
| `Paymt_hst_20` | Payment history status code for month 20 |
| `Paymt_hst_21` | Payment history status code for month 21 |
| `Paymt_hst_22` | Payment history status code for month 22 |
| `Paymt_hst_23` | Payment history status code for month 23 |
| `Paymt_hst_24` | Payment history status code for month 24 |
| `Paymt_hst_25` | Payment history status code for month 25 |
| `Paymt_hst_26` | Payment history status code for month 26 |
| `Paymt_hst_27` | Payment history status code for month 27 |
| `Paymt_hst_28` | Payment history status code for month 28 |
| `Paymt_hst_29` | Payment history status code for month 29 |
| `Paymt_hst_30` | Payment history status code for month 30 |
| `Paymt_hst_31` | Payment history status code for month 31 |
| `Paymt_hst_32` | Payment history status code for month 32 |
| `Paymt_hst_33` | Payment history status code for month 33 |
| `Paymt_hst_34` | Payment history status code for month 34 |
| `Paymt_hst_35` | Payment history status code for month 35 |
| `Paymt_hst_36` | Payment history status code for month 36 |

#### Enquiries

| Column | Description |
|---|---|
| `DateofEnquiry` | Date of the credit enquiry |
| `EnquiryPurpose` | Purpose code of the enquiry |
| `EnquiryAmount` | Amount for which the enquiry was made |
| `EnquiringMemberShortName` | Short name of the enquiring member institution |

#### Scores

| Column | Description |
|---|---|
| `scorename` | Name of the bureau score (e.g. CIBILTUSC3) |
| `ScoreCardVersion` | Version of the scorecard used |
| `score` | Bureau credit score for the customer |

#### Sample Values

The sample values below illustrate the expected data types and formats for each table. Use these as a reference when preparing scrub data for the parser.

#### Loan Details

<div markdown="0">
<table>
<thead>
<tr><th>Column</th><th>Sample Value</th></tr>
</thead>
<tbody>
    <tr><th><code>user_id</code></th><td>ABC3920</td></tr>
    <tr><th><code>AccountType</code></th><td>Personal Loan</td></tr>
    <tr><th><code>ReportingMemberShortName</code></th><td>HDFC BANK</td></tr>
    <tr><th><code>OwnershipIndicator</code></th><td>1</td></tr>
    <tr><th><code>paymt_freq</code></th><td>M</td></tr>
    <tr><th><code>collateral_type</code></th><td>00</td></tr>
    <tr><th><code>Credit_Facility_Status</code></th><td>00</td></tr>
    <tr><th><code>suit_filed_status</code></th><td>00</td></tr>
    <tr><th><code>DateOpenedDisbursed</code></th><td>2024-01-15</td></tr>
    <tr><th><code>DateClosed</code></th><td>null</td></tr>
    <tr><th><code>DateReported_trades</code></th><td>2026-06-30</td></tr>
    <tr><th><code>DateofLastPayment</code></th><td>2026-06-05</td></tr>
    <tr><th><code>HighCreditSanctionedAmount</code></th><td>100000</td></tr>
    <tr><th><code>credit_limit</code></th><td>null</td></tr>
    <tr><th><code>cash_limit</code></th><td>null</td></tr>
    <tr><th><code>CurrentBalance</code></th><td>42000</td></tr>
    <tr><th><code>actual_paymt_amt</code></th><td>5000</td></tr>
    <tr><th><code>collateral_value</code></th><td>null</td></tr>
    <tr><th><code>AmountOverdue</code></th><td>0</td></tr>
    <tr><th><code>writeoff_amt_tot</code></th><td>0</td></tr>
    <tr><th><code>writeoff_amt_prin</code></th><td>0</td></tr>
    <tr><th><code>settlement_amt</code></th><td>0</td></tr>
    <tr><th><code>ROI</code></th><td>14.5</td></tr>
    <tr><th><code>tenure</code></th><td>24</td></tr>
    <tr><th><code>emi_amt</code></th><td>5000</td></tr>
    <tr><th><code>accountNumber</code></th><td>XXXX1234</td></tr>
    <tr><th><code>Pay_Hist_Start_Date</code></th><td>2026-06-01</td></tr>
    <tr><th><code>pay_hist_end_date</code></th><td>2025-07-01</td></tr>
    <tr><th><code>Paymt_hst_01</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_02</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_03</code></th><td>030</td></tr>
    <tr><th><code>Paymt_hst_04</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_05</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_06</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_07</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_08</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_09</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_10</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_11</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_12</code></th><td>000</td></tr>
    <tr><th><code>Paymt_hst_13</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_14</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_15</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_16</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_17</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_18</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_19</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_20</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_21</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_22</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_23</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_24</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_25</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_26</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_27</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_28</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_29</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_30</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_31</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_32</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_33</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_34</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_35</code></th><td>XXX</td></tr>
    <tr><th><code>Paymt_hst_36</code></th><td>XXX</td></tr>
</tbody>
</table>
</div>

The following are the expected values for `AccountType`:

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

The following are the expected values for `OwnershipIndicator`:

1. Authorized User
2. Guarantor
3. Individual
4. Joint

The following are the expected values for `paymt_freq`:

1. Fortnightly
2. Monthly
3. Quarterly
4. Unknown
5. Weekly

The following are the expected values for `collateral_type`:

1. Gold
2. No Collateral
3. Property
4. Saving Account and Fixed Deposit
5. Shares
6. Unknown

The following are the expected values for `Credit_Facility_Status`:

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

The following are the expected values for `suit_filed_status`:

1. No Suit Filed
2. Suit Filed
3. Suit filed (Wilful default)
4. Wilful default

#### Enquiries

<div markdown="0">
<table>
<thead>
<tr><th>Column</th><th>Sample Value</th></tr>
</thead>
<tbody>
    <tr><th><code>DateofEnquiry</code></th><td>2024-03-18</td></tr>
    <tr><th><code>EnquiryPurpose</code></th><td>05</td></tr>
    <tr><th><code>EnquiryAmount</code></th><td>40000</td></tr>
    <tr><th><code>EnquiringMemberShortName</code></th><td>HDFC BANK</td></tr>
</tbody>
</table>
</div>

#### Scores

<div markdown="0">
<table>
<thead>
<tr><th>Column</th><th>Sample Value</th></tr>
</thead>
<tbody>
    <tr><th><code>scorename</code></th><td>CIBILTUSC3</td></tr>
    <tr><th><code>ScoreCardVersion</code></th><td>10</td></tr>
    <tr><th><code>score</code></th><td>786</td></tr>
</tbody>
</table>
</div>
