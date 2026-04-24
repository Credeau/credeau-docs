# CRIF Bureau Formats

CRIF provides credit reports through multiple JSON format variations including CIR (Credit Information Report) and INDV (Individual) report structures. The reports feature detailed tradeline information, demographic variations, employment details, and PERFORM Consumer scores. CRIF formats emphasize comprehensive account history tracking, inquiry patterns, and risk factor analysis with detailed payment behavior insights.

### `crif_hardpull`

```json
{
    "CIR-REPORT-FILE": {
        "HEADER-SEGMENT": {
            "DATE-OF-REQUEST": "18-04-2026",
            "PREPARED-FOR": "",
            "PREPARED-FOR-ID": "",
            "DATE-OF-ISSUE": "18-04-2026",
            "REPORT-ID": "SUBU260418CR008076633",
            "BATCH-ID": "4524965640260418",
            "STATUS": "SUCCESS",
            "PRODUCT-TYPE": "CIR PRO V2",
            "PRODUCT-VER": "2.0"
        },
        "REQUEST-DATA": {
            "APPLICANT-SEGMENT": {
                "FIRST-NAME": "",
                "MIDDLE-NAME": "",
                "LAST-NAME": "",
                "GENDER": "",
                "APPLICANT-ID": "3197476",
                "DOB": {
                    "DOB-DT": "10-12-1992",
                    "AGE": "33",
                    "AGE-AS-ON": "18-04-2026"
                },
                "IDS": [
                    {
                        "TYPE": "ID07",
                        "VALUE": ""
                    }
                ],
                "ADDRESSES": [
                    {
                        "TYPE": "D05",
                        "ADDRESSTEXT": "Mohali Punjab ",
                        "CITY": "Mohali",
                        "LOCALITY": "",
                        "STATE": "PB",
                        "PIN": "140308",
                        "COUNTRY": "INDIA"
                    }
                ],
                "PHONES": [
                    {
                        "TYPE": "P04",
                        "VALUE": ""
                    }
                ],
                "EMAILS": [
                    {
                        "EMAIL": null
                    }
                ],
                "ACCOUNT-NUMBER": ""
            },
            "APPLICATION-SEGMENT": {
                "INQUIRY-UNIQUE-REF-NO": "",
                "CREDIT-RPT-ID": "",
                "CREDIT-RPT-TRN-DT-TM": "",
                "CREDIT-INQ-PURPS-TYPE": "",
                "CREDIT-INQUIRY-STAGE": "",
                "CLIENT-CONTRIBUTOR-ID": "",
                "BRANCH-ID": "",
                "APPLICATION-ID": "",
                "ACNT-OPEN-DT": "",
                "LOAN-AMT": null,
                "LTV": "12",
                "TERM": "24",
                "LOAN-TYPE": "A01"
            }
        },
        "REQUEST-STATUS": [
            {
                "TYPE": "CIR",
                "STATUS": "SUCCESS",
                "ERRORS": []
            },
            {
                "TYPE": "IOI",
                "STATUS": "SUCCESS",
                "ERRORS": []
            },
            {
                "TYPE": "IOI",
                "STATUS": "SUCCESS",
                "ERRORS": []
            }
        ],
        "REPORT-DATA": {
            "STANDARD-DATA": {
                "DEMOGS": {
                    "VARIATIONS": [
                        {
                            "TYPE": "EMAIL-VARIATIONS",
                            "VARIATION": [
                                {
                                    "VALUE": "SOMEONE@GMAIL.COM",
                                    "REPORTED-DT": "15-04-2026",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "DOB-VARIATIONS",
                            "VARIATION": [
                                {
                                    "VALUE": "04-08-1982",
                                    "REPORTED-DT": "30-04-2023",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "UID-VARIATIONS",
                            "VARIATION": [
                                {
                                    "type": "UID",
                                    "VALUE": "",
                                    "REPORTED-DT": "28-02-2026",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "ADDRESS-VARIATIONS",
                            "VARIATION": [
                                {
                                    "VALUE": "LOWER TASHIDING BUSTY KALIMPONG DARJEELING WEST BENGAL 734301 734301 WB ",
                                    "REPORTED-DT": "07-04-2026",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "PHONE-VARIATIONS",
                            "VARIATION": [
                                {
                                    "VALUE": "0000000000",
                                    "REPORTED-DT": "31-10-2023",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "CKYC-VARIATIONS",
                            "VARIATION": [
                                {
                                    "type": "CKYC",
                                    "VALUE": "",
                                    "REPORTED-DT": "31-03-2026",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "PAN-VARIATIONS",
                            "VARIATION": [
                                {
                                    "type": "PAN",
                                    "VALUE": "",
                                    "REPORTED-DT": "15-04-2026",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "NAME-VARIATIONS",
                            "VARIATION": [
                                {
                                    "VALUE": "PRADHAN SAGE BHUSHAN",
                                    "REPORTED-DT": "18-09-2025",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        }
                    ]
                },
                "EMPLOYMENT-DETAILS": [
                    {
                        "EMPLOYMENT-DETAIL": {
                            "OCCUPATION": "SALARIED",
                            "FIRST-REPORTED-DT": "28-02-2026",
                            "LAST-REPORTED-DT": "31-03-2026",
                            "ACCT-TYPE": "Personal Loan",
                            "SOURCE-INDICATOR": "NBF"
                        }
                    }
                ],
                "TRADELINES": [
                    {
                        "ACCT-NUMBER": "XXXX",
                        "CREDIT-GRANTOR": "XXXX",
                        "CREDIT-GRANTOR-GROUP": "Category D",
                        "CREDIT-GRANTOR-TYPE": "NBF",
                        "ACCT-TYPE": "PERSONAL LOAN",
                        "REPORTED-DT": "15-04-2026",
                        "OWNERSHIP-TYPE": "Individual",
                        "ACCOUNT-STATUS": "Active",
                        "CLOSED-DT": "",
                        "DISBURSED-AMT": "3000",
                        "DISBURSED-DT": "08-04-2026",
                        "INSTALLMENT-AMT": "",
                        "CREDIT-LIMIT": "",
                        "CASH-LIMIT": "",
                        "CURRENT-BAL": "4,488",
                        "INSTALLMENT-FREQUENCY": "",
                        "ORIGINAL-TERM": 0,
                        "TERM-TO-MATURITY": 0,
                        "REPAYMENT-TENURE": "",
                        "INTEREST-RATE": "",
                        "ACTUAL-PAYMENT": "",
                        "LAST-PAYMENT-DT": "",
                        "OVERDUE-AMT": "0",
                        "WRITE-OFF-AMT": "0",
                        "PRINCIPAL-WRITE-OFF-AMT": "",
                        "SETTLEMENT-AMT": "",
                        "OBLIGATION": "82.7338585544662",
                        "HISTORY": [
                            {
                                "NAME": "COMBINED-PAYMENT-HISTORY",
                                "DATES": "Apr:2026|",
                                "VALUES": "000/XXX|"
                            }
                        ],
                        "ACCOUNT-REMARKS": null,
                        "SECURITY-STATUS": "Un-Secured",
                        "ACCT-IN-DISPUTE": "",
                        "SUIT-FILED-WILFUL-DEFAULT-STATUS": "",
                        "WRITTEN-OFF-SETTLED-STATUS": "",
                        "WRITE-OFF-DT": "",
                        "SECURITY-DETAILS": [
                            {
                                "SECURITY-TYPE": "",
                                "OWNER-NAME": "",
                                "SECURITY-VALUATION": "",
                                "DATE-OF-VALUATION": "",
                                "SECURITY-CHARGE": "",
                                "PROPERTY-ADDRESS": "",
                                "AUTOMOBILE-TYPE": "",
                                "YEAR-OF-MANUFACTURING": "",
                                "REGISTRATION-NUMBER": "",
                                "ENGINE-NUMBER": "",
                                "CHASSIE-NUMBER": ""
                            }
                        ],
                        "LINKED-ACCOUNTS": [],
                        "SUIT-FILED-DT": "",
                        "LAST-PAID-AMOUNT": "",
                        "OCCUPATION": "",
                        "INCOME-FREQUENCY": "",
                        "INCOME-AMOUNT": ""
                    }
                ],
                "INQUIRY-HISTORY": [
                    {
                        "LENDER-NAME": "XXXX",
                        "LENDER-TYPE": "NBF",
                        "INQUIRY-DT": "08-04-2026",
                        "OWNERSHIP-TYPE": "PRIMARY",
                        "CREDIT-INQ-PURPS-TYPE": "Account Origination",
                        "CREDIT-INQUIRY-STAGE": "PRE-DISB",
                        "AMOUNT": "30,000",
                        "REMARK": "",
                        "LOAN-TYPE": "OTHER"
                    }
                ],
                "SCORE": [
                    {
                        "NAME": "PERFORM CONSUMER 2.2",
                        "VERSION": "",
                        "VALUE": "652",
                        "DESCRIPTION": "",
                        "FACTORS": [
                            {
                                "TYPE": "SF03",
                                "DESC": "No/minimal missed payments in recent past"
                            },
                            {
                                "TYPE": "SF12",
                                "DESC": "Substantial proportion of outstanding balance to disbursed amount"
                            },
                            {
                                "TYPE": "SF32",
                                "DESC": "Considerably high number of self/overall loans disbursed in the recent past"
                            }
                        ]
                    }
                ]
            },
            "REQUESTED-SERVICES": [],
            "ACCOUNTS-SUMMARY": {
                "PRIMARY-ACCOUNTS-SUMMARY": {
                    "NUMBER-OF-ACCOUNTS": "207",
                    "ACTIVE-ACCOUNTS": "26",
                    "OVERDUE-ACCOUNTS": "0",
                    "SECURED-ACCOUNTS": "0",
                    "UNSECURED-ACCOUNTS": "207",
                    "UNTAGGED-ACCOUNTS": "0",
                    "TOTAL-CURRENT-BALANCE": "491362.00",
                    "CURRENT-BALANCE-SECURED": "0.00",
                    "CURRENT-BALANCE-UNSECURED": "491362.00",
                    "TOTAL-SANCTIONED-AMT": "573000.00",
                    "TOTAL-DISBURSED-AMT": "573000.00",
                    "TOTAL-AMT-OVERDUE": "0.00"
                },
                "SECONDARY-ACCOUNTS-SUMMARY": {
                    "NUMBER-OF-ACCOUNTS": "0",
                    "ACTIVE-ACCOUNTS": "0",
                    "OVERDUE-ACCOUNTS": "0",
                    "SECURED-ACCOUNTS": "0",
                    "UNSECURED-ACCOUNTS": "0",
                    "UNTAGGED-ACCOUNTS": "0",
                    "TOTAL-CURRENT-BALANCE": "0.00",
                    "TOTAL-SANCTIONED-AMT": "0.00",
                    "TOTAL-DISBURSED-AMT": "0.00",
                    "TOTAL-AMT-OVERDUE": "0.00"
                },
                "MFI-GROUP-ACCOUNTS-SUMMARY": {
                    "NUMBER-OF-ACCOUNTS": "0",
                    "ACTIVE-ACCOUNTS": "0",
                    "OVERDUE-ACCOUNTS": "0",
                    "CLOSED-ACCOUNTS": "0",
                    "NO-OF-OTHER-MFIS": "0",
                    "NO-OF-OWN-MFIS": "0",
                    "TOTAL-OWN-CURRENT-BALANCE": "0.00",
                    "TOTAL-OWN-INSTALLMENT-AMT": "0",
                    "TOTAL-OWN-DISBURSED-AMT": "0.00",
                    "TOTAL-OWN-OVERDUE-AMT": "0.00",
                    "TOTAL-OTHER-CURRENT-BALANCE": "0.00",
                    "TOTAL-OTHER-INSTALLMENT-AMT": "0",
                    "TOTAL-OTHER-DISBURSED-AMT": "0.00",
                    "TOTAL-OTHER-OVERDUE-AMT": "0.00",
                    "MAX-WORST-DELINQUENCY": "0"
                },
                "ADDITIONAL-SUMMARY": [
                    {
                        "ATTR-NAME": "NUM-GRANTORS",
                        "ATTR-VALUE": "40"
                    },
                    {
                        "ATTR-NAME": "NUM-GRANTORS-ACTIVE",
                        "ATTR-VALUE": "20"
                    },
                    {
                        "ATTR-NAME": "NUM-GRANTORS-DELINQ",
                        "ATTR-VALUE": "0"
                    },
                    {
                        "ATTR-NAME": "NUM-GRANTORS-ONLY-PRIMARY",
                        "ATTR-VALUE": "20"
                    },
                    {
                        "ATTR-NAME": "NUM-GRANTORS-ONLY-SECONDARY",
                        "ATTR-VALUE": "0"
                    }
                ],
                "PERFORM-ATTRIBUTES": []
            },
            "TRENDS": {
                "NAME": "",
                "DATES": "",
                "VALUES": "",
                "RESERVED1": "",
                "RESERVED2": "",
                "RESERVED3": "",
                "DESCRIPTION": ""
            },
            "ALERTS": [
                {
                    "TYPE": "",
                    "DESCRIPTION": "",
                    "RESERVED1": ""
                }
            ]
        },
        "PRINTABLE-REPORT": {}
    }
}
```

