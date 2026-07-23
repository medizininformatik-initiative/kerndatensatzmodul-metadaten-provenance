# Alle_DQ_Indikatoren_VS - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Alle_DQ_Indikatoren_VS**

## ValueSet: Alle_DQ_Indikatoren_VS 

| | |
| :--- | :--- |
| *Official URL*:https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ValueSet/primary | *Version*:0.2.0-rc.1 |
| Draft as of 2026-07-23 | *Computable Name*:Alle_DQ_Indikatoren_VS |

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
  "id" : "primary",
  "url" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ValueSet/primary",
  "version" : "0.2.0-rc.1",
  "name" : "Alle_DQ_Indikatoren_VS",
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
  "compose" : {
    "include" : [{
      "system" : "https://www.medizininformatik-initiative.de/fhir/core/modul-meta/CodeSystem/greifswald-obc-dq-framework"
    },
    {
      "system" : "http://mii.de/CodeSystem/dq-rule-successful"
    }]
  }
}

```
