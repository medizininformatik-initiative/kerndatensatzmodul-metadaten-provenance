# Procedure Intent Value Set - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Procedure Intent Value Set**

## ValueSet: Procedure Intent Value Set 

| | |
| :--- | :--- |
| *Official URL*:https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ValueSet/procedure-intent-vs | *Version*:0.2.0-rc.1 |
| Draft as of 2026-07-23 | *Computable Name*:ProcedureIntentVS |
| **Copyright/Legal**: SNOMED CT is copyright © 2002+ IHTSDO | |

 
The purpose of a procedure. 

 **References** 

This value set is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)

### Logical Definition (CLD)

 

### Expansion

-------

 Explanation of the columns that may appear on this page: 

| | |
| :--- | :--- |
| Level | A few code lists that FHIR defines are hierarchical - each code is assigned a level. In this scheme, some codes are under other codes, and imply that the code they are under also applies |
| System | The source of the definition of the code (when the value set draws in codes defined elsewhere) |
| Code | The code (used as the code in the resource instance) |
| Display | The display (used in the*display*element of a[Coding](http://hl7.org/fhir/R4/datatypes.html#Coding)). If there is no display, implementers should not simply display the code, but map the concept into their application |
| Definition | An explanation of the meaning of the concept |
| Comments | Additional notes about how to use the code |



## Resource Content

```json
{
  "resourceType" : "ValueSet",
  "id" : "procedure-intent-vs",
  "url" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ValueSet/procedure-intent-vs",
  "version" : "0.2.0-rc.1",
  "name" : "ProcedureIntentVS",
  "title" : "Procedure Intent Value Set",
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
  "description" : "The purpose of a procedure.",
  "copyright" : "SNOMED CT is copyright © 2002+ IHTSDO",
  "compose" : {
    "include" : [{
      "system" : "http://snomed.info/sct",
      "concept" : [{
        "code" : "373808002",
        "display" : "Curative - procedure intent"
      },
      {
        "code" : "363676003",
        "display" : "Palliative - procedure intent"
      },
      {
        "code" : "399707004",
        "display" : "Supportive - procedure intent"
      }]
    }]
  }
}

```