### `crif_hardpull_v2`

```json
{
    "CIR-REPORT-FILE": {
        "HEADER-SEGMENT": {
            "DATE-OF-REQUEST": "18-04-2026",
            "PREPARED-FOR": "",
            "PREPARED-FOR-ID": "",
            "DATE-OF-ISSUE": "18-04-2026",
            "REPORT-ID": "SUBU260418CR008076633",
            "BATCH-ID": "4524965640260418",
            "STATUS": "SUCCESS",
            "PRODUCT-TYPE": "CIR PRO V2",
            "PRODUCT-VER": "2.0"
        },
        "REQUEST-DATA": {
            "APPLICANT-SEGMENT": {
                "FIRST-NAME": "",
                "MIDDLE-NAME": "",
                "LAST-NAME": "",
                "GENDER": "",
                "APPLICANT-ID": "3197476",
                "DOB": {
                    "DOB-DT": "10-12-1992",
                    "AGE": "33",
                    "AGE-AS-ON": "18-04-2026"
                },
                "IDS": [
                    {
                        "TYPE": "ID07",
                        "VALUE": ""
                    }
                ],
                "ADDRESSES": [
                    {
                        "TYPE": "D05",
                        "ADDRESSTEXT": "Mohali Punjab ",
                        "CITY": "Mohali",
                        "LOCALITY": "",
                        "STATE": "PB",
                        "PIN": "140308",
                        "COUNTRY": "INDIA"
                    }
                ],
                "PHONES": [
                    {
                        "TYPE": "P04",
                        "VALUE": ""
                    }
                ],
                "EMAILS": [
                    {
                        "EMAIL": null
                    }
                ],
                "ACCOUNT-NUMBER": ""
            },
            "APPLICATION-SEGMENT": {
                "INQUIRY-UNIQUE-REF-NO": "",
                "CREDIT-RPT-ID": "",
                "CREDIT-RPT-TRN-DT-TM": "",
                "CREDIT-INQ-PURPS-TYPE": "",
                "CREDIT-INQUIRY-STAGE": "",
                "CLIENT-CONTRIBUTOR-ID": "",
                "BRANCH-ID": "",
                "APPLICATION-ID": "",
                "ACNT-OPEN-DT": "",
                "LOAN-AMT": null,
                "LTV": "12",
                "TERM": "24",
                "LOAN-TYPE": "A01"
            }
        },
        "REQUEST-STATUS": [
            {
                "TYPE": "CIR",
                "STATUS": "SUCCESS",
                "ERRORS": []
            },
            {
                "TYPE": "IOI",
                "STATUS": "SUCCESS",
                "ERRORS": []
            },
            {
                "TYPE": "IOI",
                "STATUS": "SUCCESS",
                "ERRORS": []
            }
        ],
        "REPORT-DATA": {
            "STANDARD-DATA": {
                "DEMOGS": {
                    "VARIATIONS": [
                        {
                            "TYPE": "EMAIL-VARIATIONS",
                            "VARIATION": [
                                {
                                    "VALUE": "SOMEONE@GMAIL.COM",
                                    "REPORTED-DT": "15-04-2026",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "DOB-VARIATIONS",
                            "VARIATION": [
                                {
                                    "VALUE": "04-08-1982",
                                    "REPORTED-DT": "30-04-2023",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "UID-VARIATIONS",
                            "VARIATION": [
                                {
                                    "type": "UID",
                                    "VALUE": "",
                                    "REPORTED-DT": "28-02-2026",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "ADDRESS-VARIATIONS",
                            "VARIATION": [
                                {
                                    "VALUE": "LOWER TASHIDING BUSTY KALIMPONG DARJEELING WEST BENGAL 734301 734301 WB ",
                                    "REPORTED-DT": "07-04-2026",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "PHONE-VARIATIONS",
                            "VARIATION": [
                                {
                                    "VALUE": "0000000000",
                                    "REPORTED-DT": "31-10-2023",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "CKYC-VARIATIONS",
                            "VARIATION": [
                                {
                                    "type": "CKYC",
                                    "VALUE": "",
                                    "REPORTED-DT": "31-03-2026",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "PAN-VARIATIONS",
                            "VARIATION": [
                                {
                                    "type": "PAN",
                                    "VALUE": "",
                                    "REPORTED-DT": "15-04-2026",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        },
                        {
                            "TYPE": "NAME-VARIATIONS",
                            "VARIATION": [
                                {
                                    "VALUE": "PRADHAN SAGE BHUSHAN",
                                    "REPORTED-DT": "18-09-2025",
                                    "FIRST-REPORTED-DT": null,
                                    "LOAN-TYPE-ASSOC": "",
                                    "SOURCE-INDICATOR": ""
                                }
                            ]
                        }
                    ]
                },
                "EMPLOYMENT-DETAILS": [
                    {
                        "EMPLOYMENT-DETAIL": {
                            "OCCUPATION": "SALARIED",
                            "FIRST-REPORTED-DT": "28-02-2026",
                            "LAST-REPORTED-DT": "31-03-2026",
                            "ACCT-TYPE": "Personal Loan",
                            "SOURCE-INDICATOR": "NBF"
                        }
                    }
                ],
                "TRADELINES": [
                    {
                        "ACCT-NUMBER": "XXXX",
                        "CREDIT-GRANTOR": "XXXX",
                        "CREDIT-GRANTOR-GROUP": "Category D",
                        "CREDIT-GRANTOR-TYPE": "NBF",
                        "ACCT-TYPE": "PERSONAL LOAN",
                        "REPORTED-DT": "15-04-2026",
                        "OWNERSHIP-TYPE": "Individual",
                        "ACCOUNT-STATUS": "Active",
                        "CLOSED-DT": "",
                        "DISBURSED-AMT": "3000",
                        "DISBURSED-DT": "08-04-2026",
                        "INSTALLMENT-AMT": "",
                        "CREDIT-LIMIT": "",
                        "CASH-LIMIT": "",
                        "CURRENT-BAL": "4,488",
                        "INSTALLMENT-FREQUENCY": "",
                        "ORIGINAL-TERM": 0,
                        "TERM-TO-MATURITY": 0,
                        "REPAYMENT-TENURE": "",
                        "INTEREST-RATE": "",
                        "ACTUAL-PAYMENT": "",
                        "LAST-PAYMENT-DT": "",
                        "OVERDUE-AMT": "0",
                        "WRITE-OFF-AMT": "0",
                        "PRINCIPAL-WRITE-OFF-AMT": "",
                        "SETTLEMENT-AMT": "",
                        "OBLIGATION": "82.7338585544662",
                        "HISTORY": [
                            {
                                "DATES": "Mar:2026|Feb:2026|Jan:2026|Dec:2025|Nov:2025|",
                                "NAME": "C**********************Y",
                                "VALUES": "000/STD|000/STD|000/STD|000/STD|000/STD|"
                            },
                            {
                                "DATES": "Mar:2026|Feb:2026|Jan:2026|Dec:2025|Nov:2025|",
                                "NAME": "H*****************Y",
                                "VALUES": "18,999|18,999|18,999|18,999|18,999|"
                            },
                            {
                                "DATES": "Mar:2026|Feb:2026|Jan:2026|Dec:2025|Nov:2025|",
                                "NAME": "C*********************Y",
                                "VALUES": "8,713|11,416|13,955|16,384|18,999|"
                            },
                            {
                                "DATES": "Mar:2026|Feb:2026|Jan:2026|Dec:2025|Nov:2025|",
                                "NAME": "A**************Y",
                                "VALUES": "|||||"
                            }
                        ],
                        "ACCOUNT-REMARKS": null,
                        "SECURITY-STATUS": "Un-Secured",
                        "ACCT-IN-DISPUTE": "",
                        "SUIT-FILED-WILFUL-DEFAULT-STATUS": "",
                        "WRITTEN-OFF-SETTLED-STATUS": "",
                        "WRITE-OFF-DT": "",
                        "SECURITY-DETAILS": [
                            {
                                "SECURITY-TYPE": "",
                                "OWNER-NAME": "",
                                "SECURITY-VALUATION": "",
                                "DATE-OF-VALUATION": "",
                                "SECURITY-CHARGE": "",
                                "PROPERTY-ADDRESS": "",
                                "AUTOMOBILE-TYPE": "",
                                "YEAR-OF-MANUFACTURING": "",
                                "REGISTRATION-NUMBER": "",
                                "ENGINE-NUMBER": "",
                                "CHASSIE-NUMBER": ""
                            }
                        ],
                        "LINKED-ACCOUNTS": [],
                        "SUIT-FILED-DT": "",
                        "LAST-PAID-AMOUNT": "",
                        "OCCUPATION": "",
                        "INCOME-FREQUENCY": "",
                        "INCOME-AMOUNT": ""
                    }
                ],
                "INQUIRY-HISTORY": [
                    {
                        "LENDER-NAME": "XXXX",
                        "LENDER-TYPE": "NBF",
                        "INQUIRY-DT": "08-04-2026",
                        "OWNERSHIP-TYPE": "PRIMARY",
                        "CREDIT-INQ-PURPS-TYPE": "Account Origination",
                        "CREDIT-INQUIRY-STAGE": "PRE-DISB",
                        "AMOUNT": "30,000",
                        "REMARK": "",
                        "LOAN-TYPE": "OTHER"
                    }
                ],
                "SCORE": [
                    {
                        "NAME": "PERFORM CONSUMER 2.2",
                        "VERSION": "",
                        "VALUE": "652",
                        "DESCRIPTION": "",
                        "FACTORS": [
                            {
                                "TYPE": "SF03",
                                "DESC": "No/minimal missed payments in recent past"
                            },
                            {
                                "TYPE": "SF12",
                                "DESC": "Substantial proportion of outstanding balance to disbursed amount"
                            },
                            {
                                "TYPE": "SF32",
                                "DESC": "Considerably high number of self/overall loans disbursed in the recent past"
                            }
                        ]
                    }
                ]
            },
            "REQUESTED-SERVICES": [],
            "ACCOUNTS-SUMMARY": {
                "PRIMARY-ACCOUNTS-SUMMARY": {
                    "NUMBER-OF-ACCOUNTS": "207",
                    "ACTIVE-ACCOUNTS": "26",
                    "OVERDUE-ACCOUNTS": "0",
                    "SECURED-ACCOUNTS": "0",
                    "UNSECURED-ACCOUNTS": "207",
                    "UNTAGGED-ACCOUNTS": "0",
                    "TOTAL-CURRENT-BALANCE": "491362.00",
                    "CURRENT-BALANCE-SECURED": "0.00",
                    "CURRENT-BALANCE-UNSECURED": "491362.00",
                    "TOTAL-SANCTIONED-AMT": "573000.00",
                    "TOTAL-DISBURSED-AMT": "573000.00",
                    "TOTAL-AMT-OVERDUE": "0.00"
                },
                "SECONDARY-ACCOUNTS-SUMMARY": {
                    "NUMBER-OF-ACCOUNTS": "0",
                    "ACTIVE-ACCOUNTS": "0",
                    "OVERDUE-ACCOUNTS": "0",
                    "SECURED-ACCOUNTS": "0",
                    "UNSECURED-ACCOUNTS": "0",
                    "UNTAGGED-ACCOUNTS": "0",
                    "TOTAL-CURRENT-BALANCE": "0.00",
                    "TOTAL-SANCTIONED-AMT": "0.00",
                    "TOTAL-DISBURSED-AMT": "0.00",
                    "TOTAL-AMT-OVERDUE": "0.00"
                },
                "MFI-GROUP-ACCOUNTS-SUMMARY": {
                    "NUMBER-OF-ACCOUNTS": "0",
                    "ACTIVE-ACCOUNTS": "0",
                    "OVERDUE-ACCOUNTS": "0",
                    "CLOSED-ACCOUNTS": "0",
                    "NO-OF-OTHER-MFIS": "0",
                    "NO-OF-OWN-MFIS": "0",
                    "TOTAL-OWN-CURRENT-BALANCE": "0.00",
                    "TOTAL-OWN-INSTALLMENT-AMT": "0",
                    "TOTAL-OWN-DISBURSED-AMT": "0.00",
                    "TOTAL-OWN-OVERDUE-AMT": "0.00",
                    "TOTAL-OTHER-CURRENT-BALANCE": "0.00",
                    "TOTAL-OTHER-INSTALLMENT-AMT": "0",
                    "TOTAL-OTHER-DISBURSED-AMT": "0.00",
                    "TOTAL-OTHER-OVERDUE-AMT": "0.00",
                    "MAX-WORST-DELINQUENCY": "0"
                },
                "ADDITIONAL-SUMMARY": [
                    {
                        "ATTR-NAME": "NUM-GRANTORS",
                        "ATTR-VALUE": "40"
                    },
                    {
                        "ATTR-NAME": "NUM-GRANTORS-ACTIVE",
                        "ATTR-VALUE": "20"
                    },
                    {
                        "ATTR-NAME": "NUM-GRANTORS-DELINQ",
                        "ATTR-VALUE": "0"
                    },
                    {
                        "ATTR-NAME": "NUM-GRANTORS-ONLY-PRIMARY",
                        "ATTR-VALUE": "20"
                    },
                    {
                        "ATTR-NAME": "NUM-GRANTORS-ONLY-SECONDARY",
                        "ATTR-VALUE": "0"
                    }
                ],
                "PERFORM-ATTRIBUTES": []
            },
            "TRENDS": {
                "NAME": "",
                "DATES": "",
                "VALUES": "",
                "RESERVED1": "",
                "RESERVED2": "",
                "RESERVED3": "",
                "DESCRIPTION": ""
            },
            "ALERTS": [
                {
                    "TYPE": "",
                    "DESCRIPTION": "",
                    "RESERVED1": ""
                }
            ]
        },
        "PRINTABLE-REPORT": {}
    }
}
```


