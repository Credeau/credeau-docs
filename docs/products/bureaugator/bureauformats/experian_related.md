# Experian Bureau Formats

Experian delivers credit information through their INProfileResponse format, available in both JSON and XML. The structure includes CAIS (Credit Account Information Sharing) account details, CAPS (Credit Application Processing Service) inquiry data, and bureau scores. Experian reports emphasize account status tracking, payment ratings, and comprehensive inquiry history with both credit and non-credit applications.

### `experian_softpull_json`

```json
{
    "INProfileResponse": {
        "Header": {
            "SystemCode": "0",
            "MessageText": "",
            "ReportDate": "20260413",
            "ReportTime": "100526"
        },
        "UserMessage": {
            "UserMessageText": "Normal Response"
        },
        "CreditProfileHeader": {},
        "Current_Application": {
            "Current_Application_Details": {
                "Enquiry_Reason": "13",
                "Finance_Purpose": "99",
                "Amount_Financed": "5000",
                "Duration_Of_Agreement": "6",
                "Current_Applicant_Details": {
                    "Last_Name": "",
                    "First_Name": "",
                    "Middle_Name1": "",
                    "Middle_Name2": "",
                    "Middle_Name3": "",
                    "Gender_Code": "1",
                    "IncomeTaxPan": "",
                    "PAN_Issue_Date": "",
                    "PAN_Expiration_Date": "",
                    "Passport_Number": "",
                    "Passport_Issue_Date": "",
                    "Passport_Expiration_Date": "",
                    "Voter_s_Identity_Card": "",
                    "Voter_ID_Issue_Date": "",
                    "Voter_ID_Expiration_Date": "",
                    "Driver_License_Number": "",
                    "Driver_License_Issue_Date": "",
                    "Driver_License_Expiration_Date": "",
                    "Ration_Card_Number": "",
                    "Ration_Card_Issue_Date": "",
                    "Ration_Card_Expiration_Date": "",
                    "Universal_ID_Number": "",
                    "Universal_ID_Issue_Date": "",
                    "Universal_ID_Expiration_Date": "",
                    "Date_Of_Birth_Applicant": "",
                    "Telephone_Number_Applicant_1st": "",
                    "Telephone_Extension": "",
                    "Telephone_Type": "",
                    "MobilePhoneNumber": "",
                    "EMailId": "charuramya55@gmail.com"
                },
                "Current_Other_Details": {
                    "Income": "",
                    "Marital_Status": "",
                    "Employment_Status": "",
                    "Time_with_Employer": "",
                    "Number_of_Major_Credit_Card_Held": ""
                },
                "Current_Applicant_Address_Details": {
                    "FlatNoPlotNoHouseNo": "N/A",
                    "BldgNoSocietyName": "Bairamangalam",
                    "RoadNoNameAreaLocality": "",
                    "City": "Bairamangalam",
                    "Landmark": "",
                    "State": "33",
                    "PINCode": "635113",
                    "Country_Code": "IB"
                },
                "Current_Applicant_Additional_Address_Details": ""
            }
        },
        "CAIS_Account": {
            "CAIS_Summary": {
                "Credit_Account": {
                    "CreditAccountTotal": "63",
                    "CreditAccountActive": "4",
                    "CreditAccountDefault": "0",
                    "CreditAccountClosed": "59",
                    "CADSuitFiledCurrentBalance": "0"
                },
                "Total_Outstanding_Balance": {
                    "Outstanding_Balance_Secured": "1541865",
                    "Outstanding_Balance_Secured_Percentage": "100",
                    "Outstanding_Balance_UnSecured": "7549",
                    "Outstanding_Balance_UnSecured_Percentage": "0",
                    "Outstanding_Balance_All": "1549414"
                }
            },
            "CAIS_Account_DETAILS": [
                {
                    "Identification_Number": "NBFXXXXXXXX",
                    "Subscriber_Name": "XXXXXXXXXX",
                    "Account_Number": "XXXXXX9608",
                    "Portfolio_Type": "I",
                    "Account_Type": "07",
                    "Open_Date": "20260319",
                    "Highest_Credit_or_Original_Loan_Amount": "125181",
                    "Terms_Duration": "012",
                    "Terms_Frequency": "OD",
                    "Scheduled_Monthly_Payment_Amount": "",
                    "Account_Status": "11",
                    "Payment_Rating": "0",
                    "Payment_History_Profile": "N",
                    "Special_Comment": "",
                    "Current_Balance": "125180",
                    "Amount_Past_Due": "0",
                    "Original_Charge_off_Amount": "",
                    "Date_Reported": "20260331",
                    "Date_Of_First_Delinquency": "",
                    "Date_Closed": "",
                    "Date_of_Last_Payment": "",
                    "SuitFiledWillfulDefaultWrittenOffStatus": "",
                    "SuitFiled_WilfulDefault": "",
                    "Written_off_Settled_Status": "",
                    "Value_of_Credits_Last_Month": "",
                    "Occupation_Code": "",
                    "Settlement_Amount": "",
                    "Value_of_Collateral": "166914",
                    "Type_of_Collateral": "",
                    "Written_Off_Amt_Total": "",
                    "Written_Off_Amt_Principal": "",
                    "Rate_of_Interest": "",
                    "Repayment_Tenure": "12",
                    "Promotional_Rate_Flag": "",
                    "Income": "",
                    "Income_Indicator": "",
                    "Income_Frequency_Indicator": "",
                    "DefaultStatusDate": "",
                    "LitigationStatusDate": "",
                    "WriteOffStatusDate": "",
                    "DateOfAddition": "20260331",
                    "CurrencyCode": "INR",
                    "Subscriber_comments": "",
                    "Consumer_comments": "",
                    "AccountHoldertypeCode": "1",
                    "CAIS_Account_History": {
                        "Year": "2026",
                        "Month": "03",
                        "Days_Past_Due": "0",
                        "Asset_Classification": "?"
                    },
                    "CAIS_Holder_Details": {},
                    "CAIS_Holder_Address_Details": {},
                    "CAIS_Holder_Phone_Details": {},
                    "CAIS_Holder_ID_Details": {}
                }
            ]
        },
        "Match_result": {
            "Exact_match": "Y"
        },
        "TotalCAPS_Summary": {
            "TotalCAPSLast7Days": "25",
            "TotalCAPSLast30Days": "25",
            "TotalCAPSLast90Days": "26",
            "TotalCAPSLast180Days": "26"
        },
        "CAPS": {
            "CAPS_Summary": {
                "CAPSLast7Days": "1",
                "CAPSLast30Days": "1",
                "CAPSLast90Days": "2",
                "CAPSLast180Days": "2"
            },
            "CAPS_Application_Details": [
                {
                    "Subscriber_code": "NBF163196",
                    "Subscriber_Name": "R K BANSAL FINANCE PRIVATE LIMITED",
                    "Date_of_Request": "20260413",
                    "ReportTime": "100525",
                    "ReportNumber": "1776054925599",
                    "Enquiry_Reason": "13",
                    "Finance_Purpose": "",
                    "Amount_Financed": "5000",
                    "Duration_Of_Agreement": "6",
                    "CAPS_Applicant_Details": {
                        "Last_Name": "",
                        "First_Name": "",
                        "Middle_Name1": "",
                        "Middle_Name2": "",
                        "Middle_Name3": "",
                        "Gender_Code": "",
                        "Date_Of_Birth_Applicant": "",
                        "Telephone_Number_Applicant_1st": "",
                        "Telephone_Extension": "",
                        "Telephone_Type": "",
                        "EMailId": ""
                    },
                    "CAPS_Other_Details": {
                        "Income": "",
                        "Marital_Status": "",
                        "Employment_Status": "",
                        "Time_with_Employer": "",
                        "Number_of_Major_Credit_Card_Held": ""
                    },
                    "CAPS_Applicant_Address_Details": {
                        "FlatNoPlotNoHouseNo": "",
                        "BldgNoSocietyName": "",
                        "RoadNoNameAreaLocality": "",
                        "City": "",
                        "Landmark": "",
                        "State": "",
                        "PINCode": "",
                        "Country_Code": "IB"
                    },
                    "CAPS_Applicant_Additional_Address_Details": ""
                }
            ]
        },
        "NonCreditCAPS": {
            "NonCreditCAPS_Summary": {
                "NonCreditCAPSLast7Days": "24",
                "NonCreditCAPSLast30Days": "24",
                "NonCreditCAPSLast90Days": "24",
                "NonCreditCAPSLast180Days": "24"
            },
            "CAPS_Application_Details": [
                {
                    "Subscriber_code": "NBFXXXXXXXX",
                    "Subscriber_Name": "XXXXXXXXXX",
                    "Date_of_Request": "20260122",
                    "ReportTime": "113813",
                    "ReportNumber": "1769062093192",
                    "Enquiry_Reason": "99",
                    "Finance_Purpose": "99",
                    "Amount_Financed": "0",
                    "Duration_Of_Agreement": "0",
                    "CAPS_Applicant_Details": {
                        "Last_Name": "Venkatesh",
                        "First_Name": "Srinivas",
                        "Middle_Name1": "",
                        "Middle_Name2": "",
                        "Middle_Name3": "",
                        "Gender_Code": "",
                        "Date_Of_Birth_Applicant": "",
                        "Telephone_Type": "01",
                        "MobilePhoneNumber": "9952252341",
                        "EMailId": ""
                    },
                    "CAPS_Other_Details": {
                        "Income": "",
                        "Marital_Status": "",
                        "Employment_Status": "",
                        "Time_with_Employer": "",
                        "Number_of_Major_Credit_Card_Held": ""
                    },
                    "CAPS_Applicant_Address_Details": {
                        "FlatNoPlotNoHouseNo": "",
                        "BldgNoSocietyName": "",
                        "RoadNoNameAreaLocality": "",
                        "City": "",
                        "Landmark": "",
                        "State": "",
                        "PINCode": "",
                        "Country_Code": "IB"
                    },
                    "CAPS_Applicant_Additional_Address_Details": ""
                }
            ]
        },
        "SCORE": {
            "BureauScore": "606",
            "BureauScoreConfidLevel": "",
            "CreditRating": ""
        }
    }
}
```


