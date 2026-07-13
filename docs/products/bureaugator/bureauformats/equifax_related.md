# Equifax Bureau Formats

Equifax provides credit reports in JSON format with comprehensive consumer credit information. The response structure includes personal details, account summaries, credit scores (ERS - Equifax Risk Score), account details with payment history, and inquiry information. Equifax reports typically feature detailed account-level data with monthly payment status tracking and risk assessment elements.

### `equifax_softpull_json`

```json
{
    "InquiryResponseHeader": {
        "ClientID": "",
        "CustRefField": "",
        "ReportOrderNO": "",
        "ProductCode": [
            "CCR"
        ],
        "SuccessCode": "1",
        "Date": "2026-04-08",
        "Time": "10:15:11"
    },
    "Score": [
        {
            "Type": "ERS",
            "Version": "4.0"
        }
    ],
    "CCRResponse": {
        "Status": "1",
        "CIRReportDataLst": [
            {
                "Score": [
                    {
                        "Type": "ERS",
                        "Version": "4.0"
                    }
                ],
                "CIRReportData": {
                    "IDAndContactInfo": {
                        "PersonalInfo": {
                            "Name": {
                                "FullName": "XXXXX",
                                "FirstName": "XXXXX ",
                                "MiddleName": "XXXXX "
                            },
                            " AliasName": {},
                            "DateOfBirth": "1991-01-01",
                            "Gender": "Male",
                            "Age": {
                                "Age": "35"
                            },
                            "PlaceOfBirthInfo": {},
                            "TotalIncome": "25000"
                        },
                        "IdentityInfo": {
                            "PANId": [
                                {
                                    "seq": "1",
                                    "ReportedDate": "2026-03-31",
                                    "IdNumber": "XXXXX"
                                }
                            ],
                            "NationalIDCard": [
                                {
                                    "seq": "1",
                                    "ReportedDate": "2026-03-23",
                                    "IdNumber": "XXXXXXXXXXXX"
                                }
                            ],
                            "CKYCId": [
                                {
                                    "seq": "1",
                                    "ReportedDate": "2024-11-30",
                                    "IdNumber": "60055492853835"
                                }
                            ]
                        },
                        "AddressInfo": [
                            {
                                "Seq": "1",
                                "ReportedDate": "2026-03-31",
                                "Address": "456/10 CHHOTU RAM NAGAR  BAHADURGARH ROHTAK HARYANA 124507",
                                "State": "HR",
                                "Postal": "124507",
                                "Type": "Owns,Permanent"
                            }
                        ],
                        "PhoneInfo": [
                            {
                                "seq": "1",
                                "typeCode": "H",
                                "ReportedDate": "2026-02-07",
                                "Number": "XXXXX"
                            }
                        ],
                        "EmailAddressInfo": [
                            {
                                "seq": "1",
                                "ReportedDate": "2024-11-30",
                                "EmailAddress": "XXXXX@GMAIL.COM"
                            }
                        ]
                    },
                    "ScoreDetails": [
                        {
                            "Type": "ERS",
                            "Version": "4.0",
                            "Name": "RTL.ERS4.0",
                            "Value": "746",
                            "ScoringElements": [
                                {
                                    "type": "RES",
                                    "seq": "1",
                                    "code": "600",
                                    "Description": "Recent Credit exposure"
                                },
                                {
                                    "type": "RES",
                                    "seq": "2",
                                    "code": "606",
                                    "Description": "Earlier Closed Accounts"
                                },
                                {
                                    "type": "RES",
                                    "seq": "3",
                                    "code": "605",
                                    "Description": "Number of Personal Loans"
                                }
                            ]
                        }
                    ],
                    "Enquiries": [
                        {
                            "seq": "1",
                            "Institution": "FINANCE",
                            "Date": "2025-11-16",
                            "Time": "12:49",
                            "RequestPurpose": "00"
                        }
                    ],
                    "RetailAccountsSummary": {
                                "NoOfAccounts": "31",
                                "NoOfActiveAccounts": "13",
                                "NoOfWriteOffs": "0",
                                "TotalPastDue": "0.00",
                                "MostSevereStatusWithIn24Months": "Non-Delnqt",
                                "SingleHighestCredit": "0.00",
                                "SingleHighestSanctionAmount": "83000.00",
                                "TotalHighCredit": "0.00",
                                "AverageOpenBalance": "5524.00",
                                "SingleHighestBalance": "23835.00",
                                "NoOfPastDueAccounts": "0",
                                "NoOfZeroBalanceAccounts": "0",
                                "RecentAccount": "Short Term Personal Loan on 24-03-2026",
                                "OldestAccount": "Two-Wheeler Loan on 29-08-2024",
                                "TotalBalanceAmount": "71812.00",
                                "TotalSanctionAmount": "156500.00",
                                "TotalCreditLimit": "0.0",
                                "TotalMonthlyPaymentAmount": "6347.00",
                                "TotalWrittenOffAmount": "0.00",
                                "MaxDaysPastDue": "0",
                                "NumberOfLoansWithReportedEMI": "4",
                                "NoOfDelinquentAccounts": "0",
                                "TotalOutstandingDelinquentAccounts": "0",
                                "TotalOutstandingUnsecured": "47977"
                    },
                    "RetailAccountDetails": [
                        {
                            "seq": "1",
                            "AccountNumber": "**********",
                            "Institution": "FINANCE",
                            "AccountType": "Short Term Personal Loan",
                            "OwnershipType": "Individual",
                            "Balance": "4000",
                            "PastDueAmount": "0",
                            "Open": "Yes",
                            "SanctionAmount": "4000",
                            "DateReported": "2026-03-31",
                            "DateOpened": "2026-03-24",
                            "RepaymentTenure": "6",
                            "TermFrequency": "Monthly",
                            "AccountStatus": "New Account",
                            "DaysPastDue": "0",
                            "source": "INDIVIDUAL",
                            "LoanCategoryType": "Unsecured",
                            "History48Months": [
                                {
                                    "key": "03-26",
                                    "PaymentStatus": "NEW",
                                    "SuitFiledStatus": "*",
                                    "AssetClassificationStatus": "*",
                                    "DaysPastDue": "0"
                                }
                            ]
                        }
                    ]
                }
            }
        ]
    }
}
```