### `crif_json`

```json
{
    "cir_report_file": {
        "header_segment": {
            "date_of_request": "19-04-2026",
            "prepared_for": "  ",
            "prepared_for_id": "",
            "date_of_issue": "19-04-2026",
            "report_id": "",
            "batch_id": "",
            "status": "SUCCESS",
            "product_type": "BBC CONSUMER SCORE",
            "product_ver": "2.0"
        },
        "request_data": {
            "applicant_segment": {
                "first_name": "XXX",
                "middle_name": "XXX",
                "last_name": "XXX",
                "gender": "",
                "applicant_id": "",
                "dob": {
                    "dob_dt": "01-01-1900",
                    "age": "",
                    "age_as_on": ""
                },
                "ids": [
                    {
                        "type": "ID07",
                        "value": "XXX"
                    },
                    {
                        "type": "ID03",
                        "value": "XXX"
                    }
                ],
                "addresses": [
                    {
                        "type": "D08",
                        "addresstext": "XXX",
                        "city": "XXX",
                        "locality": "XXX",
                        "state": "Kerala",
                        "pin": "688530",
                        "country": "India"
                    }
                ],
                "phones": [
                    {
                        "type": "P01",
                        "value": "0000000000"
                    }
                ],
                "emails": [
                    {
                        "email": "XXX@XXX.XX"
                    }
                ],
                "account_number": ""
            },
            "application_segment": {
                "inquiry_unique_ref_no": "",
                "credit_rpt_id": "",
                "credit_rpt_trn_dt_tm": "",
                "credit_inq_purps_type": "",
                "credit_inquiry_stage": "",
                "client_contributor_id": "",
                "branch_id": "",
                "application_id": "",
                "acnt_open_dt": "",
                "loan_amt": "",
                "ltv": "",
                "term": "",
                "loan_type": ""
            }
        },
        "report_data": {
            "standard_data": {
                "demogs": {
                    "variations": [
                        {
                            "type": "NAME-VARIATIONS",
                            "variation": [
                                {
                                    "value": "XXX",
                                    "reported_dt": "15-04-2026",
                                    "first_reported_dt": "04-12-2017",
                                    "loan_type_assoc": "Consumer Loan,Personal Loan,Two-Wheeler Loan",
                                    "source_indicator": "PRB,NBF,NBF"
                                }
                            ]
                        },
                        {
                            "type": "PHONE-VARIATIONS",
                            "variation": [
                                {
                                    "value": "0000000000",
                                    "reported_dt": "31-03-2026",
                                    "first_reported_dt": "20-08-2023",
                                    "loan_type_assoc": "Consumer Loan",
                                    "source_indicator": "PRB"
                                }
                            ]
                        },
                        {
                            "type": "ADDRESS-VARIATIONS",
                            "variation": [
                                {
                                    "value": "XXX",
                                    "reported_dt": "31-03-2026",
                                    "first_reported_dt": "20-02-2026",
                                    "loan_type_assoc": "Personal Loan",
                                    "source_indicator": "NBF"
                                }
                            ]
                        },
                        {
                            "type": "DOB-VARIATIONS",
                            "variation": [
                                {
                                    "value": "01-01-1900",
                                    "reported_dt": "15-02-2025",
                                    "first_reported_dt": "21-11-2024",
                                    "loan_type_assoc": "Personal Loan",
                                    "source_indicator": "NBF"
                                }
                            ]
                        },
                        {
                            "type": "PAN-VARIATIONS",
                            "variation": [
                                {
                                    "value": "XXX",
                                    "reported_dt": "30-09-2025",
                                    "first_reported_dt": "20-08-2025",
                                    "loan_type_assoc": "Personal Loan",
                                    "source_indicator": "NBF"
                                }
                            ]
                        },
                        {
                            "type": "EMAIL-VARIATIONS",
                            "variation": [
                                {
                                    "value": "XXX",
                                    "reported_dt": "15-04-2026",
                                    "first_reported_dt": "20-08-2025",
                                    "loan_type_assoc": "Personal Loan",
                                    "source_indicator": "NBF"
                                }
                            ]
                        }
                    ]
                },
                "employment_details": [
                    {
                        "employment_detail": {
                            "occupation": "SELF EMPLOYED",
                            "first_reported_dt": "28-02-2026",
                            "last_reported_dt": "31-03-2026",
                            "acct_type": "Personal Loan",
                            "source_indicator": "NBF"
                        }
                    }
                ],
                "tradelines": [
                    {
                        "acct_number": "FLIPKART-141231934",
                        "credit_grantor": "IDFC",
                        "credit_grantor_group": null,
                        "credit_grantor_type": null,
                        "acct_type": "Consumer Loan",
                        "reported_dt": "31-07-2024",
                        "ownership_type": "Individual",
                        "account_status": "Closed",
                        "closed_dt": "06-07-2024",
                        "disbursed_amt": "3,062",
                        "disbursed_dt": "02-01-2024",
                        "installment_amt": "545/Monthly",
                        "credit_limit": null,
                        "cash_limit": null,
                        "current_bal": "0",
                        "installment_frequency": "Monthly",
                        "original_term": 0,
                        "term_to_maturity": 0,
                        "repayment_tenure": "6",
                        "interest_rate": "0.0",
                        "actual_payment": "3,280",
                        "last_payment_dt": "27-06-2024",
                        "overdue_amt": "0",
                        "write_off_amt": "0",
                        "principal_write_off_amt": null,
                        "settlement_amt": null,
                        "obligation": null,
                        "history": [
                            {
                                "name": "COMBINED-PAYMENT-HISTORY",
                                "dates": "Jul:2024|Jun:2024|May:2024|Apr:2024|Mar:2024|Feb:2024|Jan:2024|",
                                "values": "000/XXX|000/XXX|000/XXX|000/XXX|000/XXX|000/XXX|000/XXX|"
                            },
                            {
                                "name": "HIGH-CREDIT-HISTORY",
                                "dates": "",
                                "values": ""
                            },
                            {
                                "name": "CURRENT-BALANCE-HISTORY",
                                "dates": "",
                                "values": ""
                            },
                            {
                                "name": "AMT-PAID-HISTORY",
                                "dates": "",
                                "values": ""
                            }
                        ],
                        "account_remarks": null,
                        "security_status": "Un-Secured",
                        "acct_in_dispute": null,
                        "suit_filed_wilful_default_status": "No Suit filed",
                        "written_off_settled_status": null,
                        "write_off_dt": null,
                        "security_details": [
                            {
                                "security_type": null,
                                "owner_name": null,
                                "security_valuation": null,
                                "date_of_valuation": null,
                                "security_charge": null,
                                "property_address": null,
                                "automobile_type": null,
                                "year_of_manufacturing": null,
                                "registration_number": null,
                                "engine_number": null,
                                "chassie_number": null
                            }
                        ],
                        "linked_accounts": [],
                        "suit_filed_dt": null,
                        "last_paid_amount": "3,280",
                        "occupation": "",
                        "income_frequency": "",
                        "income_amount": ""
                    }
                ],
                "inquiry_history": [
                    {
                        "lender_name": "FINCFRIENDS PRIVATE LIMITED",
                        "lender_type": "",
                        "inquiry_dt": "05-04-2026",
                        "ownership_type": "PRIMARY",
                        "credit_inq_purps_type": "Personal Loan",
                        "credit_inquiry_stage": "",
                        "amount": "0",
                        "remark": "",
                        "loan_type": ""
                    }
                ],
                "score": [
                    {
                        "name": "PERFORM CONSUMER 2.2",
                        "version": null,
                        "value": "653",
                        "description": null,
                        "factors": [
                            {
                                "type": "SF03",
                                "desc": "No/minimal missed payments in recent past"
                            },
                            {
                                "type": "SF12",
                                "desc": "Substantial proportion of outstanding balance to disbursed amount"
                            },
                            {
                                "type": "SF32",
                                "desc": "Considerably high number of self/overall loans disbursed in the recent past"
                            }
                        ]
                    }
                ]
            },
            "requested_services": null,
            "accounts_summary": {
                "primary_accounts_summary": {
                    "number_of_accounts": "23",
                    "active_accounts": "9",
                    "overdue_accounts": "0",
                    "secured_accounts": "1",
                    "unsecured_accounts": "22",
                    "untagged_accounts": "0",
                    "total_current_balance": "0.0",
                    "current_balance_secured": "0.0",
                    "current_balance_unsecured": "151705.0",
                    "total_sanctioned_amt": "0.0",
                    "total_disbursed_amt": "0.0",
                    "total_amt_overdue": "0"
                },
                "secondary_accounts_summary": {
                    "number_of_accounts": "0",
                    "active_accounts": "0",
                    "overdue_accounts": "0",
                    "secured_accounts": "0.0",
                    "unsecured_accounts": "0",
                    "untagged_accounts": "0",
                    "total_current_balance": "0.0",
                    "total_sanctioned_amt": "0.0",
                    "total_disbursed_amt": "0.0",
                    "total_amt_overdue": "0"
                },
                "mfi_group_accounts_summary": {
                    "number_of_accounts": "0",
                    "active_accounts": "0",
                    "overdue_accounts": "0",
                    "closed_accounts": "0",
                    "no_of_other_mfis": "0",
                    "no_of_own_mfis": "0",
                    "total_own_current_balance": "0.0",
                    "total_own_installment_amt": "0",
                    "total_own_disbursed_amt": "0.0",
                    "total_own_overdue_amt": "0.0",
                    "total_other_current_balance": "0.0",
                    "total_other_installment_amt": "0",
                    "total_other_disbursed_amt": "0.0",
                    "total_other_overdue_amt": "0.0",
                    "max_worst_delinquency": "0"
                },
                "additional_summary": [
                    {
                        "attr_name": "NUM-GRANTORS",
                        "attr_value": "16"
                    },
                    {
                        "attr_name": "NUM-GRANTORS-ACTIVE",
                        "attr_value": "10"
                    },
                    {
                        "attr_name": "NUM-GRANTORS-DELINQ",
                        "attr_value": "0"
                    },
                    {
                        "attr_name": "NUM-GRANTORS-ONLY-PRIMARY",
                        "attr_value": "10"
                    },
                    {
                        "attr_name": "NUM-GRANTORS-ONLY-SECONDARY",
                        "attr_value": "0"
                    }
                ],
                "perform_attributes": [
                    {
                        "attr_name": "INQUIRIES-IN-LAST-SIX-MONTHS",
                        "attr_value": "10"
                    },
                    {
                        "attr_name": "LENGTH-OF-CREDIT-HISTORY-YEAR",
                        "attr_value": "2"
                    },
                    {
                        "attr_name": "LENGTH-OF-CREDIT-HISTORY-MONTH",
                        "attr_value": "11"
                    }
                ]
            },
            "trends": {
                "name": "SCORE-HISTORY",
                "dates": "31-12-2025|30-09-2025|30-06-2025|31-03-2025|31-12-2024|30-09-2024|30-06-2024|31-03-2024|31-12-2023|30-09-2023|30-06-2023|31-03-2023",
                "values": "729|729|760|703|701|724|701|675|724|620|620|620",
                "reserved1": "Perform Consumer v2",
                "reserved2": null,
                "reserved3": null,
                "description": "|||||||||||"
            },
            "alerts": []
        }
    }
}
```