### `experian_softpull_json_v2`

```json
{
    "INProfileResponse": {
        "Header": {
            "SystemCode": "0",
            "MessageText": "",
            "ReportDate": "20260413",
            "ReportTime": "100526"
        },
        "UserMessage": {
            "UserMessageText": "Normal Response"
        },
        "CreditProfileHeader": {},
        "Current_Application": {
            "Current_Application_Details": {
                "Enquiry_Reason": "13",
                "Finance_Purpose": "99",
                "Amount_Financed": "5000",
                "Duration_Of_Agreement": "6",
                "Current_Applicant_Details": {
                    "Last_Name": "",
                    "First_Name": "",
                    "Middle_Name1": "",
                    "Middle_Name2": "",
                    "Middle_Name3": "",
                    "Gender_Code": "1",
                    "IncomeTaxPan": "",
                    "PAN_Issue_Date": "",
                    "PAN_Expiration_Date": "",
                    "Passport_Number": "",
                    "Passport_Issue_Date": "",
                    "Passport_Expiration_Date": "",
                    "Voter_s_Identity_Card": "",
                    "Voter_ID_Issue_Date": "",
                    "Voter_ID_Expiration_Date": "",
                    "Driver_License_Number": "",
                    "Driver_License_Issue_Date": "",
                    "Driver_License_Expiration_Date": "",
                    "Ration_Card_Number": "",
                    "Ration_Card_Issue_Date": "",
                    "Ration_Card_Expiration_Date": "",
                    "Universal_ID_Number": "",
                    "Universal_ID_Issue_Date": "",
                    "Universal_ID_Expiration_Date": "",
                    "Date_Of_Birth_Applicant": "",
                    "Telephone_Number_Applicant_1st": "",
                    "Telephone_Extension": "",
                    "Telephone_Type": "",
                    "MobilePhoneNumber": "",
                    "EMailId": "charuramya55@gmail.com"
                },
                "Current_Other_Details": {
                    "Income": "",
                    "Marital_Status": "",
                    "Employment_Status": "",
                    "Time_with_Employer": "",
                    "Number_of_Major_Credit_Card_Held": ""
                },
                "Current_Applicant_Address_Details": {
                    "FlatNoPlotNoHouseNo": "N/A",
                    "BldgNoSocietyName": "Bairamangalam",
                    "RoadNoNameAreaLocality": "",
                    "City": "Bairamangalam",
                    "Landmark": "",
                    "State": "33",
                    "PINCode": "635113",
                    "Country_Code": "IB"
                },
                "Current_Applicant_Additional_Address_Details": ""
            }
        },
        "CAIS_Account": {
            "CAIS_Summary": {
                "Credit_Account": {
                    "CreditAccountTotal": "63",
                    "CreditAccountActive": "4",
                    "CreditAccountDefault": "0",
                    "CreditAccountClosed": "59",
                    "CADSuitFiledCurrentBalance": "0"
                },
                "Total_Outstanding_Balance": {
                    "Outstanding_Balance_Secured": "1541865",
                    "Outstanding_Balance_Secured_Percentage": "100",
                    "Outstanding_Balance_UnSecured": "7549",
                    "Outstanding_Balance_UnSecured_Percentage": "0",
                    "Outstanding_Balance_All": "1549414"
                }
            },
            "CAIS_Account_DETAILS": [
                {
                    "Identification_Number": "NBFXXXXXXXX",
                    "Subscriber_Name": "XXXXXXXXXX",
                    "Account_Number": "XXXXXX9608",
                    "Portfolio_Type": "I",
                    "Account_Type": "07",
                    "Open_Date": "20260319",
                    "Highest_Credit_or_Original_Loan_Amount": "125181",
                    "Terms_Duration": "012",
                    "Terms_Frequency": "OD",
                    "Scheduled_Monthly_Payment_Amount": "",
                    "Account_Status": "11",
                    "Payment_Rating": "0",
                    "Payment_History_Profile": "N",
                    "Special_Comment": "",
                    "Current_Balance": "125180",
                    "Amount_Past_Due": "0",
                    "Original_Charge_off_Amount": "",
                    "Date_Reported": "20260331",
                    "Date_Of_First_Delinquency": "",
                    "Date_Closed": "",
                    "Date_of_Last_Payment": "",
                    "SuitFiledWillfulDefaultWrittenOffStatus": "",
                    "SuitFiled_WilfulDefault": "",
                    "Written_off_Settled_Status": "",
                    "Value_of_Credits_Last_Month": "",
                    "Occupation_Code": "",
                    "Settlement_Amount": "",
                    "Value_of_Collateral": "166914",
                    "Type_of_Collateral": "",
                    "Written_Off_Amt_Total": "",
                    "Written_Off_Amt_Principal": "",
                    "Rate_of_Interest": "",
                    "Repayment_Tenure": "12",
                    "Promotional_Rate_Flag": "",
                    "Income": "",
                    "Income_Indicator": "",
                    "Income_Frequency_Indicator": "",
                    "DefaultStatusDate": "",
                    "LitigationStatusDate": "",
                    "WriteOffStatusDate": "",
                    "DateOfAddition": "20260331",
                    "CurrencyCode": "INR",
                    "Subscriber_comments": "",
                    "Consumer_comments": "",
                    "AccountHoldertypeCode": "1",
                    "CAIS_Account_History": {
                        "Year": "2026",
                        "Month": "03",
                        "Days_Past_Due": "0",
                        "Asset_Classification": "?"
                    },
                    "CAIS_Holder_Details": {},
                    "CAIS_Holder_Address_Details": {},
                    "CAIS_Holder_Phone_Details": {},
                    "CAIS_Holder_ID_Details": {}
                }
            ]
        },
        "Match_result": {
            "Exact_match": "Y"
        },
        "TotalCAPS_Summary": {
            "TotalCAPSLast7Days": "25",
            "TotalCAPSLast30Days": "25",
            "TotalCAPSLast90Days": "26",
            "TotalCAPSLast180Days": "26"
        },
        "CAPS": {
            "CAPS_Summary": {
                "CAPSLast7Days": "1",
                "CAPSLast30Days": "1",
                "CAPSLast90Days": "2",
                "CAPSLast180Days": "2"
            },
            "CAPS_Application_Details": [
                {
                    "Subscriber_code": "NBF163196",
                    "Subscriber_Name": "R K BANSAL FINANCE PRIVATE LIMITED",
                    "Date_of_Request": "20260413",
                    "ReportTime": "100525",
                    "ReportNumber": "1776054925599",
                    "Enquiry_Reason": "13",
                    "Finance_Purpose": "",
                    "Amount_Financed": "5000",
                    "Duration_Of_Agreement": "6",
                    "CAPS_Applicant_Details": {
                        "Last_Name": "",
                        "First_Name": "",
                        "Middle_Name1": "",
                        "Middle_Name2": "",
                        "Middle_Name3": "",
                        "Gender_Code": "",
                        "Date_Of_Birth_Applicant": "",
                        "Telephone_Number_Applicant_1st": "",
                        "Telephone_Extension": "",
                        "Telephone_Type": "",
                        "EMailId": ""
                    },
                    "CAPS_Other_Details": {
                        "Income": "",
                        "Marital_Status": "",
                        "Employment_Status": "",
                        "Time_with_Employer": "",
                        "Number_of_Major_Credit_Card_Held": ""
                    },
                    "CAPS_Applicant_Address_Details": {
                        "FlatNoPlotNoHouseNo": "",
                        "BldgNoSocietyName": "",
                        "RoadNoNameAreaLocality": "",
                        "City": "",
                        "Landmark": "",
                        "State": "",
                        "PINCode": "",
                        "Country_Code": "IB"
                    },
                    "CAPS_Applicant_Additional_Address_Details": ""
                }
            ]
        },
        "NonCreditCAPS": {
            "NonCreditCAPS_Summary": {
                "NonCreditCAPSLast7Days": "24",
                "NonCreditCAPSLast30Days": "24",
                "NonCreditCAPSLast90Days": "24",
                "NonCreditCAPSLast180Days": "24"
            },
            "CAPS_Application_Details": [
                {
                    "Subscriber_code": "NBFXXXXXXXX",
                    "Subscriber_Name": "XXXXXXXXXX",
                    "Date_of_Request": "20260122",
                    "ReportTime": "113813",
                    "ReportNumber": "1769062093192",
                    "Enquiry_Reason": "99",
                    "Finance_Purpose": "99",
                    "Amount_Financed": "0",
                    "Duration_Of_Agreement": "0",
                    "CAPS_Applicant_Details": {
                        "Last_Name": "Venkatesh",
                        "First_Name": "Srinivas",
                        "Middle_Name1": "",
                        "Middle_Name2": "",
                        "Middle_Name3": "",
                        "Gender_Code": "",
                        "Date_Of_Birth_Applicant": "",
                        "Telephone_Type": "01",
                        "MobilePhoneNumber": "9952252341",
                        "EMailId": ""
                    },
                    "CAPS_Other_Details": {
                        "Income": "",
                        "Marital_Status": "",
                        "Employment_Status": "",
                        "Time_with_Employer": "",
                        "Number_of_Major_Credit_Card_Held": ""
                    },
                    "CAPS_Applicant_Address_Details": {
                        "FlatNoPlotNoHouseNo": "",
                        "BldgNoSocietyName": "",
                        "RoadNoNameAreaLocality": "",
                        "City": "",
                        "Landmark": "",
                        "State": "",
                        "PINCode": "",
                        "Country_Code": "IB"
                    },
                    "CAPS_Applicant_Additional_Address_Details": ""
                }
            ]
        },
        "SCORE": {
            "BureauScore": 476,
            "BureauScoreConfidLevel": "",
            "FCIREXScore": 476,
            "FCIREXScoreConfidLevel": ""
        }
    }
}
```



