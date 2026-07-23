# Provenance: Deduplizierung - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Provenance: Deduplizierung**

## Example Provenance: Provenance: Deduplizierung

Profile: [MII PR Provenance Ressourcen-Herkunft](StructureDefinition-mii-pr-provenance-prozedur-herkunft.md) version: 0.2.0-rc.1

Provenance for [Procedure/op-1](https://simplifier.net/resolve?scope=de.basisprofil.r4@1.5.4&canonical=http://fhir.org/packages/de.basisprofil.r4/Procedure/op-1)

Summary

| | |
| :--- | :--- |
| Recorded | 2025-06-15 10:00:00+0200 |
| Activity | Deduplizierung/Zusammenführung |

**Agents**

* **Type**: Assembler
  * **who**: [Deduplizierungsdienst (DIZ)](https://simplifier.net/resolve?scope=de.basisprofil.r4@1.5.4&canonical=http://fhir.org/packages/de.basisprofil.r4/Device/dedup-service)



## Resource Content

```json
{
  "resourceType" : "Provenance",
  "id" : "mii-exa-provenance-deduplizierung",
  "meta" : {
    "profile" : ["https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft|0.2.0-rc.1"]
  },
  "target" : [{
    "reference" : "Procedure/op-1"
  }],
  "recorded" : "2025-06-15T10:00:00+02:00",
  "activity" : {
    "coding" : [{
      "system" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-provenance-prozedur-herkunft",
      "code" : "deduplizierung",
      "display" : "Deduplizierung/Zusammenführung"
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
      "reference" : "Device/dedup-service",
      "display" : "Deduplizierungsdienst (DIZ)"
    }
  }],
  "entity" : [{
    "role" : "source",
    "what" : {
      "reference" : "Procedure/op-1",
      "display" : "Abrechnungsprozedur (Original, v1)"
    }
  },
  {
    "role" : "source",
    "what" : {
      "reference" : "Procedure/op-2",
      "display" : "oBDS-Importprozedur (zusammengeführt, v1)"
    }
  }]
}

```
