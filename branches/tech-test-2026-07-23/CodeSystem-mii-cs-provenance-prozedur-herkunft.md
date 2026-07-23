# MII CS Provenance Prozedur Herkunft - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **MII CS Provenance Prozedur Herkunft**

## CodeSystem: MII CS Provenance Prozedur Herkunft (Experimental) 

| | |
| :--- | :--- |
| *Official URL*:https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-provenance-prozedur-herkunft | *Version*:0.2.0-rc.1 |
| Draft as of 2026-07-23 | *Computable Name*:MII_CS_Provenance_Prozedur_Herkunft |

 
CodeSystem für die Herkunft onkologischer Prozeduren zur Unterscheidung von Datenquellen und Deduplizierungsstatus. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [MII_VS_Provenance_Prozedur_Herkunft](ValueSet-mii-vs-provenance-prozedur-herkunft.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "mii-cs-provenance-prozedur-herkunft",
  "meta" : {
    "profile" : ["http://hl7.org/fhir/StructureDefinition/shareablecodesystem"]
  },
  "url" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-provenance-prozedur-herkunft",
  "version" : "0.2.0-rc.1",
  "name" : "MII_CS_Provenance_Prozedur_Herkunft",
  "title" : "MII CS Provenance Prozedur Herkunft",
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
  "description" : "CodeSystem für die Herkunft onkologischer Prozeduren zur Unterscheidung von Datenquellen und Deduplizierungsstatus.",
  "caseSensitive" : true,
  "valueSet" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ValueSet/mii-vs-provenance-prozedur-herkunft",
  "content" : "complete",
  "count" : 3,
  "concept" : [{
    "code" : "obds-import",
    "display" : "Import aus oBDS-Melderegister",
    "definition" : "Die Prozedur wurde aus dem onkologischen Basisdatensatz (oBDS) via Krebsregistermeldung reimportiert."
  },
  {
    "code" : "abrechnung",
    "display" : "Abrechnungsprozedur",
    "definition" : "Die Prozedur stammt aus dem Abrechnungssystem (KIS/Routinedaten) des Krankenhauses."
  },
  {
    "code" : "deduplizierung",
    "display" : "Deduplizierung/Zusammenführung",
    "definition" : "Die Prozedur ist das Ergebnis einer Deduplizierung/Zusammenführung von Daten aus unterschiedlichen Quellen."
  }]
}

```