### `experian_softpull_json_v3`

```json
{
    "inprofileresponse": {
        "header": {
            "systemcode": "0",
            "messagetext": "",
            "reportdate": "20260414",
            "reporttime": "072734"
        },
        "usermessage": {
            "usermessagetext": "Normal Response"
        },
        "creditprofileheader": {
            "enquiry_username": "",
            "reportdate": "20260414",
            "reporttime": "072734",
            "version": "V2.4",
            "reportnumber": "",
            "subscriber": "",
            "subscriber_name": ""
        },
        "current_application": {
            "current_application_details": {
                "enquiry_reason": "6",
                "finance_purpose": "",
                "amount_financed": "0",
                "duration_of_agreement": "0",
                "current_applicant_details": {
                    "last_name": "XXXXX",
                    "first_name": "XXXXX",
                    "middle_name1": "",
                    "middle_name2": "",
                    "middle_name3": "",
                    "gender_code": "1",
                    "incometaxpan": "XXXXX",
                    "pan_issue_date": "",
                    "pan_expiration_date": "",
                    "passport_number": "",
                    "passport_issue_date": "",
                    "passport_expiration_date": "",
                    "voter_s_identity_card": "",
                    "voter_id_issue_date": "",
                    "voter_id_expiration_date": "",
                    "driver_license_number": "",
                    "driver_license_issue_date": "",
                    "driver_license_expiration_date": "",
                    "ration_card_number": "",
                    "ration_card_issue_date": "",
                    "ration_card_expiration_date": "",
                    "universal_id_number": "",
                    "universal_id_issue_date": "",
                    "universal_id_expiration_date": "",
                    "date_of_birth_applicant": "19980311",
                    "telephone_number_applicant_1st": "",
                    "telephone_extension": "",
                    "telephone_type": "",
                    "mobilephonenumber": "XXXXX",
                    "emailid": ""
                },
                "current_other_details": {
                    "income": "",
                    "marital_status": "",
                    "employment_status": "",
                    "time_with_employer": "",
                    "number_of_major_credit_card_held": ""
                },
                "current_applicant_address_details": {
                    "flatnoplotnohouseno": "vill-mahthin tola Baligaon  Bhojpur",
                    "bldgnosocietyname": "",
                    "roadnonamearealocality": "",
                    "city": "Bhojpur",
                    "landmark": "",
                    "state": "10",
                    "pincode": "802203",
                    "country_code": "IB"
                },
                "current_applicant_additional_address_details": ""
            }
        },
        "cais_account": {
            "cais_summary": {
                "credit_account": {
                    "creditaccounttotal": "43",
                    "creditaccountactive": "10",
                    "creditaccountdefault": "0",
                    "creditaccountclosed": "33",
                    "cadsuitfiledcurrentbalance": "0"
                },
                "total_outstanding_balance": {
                    "outstanding_balance_secured": "0",
                    "outstanding_balance_secured_percentage": "0",
                    "outstanding_balance_unsecured": "6722",
                    "outstanding_balance_unsecured_percentage": "32",
                    "outstanding_balance_all": "20844"
                }
            },
            "cais_account_details": [
                {
                    "identification_number": "NBFXXXXXXXX",
                    "subscriber_name": "XXXXXXXXXX",
                    "account_number": "XXXXXXXXXXXXXXXXXX2826",
                    "portfolio_type": "I",
                    "account_type": "69",
                    "open_date": "20250218",
                    "highest_credit_or_original_loan_amount": "2000",
                    "terms_duration": "006",
                    "terms_frequency": "M",
                    "scheduled_monthly_payment_amount": "",
                    "account_status": "97",
                    "payment_rating": "6",
                    "payment_history_profile": "666666543210S???????????????????????",
                    "special_comment": "",
                    "current_balance": "2000",
                    "amount_past_due": "2576",
                    "original_charge_off_amount": "",
                    "date_reported": "20260331",
                    "date_of_first_delinquency": "",
                    "date_closed": "",
                    "date_of_last_payment": "",
                    "suitfiledwillfuldefaultwrittenoffstatus": "",
                    "suitfiled_wilfuldefault": "",
                    "written_off_settled_status": "02",
                    "value_of_credits_last_month": "",
                    "occupation_code": "",
                    "settlement_amount": "",
                    "value_of_collateral": "",
                    "type_of_collateral": "",
                    "written_off_amt_total": "2576",
                    "written_off_amt_principal": "2000",
                    "rate_of_interest": "",
                    "repayment_tenure": "6",
                    "promotional_rate_flag": "",
                    "income": "",
                    "income_indicator": "",
                    "income_frequency_indicator": "",
                    "defaultstatusdate": "",
                    "litigationstatusdate": "",
                    "writeoffstatusdate": "",
                    "dateofaddition": "20250223",
                    "currencycode": "INR",
                    "subscriber_comments": "",
                    "consumer_comments": "",
                    "accountholdertypecode": "1",
                    "cais_account_history": [
                        {
                            "year": "2026",
                            "month": "03",
                            "days_past_due": "380",
                            "asset_classification": "?"
                        },
                        {
                            "year": "2026",
                            "month": "02",
                            "days_past_due": "349",
                            "asset_classification": "?"
                        }
                    ],
                    "cais_holder_details": [
                        {
                            "surname_non_normalized": "XXXXX",
                            "first_name_non_normalized": "",
                            "middle_name_1_non_normalized": "",
                            "middle_name_2_non_normalized": "",
                            "middle_name_3_non_normalized": "",
                            "alias": "",
                            "gender_code": "1",
                            "income_tax_pan": "XXXXX",
                            "date_of_birth": "19980311"
                        }
                    ],
                    "cais_holder_address_details": {
                        "first_line_of_address_non_normalized": "VILL-MAHTHIN TOLA BALIGAON BHOJPUR BIHAR",
                        "second_line_of_address_non_normalized": "802203",
                        "third_line_of_address_non_normalized": "",
                        "city_non_normalized": "",
                        "fifth_line_of_address_non_normalized": "",
                        "state_non_normalized": "10",
                        "zip_postal_code_non_normalized": "802203",
                        "countrycode_non_normalized": "IB",
                        "address_indicator_non_normalized": "01",
                        "residence_code_non_normalized": ""
                    },
                    "cais_holder_phone_details": {
                        "telephone_number": "",
                        "telephone_type": "01",
                        "mobile_telephone_number": "XXXXX",
                        "emailid": "OMKARBABU4@GMAIL.COM"
                    },
                    "cais_holder_id_details": {
                        "income_tax_pan": "XXXXX",
                        "pan_issue_date": "",
                        "pan_expiration_date": "",
                        "driver_license_number": "",
                        "driver_license_issue_date": "",
                        "driver_license_expiration_date": "",
                        "emailid": "OMKARBABU4@GMAIL.COM"
                    }
                }
            ]
        },
        "match_result": {
            "exact_match": "Y"
        },
        "totalcaps_summary": {
            "totalcapslast7days": "7",
            "totalcapslast30days": "7",
            "totalcapslast90days": "7",
            "totalcapslast180days": "7"
        },
        "caps": {
            "caps_summary": {
                "capslast7days": "1",
                "capslast30days": "1",
                "capslast90days": "1",
                "capslast180days": "1"
            },
            "caps_application_details": {
                "subscriber_code": "274141",
                "subscriber_name": "",
                "date_of_request": "20260414",
                "reporttime": "072734",
                "reportnumber": "1776131854052",
                "enquiry_reason": "6",
                "finance_purpose": "",
                "amount_financed": "0",
                "duration_of_agreement": "0",
                "caps_applicant_details": {
                    "last_name": "",
                    "first_name": "",
                    "middle_name1": "",
                    "middle_name2": "",
                    "middle_name3": "",
                    "gender_code": "",
                    "date_of_birth_applicant": "",
                    "telephone_number_applicant_1st": "",
                    "telephone_extension": "",
                    "telephone_type": "",
                    "emailid": ""
                },
                "caps_other_details": {
                    "income": "",
                    "marital_status": "",
                    "employment_status": "",
                    "time_with_employer": "",
                    "number_of_major_credit_card_held": ""
                },
                "caps_applicant_address_details": {
                    "flatnoplotnohouseno": "",
                    "bldgnosocietyname": "",
                    "roadnonamearealocality": "",
                    "city": "",
                    "landmark": "",
                    "state": "",
                    "pincode": "",
                    "country_code": "IB"
                },
                "caps_applicant_additional_address_details": ""
            }
        },
        "noncreditcaps": {
            "noncreditcaps_summary": {
                "noncreditcapslast7days": "6",
                "noncreditcapslast30days": "6",
                "noncreditcapslast90days": "6",
                "noncreditcapslast180days": "6"
            },
            "caps_application_details": [
                {
                    "subscriber_code": "",
                    "subscriber_name": "",
                    "date_of_request": "20250314",
                    "reporttime": "084033",
                    "reportnumber": "1741921833253",
                    "enquiry_reason": "99",
                    "finance_purpose": "99",
                    "amount_financed": "0",
                    "duration_of_agreement": "0",
                    "caps_applicant_details": {
                        "last_name": "XXXXX",
                        "first_name": "XXXXX",
                        "middle_name1": "",
                        "middle_name2": "",
                        "middle_name3": "",
                        "gender_code": "",
                        "date_of_birth_applicant": "",
                        "telephone_type": "01",
                        "mobilephonenumber": "XXXXX",
                        "emailid": ""
                    },
                    "caps_other_details": {
                        "income": "",
                        "marital_status": "",
                        "employment_status": "",
                        "time_with_employer": "",
                        "number_of_major_credit_card_held": ""
                    },
                    "caps_applicant_address_details": {
                        "flatnoplotnohouseno": "apartment",
                        "bldgnosocietyname": "",
                        "roadnonamearealocality": "",
                        "city": "",
                        "landmark": "",
                        "state": "",
                        "pincode": "",
                        "country_code": "IB"
                    },
                    "caps_applicant_additional_address_details": ""
                }
            ]
        },
        "score": {
            "bureauscore": "517",
            "bureauscoreconfidlevel": "",
            "creditrating": ""
        }
    }
}
```


