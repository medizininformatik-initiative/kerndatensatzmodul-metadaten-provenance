# dq-test-1 - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **dq-test-1**

## Example Observation: dq-test-1

Tags: [Dosis of medication is a required item. (Details: DQ_Rule_Successful code DosisMedic-1 = 'Dosis of medication is a required item.')](CodeSystem-dq-rule-successful.md), [Dosis of medication has to be between 50 and 250 mmol. (Details: DQ_Rule_Successful code DosisMedic-2 = 'Dosis of medication has to be between 50 and 250 mmol.')](CodeSystem-dq-rule-successful.md)

**status**: Final

**code**: Drug dose

**subject**: [Mighty M Male, DoB: 1982-02-05](Patient-mighty-m.md)

**value**: 90 mmol



## Resource Content

```json
{
  "resourceType" : "Observation",
  "id" : "dq-test-1",
  "meta" : {
    "tag" : [{
      "system" : "http://mii.de/CodeSystem/dq-rule-successful",
      "code" : "DosisMedic-1"
    },
    {
      "system" : "http://mii.de/CodeSystem/dq-rule-successful",
      "code" : "DosisMedic-2"
    }]
  },
  "status" : "final",
  "code" : {
    "coding" : [{
      "system" : "http://purl.bioontology.org/ontology/SNOMEDCT/",
      "code" : "398232005"
    }],
    "text" : "Drug dose"
  },
  "subject" : {
    "reference" : "Patient/mighty-m"
  },
  "valueQuantity" : {
    "value" : 90,
    "unit" : "mmol"
  }
}

```
