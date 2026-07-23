# MII VS Provenance Prozedur Herkunft - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **MII VS Provenance Prozedur Herkunft**

## ValueSet: MII VS Provenance Prozedur Herkunft (Experimental) 

| | |
| :--- | :--- |
| *Official URL*:https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ValueSet/mii-vs-provenance-prozedur-herkunft | *Version*:0.2.0-rc.1 |
| Draft as of 2026-07-23 | *Computable Name*:MII_VS_Provenance_Prozedur_Herkunft |

 
Value Set für die Herkunft onkologischer Prozeduren zur Unterscheidung von Datenquellen und Deduplizierungsstatus. 

 **References** 

* [MII PR Provenance Ressourcen-Herkunft](StructureDefinition-mii-pr-provenance-prozedur-herkunft.md)

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
  "id" : "mii-vs-provenance-prozedur-herkunft",
  "meta" : {
    "profile" : ["http://hl7.org/fhir/StructureDefinition/shareablevalueset"]
  },
  "url" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ValueSet/mii-vs-provenance-prozedur-herkunft",
  "version" : "0.2.0-rc.1",
  "name" : "MII_VS_Provenance_Prozedur_Herkunft",
  "title" : "MII VS Provenance Prozedur Herkunft",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-07-23T11:57:36+00:00",
  "publisher" : "Medizininformatik Initiative",
  "contact" : [{
    "name" : "Medizininformatik Initiative",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.medizininformatik-initiative.de/"
    }]
  }],
  "description" : "Value Set für die Herkunft onkologischer Prozeduren zur Unterscheidung von Datenquellen und Deduplizierungsstatus.",
  "compose" : {
    "include" : [{
      "system" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-provenance-prozedur-herkunft"
    }]
  }
}

```
