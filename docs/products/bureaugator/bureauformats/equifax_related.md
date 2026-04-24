# Equifax Bureau Formats

Equifax provides credit reports in JSON format with comprehensive consumer credit information. The response structure includes personal details, account summaries, credit scores (ERS - Equifax Risk Score), account details with payment history, and inquiry information. Equifax reports typically feature detailed account-level data with monthly payment status tracking and risk assessment elements.

### `equifax_softpull_json`

```json
{
    "InquiryResponse": {
        "xmlns": "http://services.equifax.com/eport/ws/schemas/1.0",
        "ReportData": {
            "AccountSummary": {
                "AccountsSummary": {
                    "TotalSanctionAmount": 40000,
                    "NoOfPastDueAccounts": 2,
                    "TotalCreditLimit": 0,
                    "NoOfActiveAccounts": 2,
                    "TotalHighCredit": 0,
                    "RecentAccount": "Personal Loan on 10-12-2025",
                    "MostSevereStatusWithIn24Months": "WOF",
                    "OldestAccount": "Personal Loan on 08-03-2020",
                    "SingleHighestSanctionAmount": 38000,
                    "NoOfAccounts": 16,
                    "NoOfWriteOffs": 1,
                    "SingleHighestCredit": 0,
                    "AverageOpenBalance": 15728.5,
                    "TotalPastDue": 11482,
                    "NoOfZeroBalanceAccounts": 0,
                    "TotalMonthlyPaymentAmount": 3799,
                    "TotalBalanceAmount": 31457,
                    "SingleHighestBalance": 29457
                }
            },
            "ScoreDetails": {
                "ScoreDetail": {
                    "Type": "ERS",
                    "Version": 4,
                    "ScoringElements": {
                        "ScoringElement": [
                            {
                                "Description": "Occurances of default account",
                                "type": "RES",
                                "Code": 400,
                                "seq": 1
                            },
                            {
                                "Description": "Overdue Amount",
                                "type": "RES",
                                "Code": 402,
                                "seq": 2
                            },
                            {
                                "Description": "Vintage in Bureau",
                                "type": "RES",
                                "Code": 401,
                                "seq": 3
                            }
                        ]
                    },
                    "Value": 530,
                    "Name": "ERS4.0"
                }
            },
            "IDAndContactInfo": {
                "EmailAddressInfo": {
                    "ReportedDate": "2025-06-30",
                    "seq": 1,
                    "EmailAddress": "XXXXX@GMAIL.COM"
                },
                "PersonalInfo": {
                    "DateOfBirth": "1998-08-12",
                    "Occupation": "",
                    "Gender": "Male",
                    "TotalIncome": 60000,
                    "Age": {
                        "Age": 27
                    },
                    "Name": {
                        "FullName": "XXXXX"
                    }
                },
                "IdentityInfo": {
                    "IDOther": {
                        "ReportedDate": "2023-11-30",
                        "IdNumber": XXXXX,
                        "seq": 2
                    },
                    "PANId": {
                        "ReportedDate": "2025-12-18",
                        "IdNumber": "XXXXX",
                        "seq": 1
                    }
                },
                "PhoneInfo": [
                    {
                        "ReportedDate": "2025-12-18",
                        "Number": XXXXX,
                        "seq": 1,
                        "typeCode": "H"
                    }
                ],
                "AddressInfo": [
                    {
                        "Type": "Rents,Primary",
                        "ReportedDate": "2025-06-30",
                        "Address": "DO NO 5 29 96/2 THULLURU GUNTUR ANDHRA PRADESH GUNTUR ANDHRA PRADESH",
                        "State": "AP",
                        "seq": 1,
                        "Postal": 522237
                    }
                ]
            },
            "OtherKeyInd": {
                "AgeOfOldestTrade": 73,
                "AllLinesEVERWrittenIn6Months": 1,
                "NumberOfOpenTrades": 2,
                "AllLinesEVERWritten": 6.25,
                "AllLinesEVERWrittenIn9Months": 0
            },
            "EnquirySummary": {
                "Recent": "18-12-2023",
                "Past30Days": 0,
                "Total": 4,
                "Past12Months": 0,
                "Past24Months": 0,
                "Purpose": "ALL"
            },
            "RecentActivities": {
                "TotalInquiries": 0,
                "AccountsOpened": 0,
                "AccountsDeliquent": 2,
                "AccountsUpdated": 2
            },
            "Disclaimer": "The entire information contained in this report is furnished by various Credit Institutions/members (\"Members\"), which is neither controlled nor subjected to any alteration by Equifax Credit Information Services Private Limited (ECIS). ECIS by using its proprietary search match logic tools, in compliance with the CIC Laws has collated the information and has generated this report. ECIS provides this report on a best effort basis and does not guarantee the timelines, correctness or completeness of the information contained therein. The use of this report will be governed by the terms and conditions accepted by You or as per Membership Agreement entered by the Member with ECIS. Lending decisions are taken by Members/Credit Institutions who access these reports and may differ from Member to Member. ECIS doesn’t tell a lender whether they should offer credit or not to its customer/borrower– it is solely for the lender to decide.",
            "AccountDetails": {
                "Account": [
                    {
                        "OwnershipType": "Individual",
                        "ReportedDate": "2026-04-18",
                        "DateReported": "2026-04-18",
                        "TermFrequency": "Monthly",
                        "History48Months": {
                            "Month": [
                                {
                                    "SuitFiledStatus": "*",
                                    "AssetClassificationStatus": "*",
                                    "key": "04-26",
                                    "PaymentStatus": "01+"
                                },
                                {
                                    "SuitFiledStatus": "*",
                                    "AssetClassificationStatus": "*",
                                    "key": "03-26",
                                    "PaymentStatus": "01+"
                                },
                                {
                                    "SuitFiledStatus": "*",
                                    "AssetClassificationStatus": "*",
                                    "key": "02-26",
                                    "PaymentStatus": "01+"
                                },
                                {
                                    "SuitFiledStatus": "*",
                                    "AssetClassificationStatus": "*",
                                    "key": "01-26",
                                    "PaymentStatus": "000"
                                },
                                {
                                    "SuitFiledStatus": "*",
                                    "AssetClassificationStatus": "*",
                                    "key": "12-25",
                                    "PaymentStatus": "NEW"
                                }
                            ]
                        },
                        "PastDueAmount": 4897,
                        "DisputeCode": "",
                        "Institution": "FINANCE",
                        "Reason": "",
                        "Open": "Yes",
                        "AccountStatus": "1-29 days past due",
                        "InterestRate": "",
                        "seq": 1,
                        "DateOpened": "2025-12-10",
                        "LastPayment": 3799,
                        "LastPaymentDate": "2026-04-04",
                        "RepaymentTenure": 12,
                        "InstallmentAmount": 3799,
                        "AccountType": "Personal Loan",
                        "CollateralType": "",
                        "AccountNumber": "**********",
                        "CollateralValue": "",
                        "SuitFiledStatus": "",
                        "SanctionAmount": 38000,
                        "AssetClassification": "",
                        "Balance": 29457
                    }
                ]
            }
        },
        "InquiryResponseHeader": {
            "ReportOrderNO": 2581479754,
            "HitCode": 10,
            "ProductCode": "PCS",
            "CustomerCode": "",
            "ClientID": "",
            "CustRefField": XXXXX,
            "SuccessCode": 1,
            "Time": "06:01:13",
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
            "AddrLine1": "5 29 96 2 THULLURU GUNTUR 44 ANDHRA PRADESH",
            "FirstName": "XXXXX",
            "MobilePhone": XXXXX,
            "TransactionAmount": 25000,
            "State": "AP",
            "DOB": "1998-08-12",
            "FullName": "XXXXX",
            "LastName": "XXXXX",
            "InquiryPhones": {
                "InquiryPhone": {
                    "Number": XXXXX,
                    "PhoneType": "M",
                    "seq": 1
                }
            },
            "Postal": 522237,
            "InquiryAddresses": {
                "InquiryAddress": {
                    "AddressLine": "5 29 96 2 THULLURU GUNTUR 44 ANDHRA PRADESH",
                    "State": "AP",
                    "seq": 1,
                    "Postal": 522237
                }
            },
            "PANId": "XXXXX"
        }
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