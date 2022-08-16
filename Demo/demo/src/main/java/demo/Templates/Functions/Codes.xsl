<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:hl7="urn:hl7-org:v2xml"
                xmlns:foo="http://whatever"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:map="http://www.w3.org/2005/xpath-functions/map"
                xmlns:xs="http://www.w3.org/2001/XMLSchema">
     <xsl:output method="text" encoding="UTF-8"/>
     <!-- Call from main template with:
          <xsl:call-template name="codeInfo">
          <xsl:with-param name="systemParam" select="'CodeSystem/{Type}'"/>
          <xsl:with-param name="codeParam" select="{path/to/code}"/>
          <xsl:with-param name="whichParam" select="'{output}'"/>
          </xsl:call-template> 
     -->
     
     <!-- CodeSystem content from FHIR-Converter, has some Issues
          that should be worked out, only affected tiny number of codes
          so not highest priority. This currently holds codes for the
          IDType, AccessRestrictionValue, AccessRestrictionReason, 
          CodeSystemUrl, Gender, AddressType, TelecomUseCode, 
          TelecomEquipmentType, MaritalStatus, Language, Yes_No,
          RegistryStatus, ContactRole, and NameType
          
          TODO: ADD ERROR HANDLING
          
          Issues with large CodeSystem content from FHIR-Converter:
          1. Some &'s need to be escaped - see if this works
          2. Some <> need to be resolved in CodeSystemRepeatPattern
          3. <integer> complexity - 2 codes take in an integer and
          use it as part of their display value -->
     <xsl:variable name="CodeSystem">
          {
          "Mapping": {
          "CodeSystem/ContactRole": {
          "C": {
          "code": "C", 
          "display": "Emergency Contact", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0131"
          }, 
          "E": {
          "code": "E", 
          "display": "Employer", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0131"
          }, 
          "F": {
          "code": "F", 
          "display": "Federal Agency", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0131"
          }, 
          "I": {
          "code": "I", 
          "display": "Insurance Company", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0131"
          }, 
          "O": {
          "code": "O", 
          "display": "Other", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0131"
          }, 
          "N": {
          "code": "N", 
          "display": "Next-of-Kin", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0131"
          }, 
          "S": {
          "code": "S", 
          "display": "State Agency", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0131"
          }, 
          "U": {
          "code": "U", 
          "display": "Unknown", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0131"
          }
          },
          "CodeSystem/RegistryStatus": {
          "A": {
          "code": "true", 
          "display": "", 
          "system": ""
          }, 
          "I": {
          "code": "false", 
          "display": "", 
          "system": ""
          }, 
          "M": {
          "code": "false", 
          "display": "", 
          "system": ""
          }, 
          "L": {
          "code": "false", 
          "display": "", 
          "system": ""
          }, 
          "O": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "P": {
          "code": "false", 
          "display": "", 
          "system": ""
          }, 
          "U": {
          "code": "", 
          "display": "", 
          "system": ""
          }
          },
          "CodeSystem/Yes_No": {
          "Y": {
          "code": "true", 
          "display": "", 
          "system": ""
          }, 
          "N": {
          "code": "false", 
          "display": "", 
          "system": ""
          }, 
          "__default__": {
          "code": "false",
          "display": "",
          "system": ""
          }
          },
          "CodeSystem/Language": {
          "ara": {
          "code" : "ar",
          "display" : "Arabic",
          "system" : "urn:ietf:bcp:47"
          },
          "ben":{
          "code" : "bn",
          "display" : "Bengali",
          "system" : "urn:ietf:bcp:47"
          },
          "cze": {
          "code" : "cs",
          "display" : "Czech",
          "system" : "urn:ietf:bcp:47"
          },
          "dan": {
          "code" : "da",
          "display" : "Danish",
          "system" : "urn:ietf:bcp:47"
          },
          "ger": {
          "code" : "de",
          "display" : "German",
          "system" : "urn:ietf:bcp:47"
          },
          "gre": {
          "code" : "el",
          "display" : "Greek",
          "system" : "urn:ietf:bcp:47" 
          },
          "eng":{
          "code" : "en",
          "display" : "English",
          "system" : "urn:ietf:bcp:47"
          },
          "spa":{
          "code" : "es",
          "display" : "Spanish",
          "system" : "urn:ietf:bcp:47"
          },
          "fin":{
          "code" : "fi",
          "display" : "Finnish",
          "system" : "urn:ietf:bcp:47"
          },
          "fre":{
          "code" : "fr",
          "display" : "French",
          "system" : "urn:ietf:bcp:47"
          },
          "hin":{
          "code" : "hi",
          "display" : "Hindi",
          "system" : "urn:ietf:bcp:47"
          },
          "hrv":{
          "code" : "hr",
          "display" : "Croatian",
          "system" : "urn:ietf:bcp:47"
          },
          "ita":{
          "code" : "it",
          "display" : "Italian",
          "system" : "urn:ietf:bcp:47"
          },
          "jpn":{
          "code" : "ja",
          "display" : "Japanese",
          "system" : "urn:ietf:bcp:47"
          },
          "kor":{
          "code" : "ko",
          "display" : "Korean",
          "system" : "urn:ietf:bcp:47"
          },
          "dut":{
          "code" : "nl",
          "display" : "Dutch",
          "system" : "urn:ietf:bcp:47"
          },
          "nor":{
          "code" : "no",
          "display" : "Norwegian",
          "system" : "urn:ietf:bcp:47"
          },
          "pan":{
          "code" : "pa",
          "display" : "Punjabi",
          "system" : "urn:ietf:bcp:47"
          },
          "pol":{
          "code" : "pl",
          "display" : "Polish",
          "system" : "urn:ietf:bcp:47"
          },
          "por":{
          "code" : "pt",
          "display" : "Portuguese",
          "system" : "urn:ietf:bcp:47"
          },
          "rus":{
          "code" : "ru",
          "display" : "Russian",
          "system" : "urn:ietf:bcp:47"
          },
          "srp":{
          "code" : "sr",
          "display" : "Serbian",
          "system" : "urn:ietf:bcp:47"
          },
          "swe":{
          "code" : "sv",
          "display" : "Swedish",
          "system" : "urn:ietf:bcp:47"
          },
          "tel":{
          "code" : "te",
          "display" : "Telegu",
          "system" : "urn:ietf:bcp:47"                
          },
          "chi":{
          "code" : "zh",
          "display" : "Chinese",
          "system" : "urn:ietf:bcp:47"
          }
          },
          "CodeSystem/MaritalStatus": {
          "A": {
          "code": "L", 
          "display": "Legally Separated", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "C": {
          "code": "C", 
          "display": "Common Law", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "B": {
          "code": "U", 
          "display": "unmarried", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "E": {
          "code": "L", 
          "display": "Legally Separated", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "D": {
          "code": "D", 
          "display": "Divorced", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "G": {
          "code": "T", 
          "display": "Domestic partner", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "I": {
          "code": "I", 
          "display": "Interlocutory", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "M": {
          "code": "M", 
          "display": "Married", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "O": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "N": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "P": {
          "code": "T", 
          "display": "Domestic partner", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "S": {
          "code": "S", 
          "display": "Never Married", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "R": {
          "code": "T", 
          "display": "Domestic partner", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }, 
          "U": {
          "code": "UNK", 
          "display": "unknown", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
          }, 
          "T": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "W": {
          "code": "W", 
          "display": "Widowed", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-MaritalStatus"
          }
          },
          "CodeSystem/TelecomEquipmentType": {
          "PH": {
          "code" : "phone",
          "display" : "Phone",
          "system" : "http://hl7.org/fhir/contact-point-system"
          }, 
          "FX": {
          "code" : "fax",
          "display" : "Fax",
          "system" : "http://hl7.org/fhir/contact-point-system"
          }, 
          "MD": {
          "code" : "other",
          "display" : "Other",
          "system" : "http://hl7.org/fhir/contact-point-system"
          }, 
          "CP": {
          "code" : "phone",
          "display" : "Phone",
          "system" : "http://hl7.org/fhir/contact-point-system"
          }, 
          "SAT": {
          "code" : "other",
          "display" : "Other",
          "system" : "http://hl7.org/fhir/contact-point-system"
          }, 
          "BP": {
          "code" : "pager",
          "display" : "Pager",
          "system" : "http://hl7.org/fhir/contact-point-system"
          }, 
          "Internet": {
          "code" : "email",
          "display" : "email",
          "system" : "http://hl7.org/fhir/contact-point-system"
          }, 
          "X.400": {
          "code" : "email",
          "display" : "email",
          "system" : "http://hl7.org/fhir/contact-point-system"
          }, 
          "TDD": {
          "code" : "other",
          "display" : "Other",
          "system" : "http://hl7.org/fhir/contact-point-system"
          },
          "TYD" : {
          "code" : "other",
          "display" : "Other",
          "system" : "http://hl7.org/fhir/contact-point-system"
          }
          },
          "CodeSystem/TelecomUseCode": {
          "PRN": {
          "code": "home", 
          "display": "Home", 
          "system": "http://hl7.org/fhir/contact-point-use"
          }, 
          "BPN": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "ORN": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "WPN": {
          "code": "work", 
          "display": "Work", 
          "system": "http://hl7.org/fhir/contact-point-use"
          }, 
          "VHN": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "PRS": {
          "code": "mobile", 
          "display": "Mobile", 
          "system": "http://hl7.org/fhir/contact-point-use"
          }, 
          "EMR": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "NET": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "ASN": {
          "code": "", 
          "display": "", 
          "system": ""
          }
          },
          "CodeSystem/AddressType": {
          "C": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "B": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "BA": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "F": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "BDL": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "V": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "M": {
          "code": "postal", 
          "display": "Postal", 
          "system": "http://hl7.org/fhir/address-type"
          }, 
          "BI": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "O": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "N": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "P": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "S": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "SH": {
          "code": "postal", 
          "display": "Postal", 
          "system": "http://hl7.org/fhir/address-type"
          }, 
          "BR": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "H": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "RH": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "TM": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "L": {
          "code": "", 
          "display": "", 
          "system": ""
          }
          },
          "CodeSystem/Gender": {
          "A": {
          "code": "other", 
          "display": "Other", 
          "system": "http://hl7.org/fhir/administrative-gender"
          }, 
          "F": {
          "code": "female", 
          "display": "Female", 
          "system": "http://hl7.org/fhir/administrative-gender"
          }, 
          "M": {
          "code": "male", 
          "display": "Male", 
          "system": "http://hl7.org/fhir/administrative-gender"
          }, 
          "O": {
          "code": "other", 
          "display": "Other", 
          "system": "http://hl7.org/fhir/administrative-gender"
          }, 
          "N": {
          "code": "other", 
          "display": "Other", 
          "system": "http://hl7.org/fhir/administrative-gender"
          }, 
          "U": {
          "code": "unknown", 
          "display": "Unknown", 
          "system": "http://hl7.org/fhir/administrative-gender"
          }
          },
          "CodeSystem/IDType": {
          "WC": {
          "code": "WC", 
          "display": "WIC identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "BA": {
          "code": "BA", 
          "display": "Bank Account Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "BC": {
          "code": "BC", 
          "display": "Bank Card Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "BR": {
          "code": "BR", 
          "display": "Birth registry number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "SID": {
          "code": "SID", 
          "display": "Specimen ID", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "CONM": {
          "code": "CONM", 
          "display": "Change of Name Document", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PRC": {
          "code": "PRC", 
          "display": "Permanent Resident Card Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PC": {
          "code": "PC", 
          "display": "Parole Card", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PRN": {
          "code": "PRN", 
          "display": "Provider number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "TAX": {
          "code": "TAX", 
          "display": "Tax ID number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "RN": {
          "code": "RN", 
          "display": "Registered Nurse Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "XX": {
          "code": "XX", 
          "display": "Organization identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "RI": {
          "code": "RI", 
          "display": "Resource identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MRT": {
          "code": "MRT", 
          "display": "Temporary Medical Record Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "APRN": {
          "code": "APRN", 
          "display": "Advanced Practice Registered Nurse number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "LACSN": {
          "code": "LACSN", 
          "display": "Laboratory Accession ID", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "TPR": {
          "code": "TPR", 
          "display": "Temporary Permanent Resident (Canada)", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "GN": {
          "code": "GN", 
          "display": "Guarantor external identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "GL": {
          "code": "GL", 
          "display": "General ledger number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "GI": {
          "code": "GI", 
          "display": "Guarantor internal identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "NII": {
          "code": "NII", 
          "display": "National Insurance Organization Identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "NPI": {
          "code": "NPI", 
          "display": "National provider identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "OD": {
          "code": "OD", 
          "display": "Optometrist license number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "SP": {
          "code": "SP", 
          "display": "Study Permit", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "WP": {
          "code": "WP", 
          "display": "Work Permit", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PCN": {
          "code": "PCN", 
          "display": "Penitentiary/correctional institution Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DEA": {
          "code": "DEA", 
          "display": "Drug Enforcement Administration registration number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PT": {
          "code": "PT", 
          "display": "Patient external identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "BRN": {
          "code": "BRN", 
          "display": "Breed Registry Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "AMA": {
          "code": "AMA", 
          "display": "American Medical Association Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "NNxxx": {
          "code": "NNxxx", 
          "display": "National Person Identifier where the xxx is the ISO table 3166 3-character (alphabetic) country code", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PA": {
          "code": "PA", 
          "display": "Physician Assistant number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PE": {
          "code": "PE", 
          "display": "Living Subject Enterprise Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PI": {
          "code": "PI", 
          "display": "Patient internal identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PN": {
          "code": "PN", 
          "display": "Person number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "EN": {
          "code": "EN", 
          "display": "Employer number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "EI": {
          "code": "EI", 
          "display": "Employee number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DDS": {
          "code": "DDS", 
          "display": "Dentist license number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "AND": {
          "code": "AND", 
          "display": "Account number debitor", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MD": {
          "code": "MD", 
          "display": "Medical License number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MA": {
          "code": "MA", 
          "display": "Patient Medicaid number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "RR": {
          "code": "RR", 
          "display": "Railroad Retirement number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MC": {
          "code": "MC", 
          "display": "Patient\u2019s Medicare number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "ANC": {
          "code": "ANC", 
          "display": "Account number Creditor", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MI": {
          "code": "MI", 
          "display": "Military ID number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "ANT": {
          "code": "ANT", 
          "display": "Temporary Account Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "ANON": {
          "code": "ANON", 
          "display": "Anonymous identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MS": {
          "code": "MS", 
          "display": "MasterCard", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MR": {
          "code": "MR", 
          "display": "Medical record number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "IND": {
          "code": "IND", 
          "display": "Indigenous/Aboriginal", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "UPIN": {
          "code": "UPIN", 
          "display": "Medicare/CMS (formerly HCFA)\u2019s Universal Physician Identification numbers", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PEN": {
          "code": "PEN", 
          "display": "Pension Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "BCT": {
          "code": "BCT", 
          "display": "Birth Certificate", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "FI": {
          "code": "FI", 
          "display": "Facility ID", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "NH": {
          "code": "NH", 
          "display": "National Health Plan Identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "NI": {
          "code": "NI", 
          "display": "National unique individual identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "RRI": {
          "code": "RRI", 
          "display": "Regional registry ID", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "NE": {
          "code": "NE", 
          "display": "National employer identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "LANR": {
          "code": "LANR", 
          "display": "Lifelong physician number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "NP": {
          "code": "NP", 
          "display": "Nurse practitioner number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "RRP": {
          "code": "RRP", 
          "display": "Railroad Retirement Provider", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "CC": {
          "code": "CC", 
          "display": "Cost Center number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "CZ": {
          "code": "CZ", 
          "display": "Citizenship Card", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "CY": {
          "code": "CY", 
          "display": "County number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DFN": {
          "code": "DFN", 
          "display": "Drug Furnishing or prescriptive authority Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "SS": {
          "code": "SS", 
          "display": "Social Security number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "SR": {
          "code": "SR", 
          "display": "State registry ID", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MB": {
          "code": "MB", 
          "display": "Member Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PPIN": {
          "code": "PPIN", 
          "display": "Medicare/CMS Performing Provider Identification Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "NIIP": {
          "code": "NIIP", 
          "display": "National Insurance Payor Identifier (Payor)", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "SN": {
          "code": "SN", 
          "display": "Subscriber Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "SL": {
          "code": "SL", 
          "display": "State license", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DN": {
          "code": "DN", 
          "display": "Doctor number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DO": {
          "code": "DO", 
          "display": "Osteopathic License number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DL": {
          "code": "DL", 
          "display": "Driver\u2019s license number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "BSNR": {
          "code": "BSNR", 
          "display": "Primary physician office number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DI": {
          "code": "DI", 
          "display": "Diner\u2019s Club card", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "JHN": {
          "code": "JHN", 
          "display": "Jurisdictional health number (Canada)", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "HC": {
          "code": "HC", 
          "display": "Health Card Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DPM": {
          "code": "DPM", 
          "display": "Podiatrist license number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DR": {
          "code": "DR", 
          "display": "Donor Registration Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DS": {
          "code": "DS", 
          "display": "Discover Card", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "DP": {
          "code": "DP", 
          "display": "Diplomatic Passport", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "USID": {
          "code": "USID", 
          "display": "Unique Specimen ID", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "LN": {
          "code": "LN", 
          "display": "License number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "ASID": {
          "code": "ASID", 
          "display": "Ancestor Specimen ID", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PPN": {
          "code": "PPN", 
          "display": "Passport number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "LI": {
          "code": "LI", 
          "display": "Labor and industries number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "TN": {
          "code": "TN", 
          "display": "Treaty Number/ (Canada)", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "ACSN": {
          "code": "ACSN", 
          "display": "Accession ID", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "LR": {
          "code": "LR", 
          "display": "Local Registry ID", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "RPH": {
          "code": "RPH", 
          "display": "Pharmacist license number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "NBSNR": {
          "code": "NBSNR", 
          "display": "Secondary physician office number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "AM": {
          "code": "AM", 
          "display": "American Express", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "VN": {
          "code": "VN", 
          "display": "Visit number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "AN": {
          "code": "AN", 
          "display": "Account number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "VP": {
          "code": "VP", 
          "display": "Visitor Permit", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "VS": {
          "code": "VS", 
          "display": "VISA", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "U": {
          "code": "U", 
          "display": "Unspecified identifier", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "ESN": {
          "code": "ESN", 
          "display": "Staff Enterprise Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "WCN": {
          "code": "WCN", 
          "display": "Workers\u2019 Comp Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MCN": {
          "code": "MCN", 
          "display": "Microchip Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MCD": {
          "code": "MCD", 
          "display": "Practitioner Medicaid number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "NCT": {
          "code": "NCT", 
          "display": "Naturalization Certificate", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "PNT": {
          "code": "PNT", 
          "display": "Temporary Living Subject Number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "QA": {
          "code": "QA", 
          "display": "QA number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MCT": {
          "code": "MCT", 
          "display": "Marriage Certificate", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }, 
          "MCR": {
          "code": "MCR", 
          "display": "Practitioner Medicare number", 
          "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
          }
          },
          "CodeSystem/AccessRestrictionValue": { 
          "LOC": {
          "code": "LOCIS", 
          "display": "location information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          },             
          "DEM": {
          "code": "DEMO", 
          "display": "all demographic information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          }, 
          "SMD": {
          "code": "R", 
          "display": "restricted", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-Confidentiality"
          }, 
          "DRG": {
          "code": "DRGIS", 
          "display": "drug information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          }, 
          "HIV": {
          "code": "HIV", 
          "display": "HIV/AIDS information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          }, 
          "NO": {
          "code": "U", 
          "display": "unrestricted", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-Confidentiality"
          }, 
          "STD": {
          "code": "STD", 
          "display": "sexually transmitted disease information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          }, 
          "OO": {
          "code": "OPTR", 
          "display": "Opt Out All Registries(HIPAA)", 
          "system": "http://example.com/v2-to-fhir-converter/CodeSystem/additional-security-label"
          }, 
          "ALL": {
          "code": "R", 
          "display": "restricted", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-Confidentiality"
          },  
          "PID-7": {
          "code": "DOB", 
          "display": "date of birth information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-Confidentiality"
          },
          "PID-17": {
          "code": "REL", 
          "display": "religion information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          },
          "PSY": {
          "code": "PSY", 
          "display": "psychiatry disorder information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          }
          },
          "CodeSystem/AccessRestrictionReason": {
          "PAT": {
          "code": "PRS", 
          "display": "patient requested information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          }, 
          "PHY": {
          "code": "PHY", 
          "display": "physician requested information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          }, 
          "REG": {
          "code": "CPLYJPP", 
          "display": "comply with jurisdictional privacy policy", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          },
          "ORG": {
          "code": "CPLY0SP", 
          "display": "comply with organisation security policy", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          }, 
          "EMP": {
          "code": "EMP", 
          "display": "employee information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          }, 
          "DIA": {
          "code": "DIA", 
          "display": "diagnosis information sensitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          },
          "VIP": {
          "code": "CEL", 
          "display": "celebrity information sennsitivity", 
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
          }		
          },
          "CodeSystem/CodeSystemUrl": {
          "I9C": {
          "system": "http://hl7.org/fhir/sid/icd-9-cm"
          }, 
          "LN": {
          "system": "http://loinc.org"
          }, 
          "SNM": {
          "system": "http://terminology.hl7.org/CodeSystem/snm"
          }, 
          "I10": {
          "system": "http://hl7.org/fhir/sid/icd-10"
          },
          "ALPHAID2006": {
          "system": "urn:oid:1.2.276.0.76.5.309"
          }, 
          "ALPHAID2007": {
          "system": "urn:oid:1.2.276.0.76.5.316"
          }, 
          "ALPHAID2008": {
          "system": "urn:oid:1.2.276.0.76.5.329"
          }, 
          "ALPHAID2009": {
          "system": "urn:oid:1.2.276.0.76.5.355"
          }, 
          "ALPHAID20010": {
          "system": "urn:oid:1.2.276.0.76.5.383"
          }, 
          "ALPHAID20011": {
          "system": "urn:oid:1.2.276.0.76.5.387"
          }, 
          "C4": {
          "system": "http://www.ama-assn.org/go/cpt"
          }, 
          "I9": {
          "system": "http://hl7.org/fhir/sid/icd-9"
          },  
          "ICD10CA": {
          "system": "http://hl7.org/fhir/sid/icd-10-ca"
          }, 
          "ICD10GM2007": {
          "system": "http://terminology.hl7.org/CodeSystem/dmdICD10"
          }, 
          "ICD10GM2008": {
          "system": "http://terminology.hl7.org/CodeSystem/dmdICD10"
          }, 
          "ICD10GM2009": {
          "system": "http://terminology.hl7.org/CodeSystem/dmdICD10"
          }, 
          "ICD10GM2010": {
          "system": "http://terminology.hl7.org/CodeSystem/dmdICD10"
          }, 
          "ICD10GM2011": {
          "system": "http://terminology.hl7.org/CodeSystem/dmdICD10"
          }, 
          "ICDO": {
          "system": "http://terminology.hl7.org/CodeSystem/icd-o"
          }, 
          "ICDO3": {
          "system": "http://terminology.hl7.org/CodeSystem/icd-o-3"
          }, 
          "ICCS": {
          "system": "http://terminology.hl7.org/CodeSystem/ics"
          }, 
          "ISO": {
          "system": "urn:iso:std:iso:3986"
          }, 
          "ISO3166_1": {
          "system": "urn:iso:std:iso:3166"
          }, 
          "ISO3166_2": {
          "system": "urn:iso:std:iso:3166:-2"
          }, 
          "ISO4217": {
          "system": "http://terminology.hl7.org/CodeSystem/iso4217"
          }, 
          "MDC": {
          "system": "urn:iso:std:iso:11073:10101"
          }, 
          "NAICS": {
          "system": "http://terminology.hl7.org/CodeSystem/naics"
          }, 
          "NDC": {
          "system": "http://hl7.org/fhir/sid/ndc"
          }, 
          "NDFRT": {
          "system": "http://hl7.org/fhir/ndfrt"
          }, 
          "NPI": {
          "system": "http://hl7.org/fhir/sid/us-npi"
          }, 
          "NUBC": {
          "system": "http://www.nubc.org/patient-discharge"
          }, 
          "NULLFL": {
          "system": "http://terminology.hl7.org/CodeSystem/v3-NullFlavor"
          }, 
          "RXNORM": {
          "system": "http://www.nlm.nih.gov/research/umls/rxnorm"
          }, 
          "SCT": {
          "system": "http://snomed.info/sct"
          }, 
          "SCT2": {
          "system": "http://snomed.info/sct"
          }, 
          "SDM": {
          "system": "http://terminology.hl7.org/NamingSystem/SDM"
          },  
          "SNM3": {
          "system": "http://snomed.info/sct"
          }, 
          "SNT": {
          "system": "http://terminology.hl7.org/CodeSystem/SNT"
          }, 
          "UB04FL14": {
          "system": "https://www.nubc.org/CodeSystem/PriorityTypeOfAdmitOrVisit"
          }, 
          "UB04FL15": {
          "system": "https://www.nubc.org/CodeSystem/PointOfOrigin"
          },
          "UB04FL17": {
          "system": "https://www.nubc.org/CodeSystem/PatDischargeStatus"
          },
          "UCUM": {
          "system": "http://unitsofmeasure.org"
          },
          "UMD": {
          "system": "http://terminology.hl7.org/CodeSystem/UMD"
          },
          "UML": {
          "system": "http://terminology.hl7.org/CodeSystem/UML"
          }
          },
          "CodeSystem/NameType": {
          "BAD": {
          "code": "old", 
          "display": "Old", 
          "system": "http://hl7.org/fhir/name-use"
          }, 
          "MSK": {
          "code": "anonymous", 
          "display": "Anonymous", 
          "system": "http://hl7.org/fhir/name-use"
          }, 
          "REL": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "TEMP": {
          "code": "temp", 
          "display": "Temp", 
          "system": "http://hl7.org/fhir/name-use"
          }, 
          "NB": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "NOUSE": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "A": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "C": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "B": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "D": {
          "code": "usual", 
          "display": "Usual", 
          "system": "http://hl7.org/fhir/name-use"
          }, 
          "F": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "I": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "K": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "M": {
          "code": "maiden", 
          "display": "Maiden", 
          "system": "http://hl7.org/fhir/name-use"
          }, 
          "L": {
          "code": "official", 
          "display": "Official", 
          "system": "http://hl7.org/fhir/name-use"
          }, 
          "N": {
          "code": "nickname", 
          "display": "Nickname", 
          "system": "http://hl7.org/fhir/name-use"
          }, 
          "P": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "S": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "R": {
          "code": "official", 
          "display": "Official", 
          "system": "http://hl7.org/fhir/name-use"
          }, 
          "U": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "T": {
          "code": "", 
          "display": "", 
          "system": ""
          }, 
          "NAV": {
          "code": "temp", 
          "display": "temp", 
          "system": "http://hl7.org/fhir/name-use"
          }
          }  
          }
          }
     </xsl:variable>
     
     <!-- This function searches the CodeSystem list stored in the variable CodeSystem 
          for the correct code & related info to be displayed in a FHIR output. Params 
          correspond to template parameters and are explained there -->
     <xsl:function name="foo:getCodeProperty">
          <xsl:param name="system"/>
          <xsl:param name="code"/>
          <xsl:param name="which"/>
          <xsl:variable name="xmlMap" as="map(*)" select="parse-json($CodeSystem)"/>
          <xsl:variable name="mapping" as="map(*)" select="map:get($xmlMap, 'Mapping')"/>
          <xsl:if test="$system and map:contains($mapping, $system)"> 
               <xsl:variable name="currSystem" as="map(*)" select="map:get($mapping, $system)"/>
               <xsl:if test="$code and map:contains($currSystem, $code)">
                    <xsl:variable name="currCode" as="map(*)" select="map:get($currSystem, $code)"/>
                    <xsl:if test="$which and map:contains($currCode, $which)">
                         <xsl:value-of select="map:get($currCode, $which)"/>
                    </xsl:if>
               </xsl:if>
          </xsl:if>
     </xsl:function>
     
     <!-- This template uses the getCodeProperty function to return code information
          for corresponding to the passed in HL7 code. Parameters:
          systemParam: Which system? Syntax: CodeSystem/{SystemType}
          codeParam: Which code? ex "DNS"
          whichParam: "code", "display", or "system" -->
     <xsl:template name="codeInfo">
          <xsl:param name="systemParam"/>
          <xsl:param name="codeParam"/>
          <xsl:param name="whichParam"/>
          <xsl:value-of select="foo:getCodeProperty($systemParam,$codeParam,$whichParam)"/>
     </xsl:template>
     
</xsl:stylesheet>