### `equifax_softpull_json_v2`

```json
{
    "InquiryResponseHeader": {
        "ClientID": "",
        "CustRefField": "",
        "ReportOrderNO": "",
        "ProductCode": [
            "CCR"
        ],
        "SuccessCode": "1",
        "Date": "2026-04-08",
        "Time": "10:15:11"
    },
    "Score": [
        {
            "Type": "ERS",
            "Version": "4.0"
        }
    ],
    "CCRResponse": {
        "Status": "1",
        "CIRReportDataLst": [
            {
                "Score": [
                    {
                        "Type": "ERS",
                        "Version": "4.0"
                    }
                ],
                "ReportData": [
                    {
                        "IDAndContactInfo": {
                            "PersonalInfo": {
                                "Name": {
                                    "FullName": "XXXXX",
                                    "FirstName": "XXXXX ",
                                    "MiddleName": "XXXXX "
                                },
                                " AliasName": {},
                                "DateOfBirth": "1991-01-01",
                                "Gender": "Male",
                                "Age": {
                                    "Age": "35"
                                },
                                "PlaceOfBirthInfo": {},
                                "TotalIncome": "25000"
                            },
                            "IdentityInfo": {
                                "PANId": [
                                    {
                                        "seq": "1",
                                        "ReportedDate": "2026-03-31",
                                        "IdNumber": "XXXXX"
                                    }
                                ],
                                "NationalIDCard": [
                                    {
                                        "seq": "1",
                                        "ReportedDate": "2026-03-23",
                                        "IdNumber": "XXXXXXXXXXXX"
                                    }
                                ],
                                "CKYCId": [
                                    {
                                        "seq": "1",
                                        "ReportedDate": "2024-11-30",
                                        "IdNumber": "60055492853835"
                                    }
                                ]
                            },
                            "AddressInfo": [
                                {
                                    "Seq": "1",
                                    "ReportedDate": "2026-03-31",
                                    "Address": "456/10 CHHOTU RAM NAGAR  BAHADURGARH ROHTAK HARYANA 124507",
                                    "State": "HR",
                                    "Postal": "124507",
                                    "Type": "Owns,Permanent"
                                }
                            ],
                            "PhoneInfo": [
                                {
                                    "seq": "1",
                                    "typeCode": "H",
                                    "ReportedDate": "2026-02-07",
                                    "Number": "XXXXX"
                                }
                            ],
                            "EmailAddressInfo": [
                                {
                                    "seq": "1",
                                    "ReportedDate": "2024-11-30",
                                    "EmailAddress": "XXXXX@GMAIL.COM"
                                }
                            ]
                        },
                        "ScoreDetails": [
                            {
                                "Type": "ERS",
                                "Version": "4.0",
                                "Name": "RTL.ERS4.0",
                                "Value": "746",
                                "ScoringElements": [
                                    {
                                        "type": "RES",
                                        "seq": "1",
                                        "code": "600",
                                        "Description": "Recent Credit exposure"
                                    },
                                    {
                                        "type": "RES",
                                        "seq": "2",
                                        "code": "606",
                                        "Description": "Earlier Closed Accounts"
                                    },
                                    {
                                        "type": "RES",
                                        "seq": "3",
                                        "code": "605",
                                        "Description": "Number of Personal Loans"
                                    }
                                ]
                            }
                        ],
                        "Enquiries": [
                            {
                                "seq": "1",
                                "Institution": "FINANCE",
                                "Date": "2025-11-16",
                                "Time": "12:49",
                                "RequestPurpose": "00"
                            }
                        ],
                        "AccountSummary": {
                            "ConsolidateCreditSummary": {
                                "OverAll": {
                                    "NumberOfOpenAccounts": "13",
                                    "NumberOfPastDueAccounts": "0",
                                    "TotalOutstandingBalance": "71812",
                                    "TotalInstallmentAmount": "6347",
                                    "NoOfDelinquentAccounts": "0",
                                    "OutstandingDelinquentAccounts": "0",
                                    "TotalOutstandingUnsecured": "47977"
                                },
                                "Retail": {
                                    "NoOfAccounts": "31",
                                    "NoOfActiveAccounts": "13",
                                    "NoOfWriteOffs": "0",
                                    "TotalPastDue": "0.00",
                                    "MostSevereStatusWithIn24Months": "Non-Delnqt",
                                    "SingleHighestCredit": "0.00",
                                    "SingleHighestSanctionAmount": "83000.00",
                                    "TotalHighCredit": "0.00",
                                    "AverageOpenBalance": "5524.00",
                                    "SingleHighestBalance": "23835.00",
                                    "NoOfPastDueAccounts": "0",
                                    "NoOfZeroBalanceAccounts": "0",
                                    "RecentAccount": "Short Term Personal Loan on 24-03-2026",
                                    "OldestAccount": "Two-Wheeler Loan on 29-08-2024",
                                    "TotalBalanceAmount": "71812.00",
                                    "TotalSanctionAmount": "156500.00",
                                    "TotalCreditLimit": "0.0",
                                    "TotalMonthlyPaymentAmount": "6347.00",
                                    "TotalWrittenOffAmount": "0.00",
                                    "MaxDaysPastDue": "0",
                                    "NumberOfLoansWithReportedEMI": "4",
                                    "NoOfDelinquentAccounts": "0",
                                    "TotalOutstandingDelinquentAccounts": "0",
                                    "TotalOutstandingUnsecured": "47977"
                                }
                            }
                        },
                        "Accounts": {
                            "RetailAccountDetails": [
                                {
                                    "seq": "1",
                                    "AccountNumber": "**********",
                                    "Institution": "FINANCE",
                                    "AccountType": "Short Term Personal Loan",
                                    "OwnershipType": "Individual",
                                    "Balance": "4000",
                                    "PastDueAmount": "0",
                                    "Open": "Yes",
                                    "SanctionAmount": "4000",
                                    "DateReported": "2026-03-31",
                                    "DateOpened": "2026-03-24",
                                    "RepaymentTenure": "6",
                                    "TermFrequency": "Monthly",
                                    "AccountStatus": "New Account",
                                    "DaysPastDue": "0",
                                    "source": "INDIVIDUAL",
                                    "LoanCategoryType": "Unsecured",
                                    "History48Months": [
                                        {
                                            "key": "03-26",
                                            "PaymentStatus": "NEW",
                                            "SuitFiledStatus": "*",
                                            "AssetClassificationStatus": "*",
                                            "DaysPastDue": "0"
                                        }
                                    ]
                                }
                            ]
                        }
                    }
                ]
            }
        ]
    }
}
```