### `experian_xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
<soapenv:Header/>
<soapenv:Body>
<processResponse xmlns="http://nextgenws.ngwsconnect.experian.com">
<processReturn>
<INProfileResponse>
  <Header>
    <SystemCode>0</SystemCode>
    <MessageText></MessageText>
    <ReportDate>20260419</ReportDate>
    <ReportTime>174707</ReportTime>
  </Header>
  <UserMessage>
    <UserMessageText>Normal Response</UserMessageText>
  </UserMessage>
  <CreditProfileHeader>
    <Enquiry_Username>XXXX</Enquiry_Username>
    <ReportDate>20260419</ReportDate>
    <ReportTime>174707</ReportTime>
    <Version>V2.4</Version>
    <ReportNumber>XXXX</ReportNumber>
    <Subscriber></Subscriber>
    <Subscriber_Name>XXXX</Subscriber_Name>
    <CustomerReferenceID></CustomerReferenceID>
  </CreditProfileHeader>
  <Current_Application>
    <Current_Application_Details>
      <Enquiry_Reason>6</Enquiry_Reason>
      <Finance_Purpose>22</Finance_Purpose>
      <Amount_Financed>0</Amount_Financed>
      <Duration_Of_Agreement>1</Duration_Of_Agreement>
      <Current_Applicant_Details>
        <Last_Name>XXXX</Last_Name>
        <First_Name>XXXX</First_Name>
        <Middle_Name1></Middle_Name1>
        <Middle_Name2></Middle_Name2>
        <Middle_Name3></Middle_Name3>
        <Gender_Code>2</Gender_Code>
        <IncomeTaxPan>XXXX</IncomeTaxPan>
        <PAN_Issue_Date></PAN_Issue_Date>
        <PAN_Expiration_Date></PAN_Expiration_Date>
        <Passport_Number></Passport_Number>
        <Passport_Issue_Date></Passport_Issue_Date>
        <Passport_Expiration_Date></Passport_Expiration_Date>
        <Voter_s_Identity_Card></Voter_s_Identity_Card>
        <Voter_ID_Issue_Date></Voter_ID_Issue_Date>
        <Voter_ID_Expiration_Date></Voter_ID_Expiration_Date>
        <Driver_License_Number></Driver_License_Number>
        <Driver_License_Issue_Date></Driver_License_Issue_Date>
        <Driver_License_Expiration_Date></Driver_License_Expiration_Date>
        <Ration_Card_Number></Ration_Card_Number>
        <Ration_Card_Issue_Date></Ration_Card_Issue_Date>
        <Ration_Card_Expiration_Date></Ration_Card_Expiration_Date>
        <Universal_ID_Number></Universal_ID_Number>
        <Universal_ID_Issue_Date></Universal_ID_Issue_Date>
        <Universal_ID_Expiration_Date></Universal_ID_Expiration_Date>
        <Date_Of_Birth_Applicant>19920604</Date_Of_Birth_Applicant>
        <Telephone_Number_Applicant_1st>9535705915</Telephone_Number_Applicant_1st>
        <Telephone_Extension></Telephone_Extension>
        <Telephone_Type></Telephone_Type>
        <MobilePhoneNumber></MobilePhoneNumber>
        <EMailId></EMailId>
      </Current_Applicant_Details>
      <Current_Other_Details>
        <Income>0</Income>
        <Marital_Status></Marital_Status>
        <Employment_Status></Employment_Status>
        <Time_with_Employer></Time_with_Employer>
        <Number_of_Major_Credit_Card_Held></Number_of_Major_Credit_Card_Held>
      </Current_Other_Details>
      <Current_Applicant_Address_Details>
        <FlatNoPlotNoHouseNo>3rd FloorG</FlatNoPlotNoHouseNo>
        <BldgNoSocietyName>WORKBAE COWORKING</BldgNoSocietyName>
        <RoadNoNameAreaLocality>K22 SL MARG TONK ROAD</RoadNoNameAreaLocality>
        <City>Jaipur</City>
        <Landmark></Landmark>
        <State>08</State>
        <PINCode>302001</PINCode>
        <Country_Code>IB</Country_Code>
      </Current_Applicant_Address_Details>
      <Current_Applicant_Additional_AddressDetails></Current_Applicant_Additional_AddressDetails>
    </Current_Application_Details>
  </Current_Application>
  <CAIS_Account>
    <CAIS_Summary>
      <Credit_Account>
        <CreditAccountTotal>335</CreditAccountTotal>
        <CreditAccountActive>15</CreditAccountActive>
        <CreditAccountDefault>0</CreditAccountDefault>
        <CreditAccountClosed>320</CreditAccountClosed>
        <CADSuitFiledCurrentBalance>0</CADSuitFiledCurrentBalance>
      </Credit_Account>
      <Total_Outstanding_Balance>
        <Outstanding_Balance_Secured>9770166</Outstanding_Balance_Secured>
        <Outstanding_Balance_Secured_Percentage>71</Outstanding_Balance_Secured_Percentage>
        <Outstanding_Balance_UnSecured>2700811</Outstanding_Balance_UnSecured>
        <Outstanding_Balance_UnSecured_Percentage>20</Outstanding_Balance_UnSecured_Percentage>
        <Outstanding_Balance_All>13665032</Outstanding_Balance_All>
      </Total_Outstanding_Balance>
    </CAIS_Summary>
    <CAIS_Account_DETAILS>
      <Identification_Number>XXXX</Identification_Number>
      <Subscriber_Name>XXXXXXXXXX</Subscriber_Name>
      <Account_Number>XXXXXXXXXXXXX4601</Account_Number>
      <Portfolio_Type>I</Portfolio_Type>
      <Account_Type>03</Account_Type>
      <Open_Date>20260329</Open_Date>
      <Credit_Limit_Amount></Credit_Limit_Amount>
      <Highest_Credit_or_Original_Loan_Amount>9191151</Highest_Credit_or_Original_Loan_Amount>
      <Terms_Duration>180</Terms_Duration>
      <Terms_Frequency>M</Terms_Frequency>
      <Scheduled_Monthly_Payment_Amount></Scheduled_Monthly_Payment_Amount>
      <Account_Status>11</Account_Status>
      <Payment_Rating>0</Payment_Rating>
      <Payment_History_Profile>0???????????????????????????????????</Payment_History_Profile>
      <Special_Comment></Special_Comment>
      <Current_Balance>8202553</Current_Balance>
      <Amount_Past_Due>0</Amount_Past_Due>
      <Original_Charge_Off_Amount></Original_Charge_Off_Amount>
      <Date_Reported>20260411</Date_Reported>
      <Date_of_First_Delinquency></Date_of_First_Delinquency>
      <Date_Closed></Date_Closed>
      <Date_of_Last_Payment>20260405</Date_of_Last_Payment>
      <SuitFiledWillfulDefaultWrittenOffStatus></SuitFiledWillfulDefaultWrittenOffStatus>
      <SuitFiled_WillfulDefault></SuitFiled_WillfulDefault>
      <Written_off_Settled_Status></Written_off_Settled_Status>
      <Value_of_Credits_Last_Month></Value_of_Credits_Last_Month>
      <Occupation_Code></Occupation_Code>
      <Settlement_Amount></Settlement_Amount>
      <Value_of_Collateral></Value_of_Collateral>
      <Type_of_Collateral>06</Type_of_Collateral>
      <Written_Off_Amt_Total></Written_Off_Amt_Total>
      <Written_Off_Amt_Principal></Written_Off_Amt_Principal>
      <Rate_of_Interest>12.000</Rate_of_Interest>
      <Repayment_Tenure>180</Repayment_Tenure>
      <Promotional_Rate_Flag></Promotional_Rate_Flag>
      <Income></Income>
      <Income_Indicator></Income_Indicator>
      <Income_Frequency_Indicator></Income_Frequency_Indicator>
      <DefaultStatusDate></DefaultStatusDate>
      <LitigationStatusDate></LitigationStatusDate>
      <WriteOffStatusDate></WriteOffStatusDate>
      <DateOfAddition>20260331</DateOfAddition>
      <CurrencyCode>INR</CurrencyCode>
      <Subscriber_comments></Subscriber_comments>
      <Consumer_comments></Consumer_comments>
      <AccountHoldertypeCode>2</AccountHoldertypeCode>
      <CAIS_Account_History>
        <Year>2026</Year>
        <Month>04</Month>
        <Days_Past_Due>0</Days_Past_Due>
        <Asset_Classification>?</Asset_Classification>
      </CAIS_Account_History>
      <CAIS_Account_History>
        <Year>2026</Year>
        <Month>03</Month>
        <Days_Past_Due>0</Days_Past_Due>
        <Asset_Classification>?</Asset_Classification>
      </CAIS_Account_History>
      <CAIS_Holder_Details>
        <Surname_Non_Normalized>XXXX</Surname_Non_Normalized>
        <First_Name_Non_Normalized>XXXX</First_Name_Non_Normalized>
        <Middle_Name_1_Non_Normalized></Middle_Name_1_Non_Normalized>
        <Middle_Name_2_Non_Normalized></Middle_Name_2_Non_Normalized>
        <Middle_Name_3_Non_Normalized></Middle_Name_3_Non_Normalized>
        <Alias></Alias>
        <Gender_Code>1</Gender_Code>
        <Income_TAX_PAN>XXXX</Income_TAX_PAN>
        <Passport_Number></Passport_Number>
        <Voter_ID_Number></Voter_ID_Number>
        <Date_of_birth>19920604</Date_of_birth>
      </CAIS_Holder_Details>
      <CAIS_Holder_Address_Details>
        <First_Line_Of_Address_non_normalized>NO 10 VEERAPURA CHANNAGIRI DAVANAGERE</First_Line_Of_Address_non_normalized>
        <Second_Line_Of_Address_non_normalized>MAIN ROAD DAVANGERE KARNATAKA</Second_Line_Of_Address_non_normalized>
        <Third_Line_Of_Address_non_normalized></Third_Line_Of_Address_non_normalized>
        <City_non_normalized></City_non_normalized>
        <Fifth_Line_Of_Address_non_normalized></Fifth_Line_Of_Address_non_normalized>
        <State_non_normalized>29</State_non_normalized>
        <ZIP_Postal_Code_non_normalized>577213</ZIP_Postal_Code_non_normalized>
        <CountryCode_non_normalized>IB</CountryCode_non_normalized>
        <Address_indicator_non_normalized>03</Address_indicator_non_normalized>
        <Residence_code_non_normalized></Residence_code_non_normalized>
      </CAIS_Holder_Address_Details>
      <CAIS_Holder_Address_Details>
        <First_Line_Of_Address_non_normalized>CO HALESHAPPA V V NO 10 VIRAPURA</First_Line_Of_Address_non_normalized>
        <Second_Line_Of_Address_non_normalized>CHANNAGIRI TALUK DURVEGERE PO DURVEGERE</Second_Line_Of_Address_non_normalized>
        <Third_Line_Of_Address_non_normalized>DIST DAVANGERE MAIN ROAD DAVANGERE</Third_Line_Of_Address_non_normalized>
        <City_non_normalized>KARNATAKA</City_non_normalized>
        <Fifth_Line_Of_Address_non_normalized></Fifth_Line_Of_Address_non_normalized>
        <State_non_normalized>29</State_non_normalized>
        <ZIP_Postal_Code_non_normalized>577213</ZIP_Postal_Code_non_normalized>
        <CountryCode_non_normalized>IB</CountryCode_non_normalized>
        <Address_indicator_non_normalized>01</Address_indicator_non_normalized>
        <Residence_code_non_normalized></Residence_code_non_normalized>
      </CAIS_Holder_Address_Details>
      <CAIS_Holder_Phone_Details>
        <Telephone_Number>XXXX</Telephone_Number>
        <Telephone_Type>02</Telephone_Type>
        <Telephone_Extension></Telephone_Extension>
        <Mobile_Telephone_Number></Mobile_Telephone_Number>
        <FaxNumber></FaxNumber>
        <EMailId></EMailId>
      </CAIS_Holder_Phone_Details>
      <CAIS_Holder_ID_Details>
        <Income_TAX_PAN>XXXX</Income_TAX_PAN>
        <PAN_Issue_Date></PAN_Issue_Date>
        <PAN_Expiration_Date></PAN_Expiration_Date>
        <Passport_Number></Passport_Number>
        <Passport_Issue_Date></Passport_Issue_Date>
        <Passport_Expiration_Date></Passport_Expiration_Date>
        <Voter_ID_Number></Voter_ID_Number>
        <Voter_ID_Issue_Date></Voter_ID_Issue_Date>
        <Voter_ID_Expiration_Date></Voter_ID_Expiration_Date>
        <Driver_License_Number></Driver_License_Number>
        <Driver_License_Issue_Date></Driver_License_Issue_Date>
        <Driver_License_Expiration_Date></Driver_License_Expiration_Date>
        <Ration_Card_Number></Ration_Card_Number>
        <Ration_Card_Issue_Date></Ration_Card_Issue_Date>
        <Ration_Card_Expiration_Date></Ration_Card_Expiration_Date>
        <Universal_ID_Number></Universal_ID_Number>
        <Universal_ID_Issue_Date></Universal_ID_Issue_Date>
        <Universal_ID_Expiration_Date></Universal_ID_Expiration_Date>
        <EMailId></EMailId>
      </CAIS_Holder_ID_Details>
      <Account_Review_Data>
        <Year>2026</Year>
        <Month>4</Month>
        <Account_Status>11</Account_Status>
        <Actual_Payment_Amount></Actual_Payment_Amount>
        <Current_Balance>8202553</Current_Balance>
        <Credit_Limit_Amount>9191151</Credit_Limit_Amount>
        <Amount_Past_Due>0</Amount_Past_Due>
        <Cash_Limit></Cash_Limit>
        <EMI_Amount></EMI_Amount>
      </Account_Review_Data>
    </CAIS_Account_DETAILS>
  </CAIS_Account>
  <Match_result>
    <Exact_match>Y</Exact_match>
  </Match_result>
  <TotalCAPS_Summary>
    <TotalCAPSLast7Days>53</TotalCAPSLast7Days>
    <TotalCAPSLast30Days>53</TotalCAPSLast30Days>
    <TotalCAPSLast90Days>55</TotalCAPSLast90Days>
    <TotalCAPSLast180Days>57</TotalCAPSLast180Days>
  </TotalCAPS_Summary>
  <CAPS>
    <CAPS_Summary>
      <CAPSLast7Days>0</CAPSLast7Days>
      <CAPSLast30Days>0</CAPSLast30Days>
      <CAPSLast90Days>2</CAPSLast90Days>
      <CAPSLast180Days>4</CAPSLast180Days>
    </CAPS_Summary>
    <CAPS_Application_Details>
      <Subscriber_code>XXXX</Subscriber_code>
      <Subscriber_Name>XXXXXXXXXX</Subscriber_Name>
      <Date_of_Request>20260215</Date_of_Request>
      <ReportTime>160438</ReportTime>
      <ReportNumber>XXXX</ReportNumber>
      <Enquiry_Reason>13</Enquiry_Reason>
      <Finance_Purpose></Finance_Purpose>
      <Amount_Financed>5000</Amount_Financed>
      <Duration_Of_Agreement>6</Duration_Of_Agreement>
    </CAPS_Application_Details>
  </CAPS>
  <NonCreditCAPS>
    <NonCreditCAPS_Summary>
      <NonCreditCAPSLast7Days>53</NonCreditCAPSLast7Days>
      <NonCreditCAPSLast30Days>53</NonCreditCAPSLast30Days>
      <NonCreditCAPSLast90Days>53</NonCreditCAPSLast90Days>
      <NonCreditCAPSLast180Days>53</NonCreditCAPSLast180Days>
    </NonCreditCAPS_Summary>
    <CAPS_Application_Details>
      <Subscriber_code>NBF2445</Subscriber_code>
      <Subscriber_Name>Weekline Investment and Trading Company Limited</Subscriber_Name>
      <Date_of_Request>20260419</Date_of_Request>
      <ReportTime>174702</ReportTime>
      <ReportNumber>1776601022304</ReportNumber>
      <Enquiry_Reason>6</Enquiry_Reason>
      <Finance_Purpose>22</Finance_Purpose>
      <Amount_Financed>0</Amount_Financed>
      <Duration_Of_Agreement>1</Duration_Of_Agreement>
    </CAPS_Application_Details>
  </NonCreditCAPS>
  <SCORE>
    <BureauScore>684</BureauScore>
    <BureauScoreConfidLevel></BureauScoreConfidLevel>
  </SCORE>
