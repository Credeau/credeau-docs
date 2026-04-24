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