### `equifax_hardpull_json`

```json
{
    "CIRReportData": {
        "AccountSummary": {
            "AccountsSummary": {
                "TotalSanctionAmount": 471039,
                "NoOfPastDueAccounts": 3,
                "TotalCreditLimit": 53000,
                "NoOfActiveAccounts": 15,
                "TotalHighCredit": 75469,
                "RecentAccount": "Personal Loan on 24-03-2026",
                "MostSevereStatusWithIn24Months": "01+",
                "OldestAccount": "Personal Loan on 07-03-2018",
                "SingleHighestSanctionAmount": 153406,
                "NoOfAccounts": 209,
                "NoOfWriteOffs": 1,
                "SingleHighestCredit": 75469,
                "AverageOpenBalance": 20752.2,
                "TotalPastDue": 5033,
                "NoOfZeroBalanceAccounts": 3,
                "TotalMonthlyPaymentAmount": 37501,
                "TotalBalanceAmount": 311283,
                "SingleHighestBalance": 95904
            }
        },
        "ScoreDetails": {
            "ScoreDetail": {
                "Type": "ERS",
                "Version": 4,
                "ScoringElements": {
                    "ScoringElement": [
                        {
                            "Description": "Recent Credit exposure",
                            "type": "RES",
                            "Code": 600,
                            "seq": 1
                        },
                        {
                            "Description": "Overdue Amount",
                            "type": "RES",
                            "Code": 601,
                            "seq": 2
                        },
                        {
                            "Description": "Number of Personal Loans",
                            "type": "RES",
                            "Code": 605,
                            "seq": 3
                        }
                    ]
                },
                "Value": 715,
                "Name": "ERS4.0"
            }
        },
        "IDAndContactInfo": {
            "EmailAddressInfo": {
                "ReportedDate": "2026-03-31",
                "seq": 1,
                "EmailAddress": "XXXXX@GMAIL.COM"
            },
            "PersonalInfo": {
                "DateOfBirth": "1986-08-14",
                "Occupation": "",
                "Gender": "Male",
                "TotalIncome": 71710,
                "Age": {
                    "Age": 39
                },
                "Name": {
                    "FullName": "XXXXX"
                }
            },
            "IdentityInfo": {
                "NationalIDCard": {
                    "ReportedDate": "2022-07-31",
                    "IdNumber": "XXXXXXXXXXXX",
                    "seq": 1
                },
                "IDOther": {
                    "ReportedDate": "2026-01-15",
                    "IdNumber": 000000,
                    "seq": 1
                },
                "PANId": {
                    "ReportedDate": "2026-03-31",
                    "IdNumber": "XXXXX",
                    "seq": 1
                }
            },
            "PhoneInfo": [
                {
                    "ReportedDate": "2026-02-15",
                    "Number": 000000,
                    "seq": 1,
                    "typeCode": "H"
                }
            ],
            "AddressInfo": [
                {
                    "Type": "Permanent",
                    "ReportedDate": "2026-03-31",
                    "Address": "DEWAS NAKA MADHYA PRADESH 452001",
                    "State": "MP",
                    "seq": 1,
                    "Postal": 452001
                }
            ]
        },
        "Enquiries": [
            {
                "Amount": 100000,
                "Time": "15:54",
                "Institution": "FINANCE",
                "seq": 1,
                "Date": "2026-02-07",
                "RequestPurpose": "05"
            }
        ],
        "OtherKeyInd": {
            "AgeOfOldestTrade": 97,
            "AllLinesEVERWrittenIn6Months": 0,
            "NumberOfOpenTrades": 15,
            "AllLinesEVERWritten": 0.48,
            "AllLinesEVERWrittenIn9Months": 1
        },
        "EnquirySummary": {
            "Recent": "07-02-2026",
            "Past30Days": 0,
            "Total": 20,
            "Past12Months": 2,
            "Past24Months": 4,
            "Purpose": "ALL"
        },
        "RecentActivities": {
            "TotalInquiries": 1,
            "AccountsOpened": 9,
            "AccountsDeliquent": 3,
            "AccountsUpdated": 22
        },
        "AccountDetails": {
            "Account": [
                {
                    "OwnershipType": "Individual",
                    "DateOpened": "2026-03-24",
                    "ReportedDate": "2026-04-15",
                    "DateReported": "2026-04-15",
                    "TermFrequency": "",
                    "History48Months": {
                        "Month": [
                            {
                                "SuitFiledStatus": "*",
                                "AssetClassificationStatus": "*",
                                "key": "04-26",
                                "PaymentStatus": "NEW"
                            },
                            {
                                "SuitFiledStatus": "*",
                                "AssetClassificationStatus": "*",
                                "key": "03-26",
                                "PaymentStatus": "NEW"
                            }
                        ]
                    },
                    "RepaymentTenure": "",
                    "PastDueAmount": 0,
                    "DisputeCode": "",
                    "Institution": "FINANCE",
                    "AccountType": "Personal Loan",
                    "CollateralType": "",
                    "Reason": "",
                    "AccountNumber": "**********",
                    "Open": "Yes",
                    "CollateralValue": "",
                    "AccountStatus": "New Account",
                    "SuitFiledStatus": "",
                    "SanctionAmount": 10000,
                    "AssetClassification": "",
                    "InterestRate": "",
                    "Balance": 14364,
                    "seq": 2
                }
            ]
        }
    },
    "InquiryResponseHeader": {
        "ReportOrderNO": 2582532570,
        "HitCode": 11,
        "ProductCode": "PCS",
        "CustomerCode": "",
        "ClientID": "",
        "CustRefField": 000000,
        "SuccessCode": 1,
        "Time": "15:21:14",
        "Date": "21-04-2026"
    },
    "Scores": {
        "Score": {
            "Type": "ERS",
            "Version": 3.1,
            "seq": 1
        }
    },
    "InquiryRequestInfo": {
        "InquiryPurpose": "05",
        "AddrLine1": "338 gulab bagh",
        "FirstName": "XXXXXX",
        "MobilePhone": 0000000,
        "TransactionAmount": 67000,
        "State": "MP",
        "DOB": "1986-08-01",
        "FullName": "XXXXXX",
        "LastName": "XXXXXX",
        "InquiryPhones": {
            "InquiryPhone": {
                "Number": 00000000,
                "PhoneType": "M",
                "seq": 1
            }
        },
        "Postal": 452010,
        "InquiryAddresses": {
            "InquiryAddress": {
                "AddressLine": "338 gulab bagh",
                "State": "MP",
                "seq": 1,
                "Postal": 452010
            }
        },
        "PANId": "XXXXXX"
    }
}
```


