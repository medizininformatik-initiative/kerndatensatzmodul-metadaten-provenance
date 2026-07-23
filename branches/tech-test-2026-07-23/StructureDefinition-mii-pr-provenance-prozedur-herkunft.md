# MII PR Provenance Ressourcen-Herkunft - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **MII PR Provenance Ressourcen-Herkunft**

## Resource Profile: MII PR Provenance Ressourcen-Herkunft ( Experimental ) 

| | |
| :--- | :--- |
| *Official URL*:https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft | *Version*:0.2.0-rc.1 |
| Draft as of 2026-07-23 | *Computable Name*:MII_PR_Provenance_Prozedur_Herkunft |

 
Provenance-Profil zur Dokumentation der Herkunft onkologischer FHIR-Ressourcen (oBDS-Import vs. Abrechnung) und des Deduplizierungsstatus. Anwendbar auf Prozeduren, Diagnosen, Tumorkonferenzen und weitere Ressourcentypen. 

**Usages:**

* Examples for this Profile: [Provenance/mii-exa-provenance-abrechnung-import](Provenance-mii-exa-provenance-abrechnung-import.md), [Provenance/mii-exa-provenance-deduplizierung](Provenance-mii-exa-provenance-deduplizierung.md), [Provenance/mii-exa-provenance-obds-import-diagnose](Provenance-mii-exa-provenance-obds-import-diagnose.md), [Provenance/mii-exa-provenance-obds-import-tumorkonferenz](Provenance-mii-exa-provenance-obds-import-tumorkonferenz.md) and [Provenance/mii-exa-provenance-obds-import](Provenance-mii-exa-provenance-obds-import.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/mii-ig-metadaten-provenance-de-v2026|current/StructureDefinition/StructureDefinition-mii-pr-provenance-prozedur-herkunft.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-mii-pr-provenance-prozedur-herkunft.csv), [Excel](StructureDefinition-mii-pr-provenance-prozedur-herkunft.xlsx), [Schematron](StructureDefinition-mii-pr-provenance-prozedur-herkunft.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "mii-pr-provenance-prozedur-herkunft",
  "url" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft",
  "version" : "0.2.0-rc.1",
  "name" : "MII_PR_Provenance_Prozedur_Herkunft",
  "title" : "MII PR Provenance Ressourcen-Herkunft",
  "_title" : {
    "extension" : [{
      "extension" : [{
        "url" : "lang",
        "valueCode" : "de-DE"
      },
      {
        "url" : "content",
        "valueString" : "MII PR Provenance Ressourcen-Herkunft"
      }],
      "url" : "http://hl7.org/fhir/StructureDefinition/translation"
    }]
  },
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
  "description" : "Provenance-Profil zur Dokumentation der Herkunft onkologischer FHIR-Ressourcen (oBDS-Import vs. Abrechnung) und des Deduplizierungsstatus. Anwendbar auf Prozeduren, Diagnosen, Tumorkonferenzen und weitere Ressourcentypen.",
  "_description" : {
    "extension" : [{
      "extension" : [{
        "url" : "lang",
        "valueCode" : "de-DE"
      },
      {
        "url" : "content",
        "valueString" : "Provenance-Profil zur Dokumentation der Herkunft onkologischer FHIR-Ressourcen und des Deduplizierungsstatus."
      }],
      "url" : "http://hl7.org/fhir/StructureDefinition/translation"
    }]
  },
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "workflow",
    "uri" : "http://hl7.org/fhir/workflow",
    "name" : "Workflow Pattern"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w3c.prov",
    "uri" : "http://www.w3.org/ns/prov",
    "name" : "W3C PROV"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  },
  {
    "identity" : "fhirauditevent",
    "uri" : "http://hl7.org/fhir/auditevent",
    "name" : "FHIR AuditEvent Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Provenance",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Provenance",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Provenance",
      "path" : "Provenance"
    },
    {
      "id" : "Provenance.target",
      "path" : "Provenance.target",
      "short" : "Ziel-Ressource",
      "definition" : "Die FHIR-Ressource deren Herkunft dokumentiert wird",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Procedure",
        "http://hl7.org/fhir/StructureDefinition/Condition",
        "http://hl7.org/fhir/StructureDefinition/CarePlan",
        "http://hl7.org/fhir/StructureDefinition/Observation",
        "http://hl7.org/fhir/StructureDefinition/Resource"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Provenance.recorded",
      "path" : "Provenance.recorded",
      "short" : "Dokumentationszeitpunkt",
      "definition" : "Zeitpunkt zu dem die Herkunftsinformation erfasst wurde",
      "mustSupport" : true
    },
    {
      "id" : "Provenance.activity",
      "path" : "Provenance.activity",
      "short" : "Herkunftsart",
      "definition" : "Art der Datenherkunft oder Datentransformation: oBDS-Import, Abrechnung oder Deduplizierung",
      "min" : 1,
      "mustSupport" : true,
      "binding" : {
        "strength" : "extensible",
        "valueSet" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ValueSet/mii-vs-provenance-prozedur-herkunft"
      }
    },
    {
      "id" : "Provenance.activity.coding",
      "path" : "Provenance.activity.coding",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Provenance.activity.coding.system",
      "path" : "Provenance.activity.coding.system",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Provenance.activity.coding.code",
      "path" : "Provenance.activity.coding.code",
      "min" : 1,
      "mustSupport" : true
    },
    {
      "id" : "Provenance.agent",
      "path" : "Provenance.agent",
      "short" : "Verantwortlicher Agent",
      "definition" : "Organisation, System oder Person, die die Herkunftszuordnung oder Deduplizierung durchgeführt hat",
      "mustSupport" : true
    },
    {
      "id" : "Provenance.agent.type",
      "path" : "Provenance.agent.type",
      "mustSupport" : true,
      "binding" : {
        "strength" : "extensible",
        "valueSet" : "http://hl7.org/fhir/ValueSet/provenance-agent-type"
      }
    },
    {
      "id" : "Provenance.agent.who",
      "path" : "Provenance.agent.who",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Organization",
        "http://hl7.org/fhir/StructureDefinition/Device",
        "http://hl7.org/fhir/StructureDefinition/Practitioner",
        "http://hl7.org/fhir/StructureDefinition/PractitionerRole"]
      }],
      "mustSupport" : true
    },
    {
      "id" : "Provenance.entity",
      "path" : "Provenance.entity",
      "short" : "Quellressource",
      "definition" : "Bei Deduplizierung: die ursprüngliche Quellressource die zusammengeführt wurde",
      "mustSupport" : true
    },
    {
      "id" : "Provenance.entity.role",
      "path" : "Provenance.entity.role",
      "mustSupport" : true
    },
    {
      "id" : "Provenance.entity.what",
      "path" : "Provenance.entity.what",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://hl7.org/fhir/StructureDefinition/Procedure",
        "http://hl7.org/fhir/StructureDefinition/Condition",
        "http://hl7.org/fhir/StructureDefinition/CarePlan",
        "http://hl7.org/fhir/StructureDefinition/Observation",
        "http://hl7.org/fhir/StructureDefinition/Resource"]
      }],
      "mustSupport" : true
    }]
  }
}

```