### `crif_json_v2`

```json
{
    "INDV-REPORT-FILE": {
        "INDV-REPORTS": {
            "INDV-REPORT": {
                "HEADER": {
                    "DATE-OF-REQUEST": "17-04-2026",
                    "DATE-OF-ISSUE": "17-04-2026",
                    "REPORT-ID": "",
                    "BATCH-ID": "",
                    "inquiryId_": "",
                    "STATUS": "SUCCESS"
                },
                "REQUEST": {
                    "NAME": "",
                    "DOB": "18-01-2000",
                    "PAN": "",
                    "UID": "",
                    "EMAIL-1": "",
                    "ADDRESS-1": "adarsh nagar road n 3 sant lawrence i t i  Phulwarisharif Patna  Phulwarisharif Bihar 801505",
                    "ADDRESS-2": "",
                    "ADDRESS-3": "",
                    "PHONE-1": ""
                },
                "PERSONAL-INFO-VARIATION": {
                    "NAME-VARIATIONS": {
                        "VARIATION": [
                            {
                                "VALUE": "XXXXX",
                                "REPORTED-DATE": "15-04-2026"
                            }
                        ]
                    },
                    "ADDRESS-VARIATIONS": {
                        "VARIATION": [
                            {
                                "VALUE": "S/O: SURENDRA CHAUHAN,  ADARSH NAGAR,  ROAD N 3,  SANT LAWRENCE I T I,  PHULWARI,  PATNA,  BIHAR,  INDIA,  801505 801505 BR",
                                "REPORTED-DATE": "15-03-2026"
                            }
                        ]
                    },
                    "PAN-VARIATIONS": {
                        "VARIATION": {
                            "VALUE": "XXXXXX",
                            "REPORTED-DATE": "07-04-2026"
                        }
                    },
                    "UID-VARIATIONS": "",
                    "OTHER-ID-VARIATIONS": "",
                    "DRIVING-LICENSE-VARIATIONS": "",
                    "DATE-OF-BIRTH-VARIATIONS": {
                        "VARIATION": [
                            {
                                "VALUE": "18-01-2000",
                                "REPORTED-DATE": "31-03-2026"
                            }
                        ]
                    },
                    "VOTER-ID-VARIATIONS": "",
                    "PASSPORT-VARIATIONS": "",
                    "PHONE-NUMBER-VARIATIONS": {
                        "VARIATION": [
                            {
                                "VALUE": "00000000000",
                                "REPORTED-DATE": "31-03-2026"
                            }
                        ]
                    },
                    "RATION-CARD-VARIATIONS": "",
                    "EMAIL-VARIATIONS": {
                        "VARIATION": {
                            "VALUE": "praveenkumar1812000@gmail.com",
                            "REPORTED-DATE": "07-04-2026"
                        }
                    }
                },
                "SECONDARY-MATCHES": "",
                "ACCOUNTS-SUMMARY": {
                    "DERIVED-ATTRIBUTES": {
                        "INQURIES-IN-LAST-SIX-MONTHS": "7",
                        "LENGTH-OF-CREDIT-HISTORY-YEAR": "2",
                        "LENGTH-OF-CREDIT-HISTORY-MONTH": "5",
                        "AVERAGE-ACCOUNT-AGE-YEAR": "0",
                        "AVERAGE-ACCOUNT-AGE-MONTH": "4",
                        "NEW-ACCOUNTS-IN-LAST-SIX-MONTHS": "13",
                        "NEW-DELINQ-ACCOUNT-IN-LAST-SIX-MONTHS": "1"
                    },
                    "PRIMARY-ACCOUNTS-SUMMARY": {
                        "PRIMARY-NUMBER-OF-ACCOUNTS": "15",
                        "PRIMARY-ACTIVE-NUMBER-OF-ACCOUNTS": "12",
                        "PRIMARY-OVERDUE-NUMBER-OF-ACCOUNTS": "1",
                        "PRIMARY-SECURED-NUMBER-OF-ACCOUNTS": "0",
                        "PRIMARY-UNSECURED-NUMBER-OF-ACCOUNTS": "15",
                        "PRIMARY-UNTAGGED-NUMBER-OF-ACCOUNTS": "0",
                        "PRIMARY-CURRENT-BALANCE": "0",
                        "PRIMARY-SANCTIONED-AMOUNT": "0",
                        "PRIMARY-DISBURSED-AMOUNT": "0"
                    },
                    "SECONDARY-ACCOUNTS-SUMMARY": {
                        "SECONDARY-NUMBER-OF-ACCOUNTS": "0",
                        "SECONDARY-ACTIVE-NUMBER-OF-ACCOUNTS": "0",
                        "SECONDARY-OVERDUE-NUMBER-OF-ACCOUNTS": "0",
                        "SECONDARY-SECURED-NUMBER-OF-ACCOUNTS": "0.0",
                        "SECONDARY-UNSECURED-NUMBER-OF-ACCOUNTS": "0",
                        "SECONDARY-UNTAGGED-NUMBER-OF-ACCOUNTS": "0",
                        "SECONDARY-CURRENT-BALANCE": "0",
                        "SECONDARY-SANCTIONED-AMOUNT": "0",
                        "SECONDARY-DISBURSED-AMOUNT": "0"
                    }
                },
                "EMPLOYMENT-DETAILS": {
                    "EMPLOYMENT-DETAIL": {
                        "ACCT-TYPE": "Personal Loan",
                        "DATE-REPORTED": "31-03-2026",
                        "OCCUPATION": "SALARIED"
                    }
                },
                "RESPONSES": {
                    "RESPONSE": [
                        {
                            "LOAN-DETAILS": {
                                "ACCT-NUMBER": "TBPL01-60305-1821838",
                                "CREDIT-GUARANTOR": "TRUE CREDITS PRIVATE LIMITED",
                                "CREDIT-GRANTOR-GROUP": null,
                                "CREDIT-GRANTOR-TYPE": null,
                                "ACCT-TYPE": "Personal Loan",
                                "DATE-REPORTED": "31-03-2026",
                                "OWNERSHIP-IND": "Individual",
                                "ACCOUNT-STATUS": "Closed",
                                "DISBURSED-AMT": "1,221",
                                "DISBURSED-DT": "05-03-2026",
                                "LAST-PAYMENT-DATE": "10-03-2026",
                                "CLOSED-DATE": "10-03-2026",
                                "INSTALLMENT-AMT": "0/Monthly/Monthly",
                                "OVERDUE-AMT": "0",
                                "WRITE-OFF-AMT": "0",
                                "PRINCIPAL-WRITE-OFF-AMT": null,
                                "SETTLEMENT-AMT": null,
                                "CURRENT-BAL": "0",
                                "COMBINED-PAYMENT-HISTORY": "Mar:2026,000/XXX|",
                                "MATCHED-TYPE": "PRIMARY",
                                "LINKED-ACCOUNTS": "",
                                "SECURITY-DETAILS": "",
                                "SECURITY-STATUS": "Un-Secured",
                                "ACCOUNT-REMARKS": null,
                                "ACCT-IN-DISPUTE": null,
                                "SUIT-FILED-WILFUL-DEFAULT-STATUS": "No Suit filed",
                                "WRITTEN-OFF-SETTLED-STATUS": null,
                                "WRITE-OFF-DT": null,
                                "SUIT-FILED-DT": null,
                                "LAST-PAID-AMOUNT": "1,313",
                                "OBLIGATION": null,
                                "ORIGINAL-TERM": "0",
                                "TERM-TO-MATURITY": "0",
                                "ACTUAL-PAYMENT": "1,313",
                                "REPAYMENT-TENURE": "6",
                                "INTEREST-RATE": "41.76",
                                "CREDIT-LIMIT": "",
                                "CASH-LIMIT": "",
                                "OCCUPATION": "Salaried",
                                "INCOME-FREQUENCY": "",
                                "INCOME-AMOUNT": ""
                            }
                        }
                    ]
                },
                "INQUIRY-HISTORY": {
                    "HISTORY": [
                        {
                            "MEMBER-NAME": "VAIBHAV VYAPAAR PRIVATE LIMITED",
                            "PURPOSE": "Personal Loan",
                            "AMOUNT": "0",
                            "REMARK": "—",
                            "INQUIRY-DATE": "15-04-2026"
                        }
                    ]
                },
                "SCORES": {
                    "SCORE": {
                        "SCORE-TYPE": "PERFORM CONSUMER 2.2",
                        "SCORE-VALUE": "594",
                        "SCORE-FACTORS": "SF12|SF32|"
                    }
                },
                "verificarionScoreList": "",
                "PRINTABLE-REPORT": {
                    "TYPE": "",
                    "FILE-NAME": "",
                    "CONTENT": ""
                },
                "enhanceProCcirFlag": "false",
                "ccirFlag": "false"
            }
        }
    }
}
```