### `equifax_scrub_parser`

The scrub format expects 4 DataFrame tables — tradelines, histories, enquiries, and scores. The column descriptions for each are mentioned below.

`mobile_hash` is the unique identifier of the customer, and `acct_uniq_id` is the unique loan identifier for the customer. Both the **tradelines** and **histories** tables must include these columns.

#### Tradelines

| Column | Description |
|---|---|
| `mobile_hash` | Unique identifier of the customer |
| `acct_uniq_id` | Unique loan identifier for the customer |
| `acct_number` | Account reference id of the loan account |
| `accountstatus` | Current status of the account (e.g. New Account, Closed) |
| `accounttype` | Type of loan account (e.g. Personal Loan, Credit Card) |
| `assetclassification` | Asset classification status for the account |
| `balance` | Current outstanding balance on the account |
| `sanctionamount` | Original sanctioned or approved loan amount |
| `collateraltype` | Type of collateral securing the account, if any |
| `collateralvalue` | Value of the collateral, if applicable |
| `creditlimit` | Credit limit on the account (for revolving credit) |
| `dateclosed` | The date on which the account was closed |
| `dateopened` | The date on which the account was opened |
| `datereported` | The date on which the account was last reported to the bureau |
| `highcredit` | Highest credit amount utilized or sanctioned on the account |
| `cash_limit` | Cash withdrawal limit on the account |
| `settlement_amt` | Settlement amount, if the account was settled |
| `installmentamount` | EMI or installment amount on the account |
| `interestrate` | Rate of interest on the account |
| `lastpayment` | Amount of the last payment made |
| `lastpaymentdate` | Date of the last payment made |
| `ownershiptype` | Ownership type of the account (e.g. Individual, Joint) |
| `pastdueamount` | Amount currently past due on the account |
| `repaymenttenure` | Repayment tenure in months |
| `terms_frequency` | Frequency of payment terms (e.g. Monthly) |
| `suitfiledstatus` | Suit filed status on the account |
| `writeoffamount` | Written-off amount on the account |
| `sector` | Lending sector or institution category |

