# Provenance: Erstanlage Tumorkonferenz aus oBDS-Import - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Provenance: Erstanlage Tumorkonferenz aus oBDS-Import**

## Example Provenance: Provenance: Erstanlage Tumorkonferenz aus oBDS-Import

Profile: [MII PR Provenance Ressourcen-Herkunft](StructureDefinition-mii-pr-provenance-prozedur-herkunft.md) version: 0.2.0-rc.1

Provenance for [CarePlan/tumorkonferenz-brustkrebs](https://simplifier.net/resolve?scope=de.basisprofil.r4@1.5.4&canonical=http://fhir.org/packages/de.basisprofil.r4/CarePlan/tumorkonferenz-brustkrebs)

Summary

| | |
| :--- | :--- |
| Recorded | 2025-06-12 14:31:00+0200 |
| Activity | Import aus oBDS-Melderegister |

**Agents**

* **Type**: Assembler
  * **who**: obds-to-fhir ETL (Identifier:`https://bzkf.github.io/obds-to-fhir/identifiers/obds-to-fhir-device-id`/obds-to-fhir-2.1.0)



## Resource Content

```json
{
  "resourceType" : "Provenance",
  "id" : "mii-exa-provenance-obds-import-tumorkonferenz",
  "meta" : {
    "profile" : ["https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft|0.2.0-rc.1"]
  },
  "target" : [{
    "reference" : "CarePlan/tumorkonferenz-brustkrebs"
  }],
  "recorded" : "2025-06-12T14:31:00+02:00",
  "activity" : {
    "coding" : [{
      "system" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-provenance-prozedur-herkunft",
      "code" : "obds-import",
      "display" : "Import aus oBDS-Melderegister"
    }]
  },
  "agent" : [{
    "type" : {
      "coding" : [{
        "system" : "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
        "code" : "assembler",
        "display" : "Assembler"
      }]
    },
    "who" : {
      "identifier" : {
        "system" : "https://bzkf.github.io/obds-to-fhir/identifiers/obds-to-fhir-device-id",
        "value" : "obds-to-fhir-2.1.0"
      },
      "display" : "obds-to-fhir ETL"
    }
  }],
  "entity" : [{
    "role" : "source",
    "what" : {
      "identifier" : {
        "system" : "https://bzkf.github.io/obds-to-fhir/identifiers/obds-meldung-id",
        "value" : "2025-M-00891"
      },
      "display" : "oBDS-Meldung Tumorkonferenz-Beschluss"
    }
  }]
}

```