### `crif_json_v3`

```json
{
    "INDV-REPORT-FILE": {
        "INDV-REPORTS": [
            {
                "INDV-REPORT": {
                    "HEADER": {
                        "DATE-OF-REQUEST": "18-04-2026 18:41:57",
                        "PREPARED-FOR": "",
                        "PREPARED-FOR-ID": "",
                        "DATE-OF-ISSUE": "18-04-2026",
                        "BATCH-ID": "",
                        "REPORT-ID": ""
                    },
                    "REQUEST": {
                        "NAME": "XXXXX",
                        "AKA": "",
                        "DOB": "19-03-1970",
                        "AGE-AS-ON": "",
                        "IDS": [
                            {
                                "TYPE": "ID07",
                                "VALUE": "XXXXX"
                            }
                        ],
                        "ADDRESSES": {
                            "ADDRESS": [
                                "264/2 Byrappa Block Hanuman temple Thyagarajnagar Banashankari II Stage Bengaluru Tyagrajnagar Karnataka India Bengaluru 560070 KA",
                                "264/2 Byrappa Block Hanuman temple Thyagarajnagar Banashankari II Stage Bengaluru Tyagrajnagar Karnataka India Bengaluru 560071 KA"
                            ]
                        },
                        "PHONES": {
                            "PHONE": [
                                "XXXXX"
                            ]
                        },
                        "EMAILS": {},
                        "GENDER": "Male",
                        "BRANCH": "0",
                        "KENDRA": "",
                        "MBR-ID": "NBF0004800",
                        "CREDIT-INQ-PURPS-TYP": "ACCT-ORIG",
                        "CREDIT-INQ-PURPS-TYP-DESC": "A01",
                        "CREDIT-INQUIRY-STAGE": "PRE-DISB",
                        "CREDIT-RPT-ID": "0",
                        "CREDIT-REQ-TYP": "INDV",
                        "CREDIT-RPT-TRN-DT-TM": "18-04-2026 18:41:57",
                        "LOS-APP-ID": "a7d9e05b-b8ba-448e-9abf-2ab9fd015327",
                        "LOAN-AMOUNT": "0",
                        "MFI-IND": "TRUE",
                        "MFI-SCORE": "FALSE",
                        "MFI-GROUP": "FALSE",
                        "CNS-IND": "TRUE",
                        "CNS-SCORE": "PERFORM-CONSUMER",
                        "IOI": "TRUE"
                    },
                    "STATUS-DETAILS": [
                        {
                            "OPTION": "CNS-SCORE",
                            "OPTION-STATUS": "SUCCESS"
                        },
                        {
                            "OPTION": "MFI-INDV",
                            "OPTION-STATUS": "NO RESPONSE FOUND",
                            "ERRORS": [
                                {}
                            ]
                        },
                        {
                            "OPTION": "CNS_INDV",
                            "OPTION-STATUS": "SUCCESS"
                        },
                        {
                            "OPTION": "INQUIRY-HISTORY",
                            "OPTION-STATUS": "SUCCESS"
                        }
                    ],
                    "PERSONAL-INFO-VARIATION": {
                        "NAME-VARIATIONS": [
                            {
                                "VALUE": "XXXX",
                                "REPORTED-DATE": "31-03-2026"
                            }
                        ],
                        "ADDRESS-VARIATIONS": [
                            {
                                "VALUE": "201ST FLR9TH MNTATA SILK FORM BASAVANAGUDIBANGALORE NEAR FORUM BANGALORE 560004 KA",
                                "REPORTED-DATE": "15-04-2026"
                            }
                        ],
                        "PAN-VARIATIONS": [
                            {
                                "VALUE": "XXXXXX",
                                "REPORTED-DATE": "15-04-2026"
                            }
                        ],
                        "DRIVING-LICENSE-VARIATIONS": [
                            {
                                "VALUE": "XXXXX",
                                "REPORTED-DATE": "31-03-2026"
                            }
                        ],
                        "DATE-OF-BIRTH-VARIATIONS": [
                            {
                                "VALUE": "19-03-1970",
                                "REPORTED-DATE": "15-04-2026"
                            }
                        ],
                        "VOTER-ID-VARIATIONS": [],
                        "PASSPORT-VARIATIONS": [],
                        "PHONE-NUMBER-VARIATIONS": [
                            {
                                "VALUE": "XXXXX",
                                "REPORTED-DATE": "31-12-2018"
                            }
                        ],
                        "RATION-CARD-VARIATIONS": [],
                        "EMAIL-VARIATIONS": [
                            {
                                "VALUE": "nomail@nomail.com",
                                "REPORTED-DATE": "30-04-2021"
                            }
                        ],
                        "NREGA-VARIATIONS": [],
                        "CKYC-VARIATIONS": []
                    },
                    "ACCOUNTS-SUMMARY": {
                        "DERIVED-ATTRIBUTES": {
                            "INQUIRIES-IN-LAST-SIX-MONTHS": 0,
                            "LENGTH-OF-CREDIT-HISTORY-YEAR": 16,
                            "LENGTH-OF-CREDIT-HISTORY-MONTH": 8,
                            "AVERAGE-ACCOUNT-AGE-YEAR": 3,
                            "AVERAGE-ACCOUNT-AGE-MONTH": 6,
                            "NEW-ACCOUNTS-IN-LAST-SIX-MONTHS": 10,
                            "NEW-DELINQ-ACCOUNT-IN-LAST-SIX-MONTHS": 1,
                            "TOTAL-WRITTEN-OFF-ACCOUNTS": 2,
                            "TOTAL-RESTRUCTURED-ACCOUNTS": 0,
                            "TOTAL-SETTLED-ACCOUNTS": 0,
                            "TOTAL-WRITTEN-OFF-AMOUNT": "0",
                            "TOTAL-SETTLED-AMOUNT": "0"
                        },
                        "PRIMARY-ACCOUNTS-SUMMARY": {
                            "PRIMARY-NUMBER-OF-ACCOUNTS": 61,
                            "PRIMARY-ACTIVE-NUMBER-OF-ACCOUNTS": 18,
                            "PRIMARY-OVERDUE-NUMBER-OF-ACCOUNTS": 4,
                            "PRIMARY-SECURED-NUMBER-OF-ACCOUNTS": 26,
                            "PRIMARY-UNSECURED-NUMBER-OF-ACCOUNTS": 35,
                            "PRIMARY-UNTAGGED-NUMBER-OF-ACCOUNTS": 0,
                            "PRIMARY-CURRENT-BALANCE": "38,16,171",
                            "PRIMARY-SANCTIONED-AMOUNT": "46,38,900",
                            "PRIMARY-DISBURSED-AMOUNT": "46,38,900"
                        },
                        "SECONDARY-ACCOUNTS-SUMMARY": {
                            "SECONDARY-NUMBER-OF-ACCOUNTS": 0,
                            "SECONDARY-ACTIVE-NUMBER-OF-ACCOUNTS": 0,
                            "SECONDARY-OVERDUE-NUMBER-OF-ACCOUNTS": 0,
                            "SECONDARY-SECURED-NUMBER-OF-ACCOUNTS": 0,
                            "SECONDARY-UNSECURED-NUMBER-OF-ACCOUNTS": 0,
                            "SECONDARY-UNTAGGED-NUMBER-OF-ACCOUNTS": 0,
                            "SECONDARY-CURRENT-BALANCE": "0",
                            "SECONDARY-SANCTIONED-AMOUNT": "0",
                            "SECONDARY-DISBURSED-AMOUNT": "0"
                        }
                    },
                    "ALERTS": [
                        {
                            "ALERT-DESC": "NO"
                        }
                    ],
                    "SCORES": [
                        {
                            "SCORE-TYPE": "PERFORM CONSUMER 2.2",
                            "SCORE-VALUE": "510",
                            "SCORE-FACTORS": "SF02|SF04|SF06|SF12|"
                        }
                    ],
                    "INQUIRY-HISTORY": [
                        {
                            "MEMBER-NAME": "NAB",
                            "INQUIRY-DATE": "16-05-2024",
                            "PURPOSE": "OTHER",
                            "AMOUNT": "4,50,000",
                            "REMARK": ""
                        }
                    ],
                    "RESPONSES": [
                        {
                            "LOAN-DETAILS": {
                                "ACCT-NUMBER": "XXXX",
                                "CREDIT-GUARANTOR": "NAB",
                                "ACCT-TYPE": "Personal Loan",
                                "DATE-REPORTED": "31-01-2026",
                                "OWNERSHIP-IND": "Individual",
                                "ACCOUNT-STATUS": "Closed",
                                "DISBURSED-AMT": "2,50,000",
                                "DISBURSED-DATE": "05-08-2021",
                                "LAST-PAYMENT-DATE": "02-01-2026",
                                "CLOSED-DATE": "02-01-2026",
                                "WRITE-OFF-AMT": "0",
                                "CURRENT-BAL": "0",
                                "SECURITY-STATUS": "Un-secured",
                                "ORIGINAL-TERM": "120",
                                "ACCT-IN-DISPUTE": "",
                                "CURRENT-BALANCE-HISTORY": "Jan:2026,0|Dec:2025,1,61,450|Nov:2025,1,63,219|Oct:2025,1,67,223|Sep:2025,1,68,894|Aug:2025,1,69,877|Jul:2025,1,72,877|Jun:2025,1,75,269|May:2025,1,77,186|Apr:2025,1,79,055|Mar:2025,1,80,950|Feb:2025,1,82,796|",
                                "AMT-PAID-HISTORY": "Jan:2026,1,64,545|Dec:2025,2,980|Nov:2025,1,78,254|Oct:2025,10,999|Sep:2025,10,016|Aug:2025,7,016|Jul:2025,4,624|Jun:2025,2,949|May:2025,2,949|Apr:2025,2,948|Mar:2025,2,949|Feb:2025,2,952|",
                                "COMBINED-PAYMENT-HISTORY": "Jan:2026,000/STD|Dec:2025,000/STD|Nov:2025,000/STD|Oct:2025,106/SUB|Sep:2025,075/SUB|Aug:2025,045/SUB|Jul:2025,014/SUB|Jun:2025,000/DBT|May:2025,000/DBT|Apr:2025,000/DBT|Mar:2025,000/DBT|Feb:2025,000/DBT|Jan:2025,000/DBT|Dec:2024,000/DBT|Nov:2024,000/DBT|Oct:2024,000/STD|Sep:2024,000/STD|Aug:2024,000/STD|Jul:2024,000/STD|Jun:2024,000/STD|May:2024,000/STD|Apr:2024,000/STD|Mar:2024,000/STD|Feb:2024,000/STD|Jan:2024,000/STD|Dec:2023,000/STD|Nov:2023,000/STD|Oct:2023,000/STD|Sep:2023,000/STD|Aug:2023,000/STD|Jul:2023,000/STD|Jun:2023,000/STD|May:2023,000/STD|Apr:2023,000/STD|Mar:2023,000/STD|Feb:2023,000/STD|",
                                "MATCHED-TYPE": "PRIMARY",
                                "ACTUAL-PAYMENT": "1,64,545",
                                "INSTALLMENT-AMT": "3,004/Monthly",
                                "SECURITY-DETAILS": [],
                                "LINKED-ACCOUNTS": [],
                                "INTEREST-RATE": "7.0",
                                "OCCUPATION": "Salaried",
                                "INCOME-FREQUENCY": "Annual",
                                "INCOME-AMOUNT": "1,50,001"
                            }
                        }
                    ],
                    "INDV-RESPONSES": {
                        "PRIMARY-SUMMARY": {
                            "NO-OF-DEFAULT-ACCOUNTS": 0,
                            "TOTAL-RESPONSES": 0,
                            "NO-OF-CLOSED-ACCOUNTS": 0,
                            "NO-OF-ACTIVE-ACCOUNTS": 0,
                            "NO-OF-OTHER-MFIS": 0,
                            "NO-OF-OWN-MFIS": 0,
                            "NO-OF-OTHER-ACTIVE-MFIS": 0,
                            "NO-OF-OWN-ACTIVE-MFIS": 0
                        },
                        "SECONDARY-SUMMARY": {
                            "NO-OF-DEFAULT-ACCOUNTS": 0,
                            "TOTAL-RESPONSES": 0,
                            "NO-OF-CLOSED-ACCOUNTS": 0,
                            "NO-OF-ACTIVE-ACCOUNTS": 0,
                            "NO-OF-OTHER-MFIS": 0,
                            "NO-OF-OWN-MFIS": 0,
                            "NO-OF-OTHER-ACTIVE-MFIS": 0,
                            "NO-OF-OWN-ACTIVE-MFIS": 0
                        },
                        "INDIVIDUAL-SUMMARY": {
                            "STATUS": "SUCCESS",
                            "TOTAL-RESPONSES": 0,
                            "NO-OF-OTHER-MFIS": 0,
                            "NO-OF-OTHER-ACTIVE-MFIS": 0,
                            "NO-OF-DEFAULT-ACCOUNTS": 0,
                            "NO-OF-CLOSED-ACCOUNTS": 0,
                            "NO-OF-ACTIVE-ACCOUNTS": 0,
                            "NO-OF-OWN-MFIS": 0,
                            "NO-OF-OWN-ACTIVE-MFIS": 0,
                            "OWN-MFI-INDECATOR": false
                        },
                        "DERIVED-ATTRIBUTES": {
                            "TOTAL-WRITTEN-OFF-ACCOUNTS": 0,
                            "TOTAL-RESTRUCTURED-ACCOUNTS": 0,
                            "TOTAL-WRITTEN-OFF-AMOUNT": "0"
                        },
                        "INDV-RESPONSE-LIST": {}
                    },
                    "ADDITIONAL-VARIABLES": {}
                }
            }
        ]
    }
}
```