#### Histories

| Column | Description |
|---|---|
| `mobile_hash` | Unique identifier of the customer |
| `acct_uniq_id` | Unique loan identifier for the customer |
| `pastdueamount` | Past due amount for the history period |
| `accounttype` | Type of loan account |
| `days_past_due` | Number of days past due for the history period |

#### Enquiries

| Column | Description |
|---|---|
| `mobile_hash` | Unique identifier of the customer |
| `inquiry_purpose` | Purpose of the loan inquiry |
| `m_sub_id` | Subscriber or member identifier of the inquiring institution |
| `amount` | Amount for which the inquiry was made |
| `inq_date` | Date of the inquiry |

#### Scores

| Column | Description |
|---|---|
| `mobile_hash` | Unique identifier of the customer |
| `score` | Bureau credit score of the customer |

#### Sample Values

The sample values below illustrate the expected data types and formats for each table. Use these as a reference when preparing scrub data for the parser.

#### Tradelines

<div markdown="0">
<table>
<thead>
<tr><th>Column</th><th>Sample Value</th></tr>
</thead>
<tbody>
    <tr><th><code>mobile_hash</code></th><td>1521168</td></tr>
    <tr><th><code>acct_uniq_id</code></th><td>2129487187</td></tr>
    <tr><th><code>acct_number</code></th><td>12564351</td></tr>
    <tr><th><code>accountstatus</code></th><td>Closed Account</td></tr>
    <tr><th><code>accounttype</code></th><td>Personal Loan</td></tr>
    <tr><th><code>assetclassification</code></th><td>NaN</td></tr>
    <tr><th><code>balance</code></th><td>0</td></tr>
    <tr><th><code>sanctionamount</code></th><td>1200000</td></tr>
    <tr><th><code>collateraltype</code></th><td>NaN</td></tr>
    <tr><th><code>collateralvalue</code></th><td>0</td></tr>
    <tr><th><code>creditlimit</code></th><td>0</td></tr>
    <tr><th><code>dateclosed</code></th><td>22-01-2022</td></tr>
    <tr><th><code>dateopened</code></th><td>08-11-2021</td></tr>
    <tr><th><code>datereported</code></th><td>31-03-2022</td></tr>
    <tr><th><code>highcredit</code></th><td>1200000</td></tr>
    <tr><th><code>cash_limit</code></th><td>NaN</td></tr>
    <tr><th><code>settlement_amt</code></th><td>NaN</td></tr>
    <tr><th><code>installmentamount</code></th><td>0</td></tr>
    <tr><th><code>interestrate</code></th><td>1.0</td></tr>
    <tr><th><code>lastpayment</code></th><td>0</td></tr>
    <tr><th><code>lastpaymentdate</code></th><td>22-01-2022</td></tr>
    <tr><th><code>ownershiptype</code></th><td>Individual</td></tr>
    <tr><th><code>pastdueamount</code></th><td>0</td></tr>
    <tr><th><code>repaymenttenure</code></th><td>1200000.0</td></tr>
    <tr><th><code>termsfrequency</code></th><td>Monthly</td></tr>
    <tr><th><code>suitfiledstatus</code></th><td>NaN</td></tr>
    <tr><th><code>writeoffamount</code></th><td>0</td></tr>
    <tr><th><code>sector</code></th><td>NBFC</td></tr>