</INProfileResponse>
</processReturn></processResponse></soapenv:Body></soapenv:Envelope>
```


### `experian_scrub_parser`

The scrub format expects 3 DataFrame tables — tradelines, scores, and enquiries. The column descriptions for each are mentioned below.

#### Tradelines

| Column | Description |
|---|---|
| `customer_id` | Unique identifier of the customer |
| `account_nb` | Account number reported by the lender |
| `account_type` | Type of credit account (e.g. Consumer Loan, Personal Loan) |
| `m_sub_id` | Subscriber or member identifier of the reporting institution |
| `open_dt` | Date the account was opened |
| `closed_dt` | Date the account was closed |
| `balance_dt` | Date the balance was last reported |
| `balance_am` | Current outstanding balance on the account |
| `orig_loan_am` | Original loan amount sanctioned |
| `credit_limit_am` | Credit limit on the account |
| `past_due_am` | Amount currently past due on the account |
| `written_off_amt_total` | Total written-off amount on the account |
| `written_off_amt_principal` | Written-off principal amount on the account |
| `last_payment_dt` | Date of the last payment made |
| `actual_payment_am` | Amount of the last actual payment made |
| `interest_rate` | Rate of interest on the account |
| `cash_limit` | Cash withdrawal limit on the account |
| `tenure` | Repayment tenure of the account |
| `payment_frequency` | Frequency of payments (e.g. Monthly, Weekly) |
| `settlement_amount` | Settlement amount, if the account was settled |
| `written_off_and_settled_status` | Written-off or settled status of the account |
| `suit_filed_willful_dflt` | Suit filed or wilful default status on the account |
| `asset_class` | Asset classification for the account |
| `days_past_due_01` | Days past due for month 1 (historical payment history) |
| `days_past_due_02` | Days past due for month 2 (historical payment history) |
| `days_past_due_03` | Days past due for month 3 (historical payment history) |
| `days_past_due_04` | Days past due for month 4 (historical payment history) |
| `days_past_due_05` | Days past due for month 5 (historical payment history) |
| `days_past_due_06` | Days past due for month 6 (historical payment history) |
| `days_past_due_07` | Days past due for month 7 (historical payment history) |
| `days_past_due_08` | Days past due for month 8 (historical payment history) |
| `days_past_due_09` | Days past due for month 9 (historical payment history) |
| `days_past_due_10` | Days past due for month 10 (historical payment history) |
| `days_past_due_11` | Days past due for month 11 (historical payment history) |
| `days_past_due_12` | Days past due for month 12 (historical payment history) |
| `days_past_due_13` | Days past due for month 13 (historical payment history) |
| `days_past_due_14` | Days past due for month 14 (historical payment history) |
| `days_past_due_15` | Days past due for month 15 (historical payment history) |
| `days_past_due_16` | Days past due for month 16 (historical payment history) |
| `days_past_due_17` | Days past due for month 17 (historical payment history) |
| `days_past_due_18` | Days past due for month 18 (historical payment history) |
| `days_past_due_19` | Days past due for month 19 (historical payment history) |
| `days_past_due_20` | Days past due for month 20 (historical payment history) |
| `days_past_due_21` | Days past due for month 21 (historical payment history) |
| `days_past_due_22` | Days past due for month 22 (historical payment history) |
| `days_past_due_23` | Days past due for month 23 (historical payment history) |
| `days_past_due_24` | Days past due for month 24 (historical payment history) |
| `days_past_due_25` | Days past due for month 25 (historical payment history) |
| `days_past_due_26` | Days past due for month 26 (historical payment history) |
| `days_past_due_27` | Days past due for month 27 (historical payment history) |
| `days_past_due_28` | Days past due for month 28 (historical payment history) |
| `days_past_due_29` | Days past due for month 29 (historical payment history) |
| `days_past_due_30` | Days past due for month 30 (historical payment history) |
| `days_past_due_31` | Days past due for month 31 (historical payment history) |
| `days_past_due_32` | Days past due for month 32 (historical payment history) |
| `days_past_due_33` | Days past due for month 33 (historical payment history) |
| `days_past_due_34` | Days past due for month 34 (historical payment history) |
| `days_past_due_35` | Days past due for month 35 (historical payment history) |
| `days_past_due_36` | Days past due for month 36 (historical payment history) |

#### Enquiries

| Column | Description |
|---|---|
| `customer_id` | Unique identifier of the customer |
| `inquiry_purpose` | Purpose of the credit inquiry |
| `m_sub_id` | Subscriber or member identifier of the inquiring institution |
| `amount` | Amount for which the inquiry was made |
| `inq_date` | Date of the inquiry |

#### Scores

| Column | Description |
|---|---|
| `customer_id` | Unique identifier of the customer |
| `score` | Bureau credit score for the customer |

#### Sample Values

The sample values below illustrate the expected data types and formats for each table. Use these as a reference when preparing scrub data for the parser.

#### Tradelines

<div markdown="0">
<table>
<thead>
<tr><th>Column</th><th>Sample Value</th></tr>
</thead>
<tbody>
    <tr><th><code>customer_id</code></th><td>AB32843931</td></tr>
    <tr><th><code>account_nb</code></th><td>XXXX</td></tr>
    <tr><th><code>account_type</code></th><td>Consumer Loan</td></tr>
    <tr><th><code>m_sub_id</code></th><td>NBF</td></tr>
    <tr><th><code>open_dt</code></th><td>2025-01-24</td></tr>
    <tr><th><code>closed_dt</code></th><td>2026-02-01</td></tr>
    <tr><th><code>balance_dt</code></th><td>2026-02-28</td></tr>
    <tr><th><code>balance_am</code></th><td>0.0</td></tr>
    <tr><th><code>orig_loan_am</code></th><td>1499.0</td></tr>
    <tr><th><code>credit_limit_am</code></th><td>1499.0</td></tr>
    <tr><th><code>past_due_am</code></th><td>0.0</td></tr>
    <tr><th><code>written_off_amt_total</code></th><td>NaN</td></tr>
    <tr><th><code>written_off_amt_principal</code></th><td>NaN</td></tr>
    <tr><th><code>last_payment_dt</code></th><td>2026-02-01</td></tr>
    <tr><th><code>actual_payment_am</code></th><td>0.0</td></tr>
    <tr><th><code>interest_rate</code></th><td>NaN</td></tr>
    <tr><th><code>cash_limit</code></th><td>NaN</td></tr>
    <tr><th><code>tenure</code></th><td>NaN</td></tr>
    <tr><th><code>payment_frequency</code></th><td>Monthly</td></tr>
    <tr><th><code>settlement_amount</code></th><td>NaN</td></tr>
    <tr><th><code>written_off_and_settled_status</code></th><td>Settled</td></tr>
    <tr><th><code>suit_filed_willful_dflt</code></th><td>NaN</td></tr>
    <tr><th><code>asset_class</code></th><td>NaN</td></tr>
    <tr><th><code>days_past_due_01</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_02</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_03</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_04</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_05</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_06</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_07</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_08</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_09</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_10</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_11</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_12</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_13</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_14</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_15</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_16</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_17</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_18</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_19</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_20</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_21</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_22</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_23</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_24</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_25</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_26</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_27</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_28</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_29</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_30</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_31</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_32</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_33</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_34</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_35</code></th><td>0.0</td></tr>
    <tr><th><code>days_past_due_36</code></th><td>0.0</td></tr>
</tbody>
</table>
</div>

The following are the expected values for `account_type`:

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

The following are the expected values for `payment_frequency`:

1. Fortnightly
2. Monthly
3. Quarterly
4. Weekly

The following are the expected values for `written_off_and_settled_status`:

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

The following are the expected values for `suit_filed_willful_dflt`:

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
    <tr><th><code>customer_id</code></th><td>AB32843931</td></tr>
    <tr><th><code>inquiry_purpose</code></th><td>Personal Loan</td></tr>
    <tr><th><code>m_sub_id</code></th><td>NBF</td></tr>
    <tr><th><code>amount</code></th><td>20000</td></tr>
    <tr><th><code>inq_date</code></th><td>2025-12-13</td></tr>
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
    <tr><th><code>customer_id</code></th><td>AB32843931</td></tr>
    <tr><th><code>score</code></th><td>628</td></tr>
</tbody>
</table>
</div>
