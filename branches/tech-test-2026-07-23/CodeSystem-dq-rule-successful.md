# DQ_Rule_Successful - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **DQ_Rule_Successful**

## CodeSystem: DQ_Rule_Successful 

| | |
| :--- | :--- |
| *Official URL*:http://mii.de/CodeSystem/dq-rule-successful | *Version*:0.2.0-rc.1 |
| Draft as of 2026-07-23 | *Computable Name*:DQ_Rule_Successful |

 This Code system is referenced in the content logical definition of the following value sets: 

* [Alle_DQ_Indikatoren_VS](ValueSet-primary.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "dq-rule-successful",
  "url" : "http://mii.de/CodeSystem/dq-rule-successful",
  "version" : "0.2.0-rc.1",
  "name" : "DQ_Rule_Successful",
  "status" : "draft",
  "date" : "2026-07-23T11:57:36+00:00",
  "publisher" : "Medizininformatik Initiative",
  "contact" : [{
    "name" : "Medizininformatik Initiative",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.medizininformatik-initiative.de/"
    }]
  }],
  "content" : "complete",
  "count" : 5,
  "property" : [{
    "code" : "error-message",
    "description" : "Fehlermeldung im Fall des Anschlagens der Regel.",
    "type" : "string"
  }],
  "concept" : [{
    "code" : "OP-1",
    "display" : "Surgery has to be after admission.",
    "property" : [{
      "code" : "rule-type",
      "valueCode" : "after"
    },
    {
      "code" : "comperator",
      "valueCoding" : {
        "system" : "http://trial.info/dq",
        "code" : "Admission"
      }
    }]
  },
  {
    "code" : "OP-2",
    "display" : "Surgery appointment is required.",
    "property" : [{
      "code" : "rule-type",
      "valueCode" : "required"
    }]
  },
  {
    "code" : "Discharge-1",
    "display" : "Discharge has to be at least 2 days after surgery.",
    "property" : [{
      "code" : "rule-type",
      "valueCode" : "after"
    },
    {
      "code" : "comperator",
      "valueCoding" : {
        "system" : "http://trial.info/dq",
        "code" : "OP"
      }
    },
    {
      "code" : "min",
      "valueDecimal" : 2
    }]
  },
  {
    "code" : "DosisMedic-1",
    "display" : "Dosis of medication is a required item.",
    "property" : [{
      "code" : "rule-type",
      "valueCode" : "required"
    },
    {
      "code" : "comperator",
      "valueCoding" : {
        "system" : "http://trial.info/dq",
        "code" : "Medication"
      }
    },
    {
      "code" : "value",
      "valueString" : "eq 1"
    }]
  },
  {
    "code" : "DosisMedic-2",
    "display" : "Dosis of medication has to be between 50 and 250 mmol.",
    "property" : [{
      "code" : "rule-type",
      "valueCode" : "range"
    },
    {
      "code" : "comperator",
      "valueCoding" : {
        "system" : "http://trial.info/dq",
        "code" : "UnitMedication"
      }
    },
    {
      "code" : "value",
      "valueString" : "mmol"
    },
    {
      "code" : "min",
      "valueDecimal" : 50
    },
    {
      "code" : "max",
      "valueDecimal" : 250
    }]
  }]
}

```