</tbody>
</table>
</div>

The following are the expected values for `accounttype`:

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

The following are the expected values for `terms_frequency`:

1. Fortnightly
2. Monthly
3. Quarterly
4. Weekly

The following are the expected values for `collateraltype`:

1. Gold
2. No Collateral
3. Property
4. Saving Account and Fixed Deposit
5. Shares

The following are the expected values for `suitfiledstatus`:

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

#### Histories

<div markdown="0">
<table>
<thead>
<tr><th>Column</th><th>Sample Value</th></tr>
</thead>
<tbody>
    <tr><th><code>mobile_hash</code></th><td>1521168</td></tr>
    <tr><th><code>acct_uniq_id</code></th><td>2129487187</td></tr>
    <tr><th><code>pastdueamount</code></th><td>4200</td></tr>
    <tr><th><code>accounttype</code></th><td>Personal Loan</td></tr>
    <tr><th><code>days_past_due</code></th><td>18</td></tr>
</tbody>
</table>
</div>

#### Enquiries

<div markdown="0">
<table>
<thead>
<tr><th>Column</th><th>Sample Value</th></tr>
</thead>
<tbody>
    <tr><th><code>mobile_hash</code></th><td>1521168</td></tr>
    <tr><th><code>inquiry_purpose</code></th><td>Personal Loan</td></tr>
    <tr><th><code>m_sub_id</code></th><td>NBFC</td></tr>
    <tr><th><code>amount</code></th><td>500000</td></tr>
    <tr><th><code>inq_date</code></th><td>12-10-2021</td></tr>
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
    <tr><th><code>mobile_hash</code></th><td>1521168</td></tr>
    <tr><th><code>score</code></th><td>628</td></tr>
</tbody>
</table>
</div>