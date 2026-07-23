# Provenance: Erstanlage aus Abrechnung - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Provenance: Erstanlage aus Abrechnung**

## Example Provenance: Provenance: Erstanlage aus Abrechnung

Profile: [MII PR Provenance Ressourcen-Herkunft](StructureDefinition-mii-pr-provenance-prozedur-herkunft.md) version: 0.2.0-rc.1

Provenance for [Procedure/op-1](https://simplifier.net/resolve?scope=de.basisprofil.r4@1.5.4&canonical=http://fhir.org/packages/de.basisprofil.r4/Procedure/op-1)

Summary

| | |
| :--- | :--- |
| Recorded | 2025-03-13 08:15:00+0100 |
| Activity | Abrechnungsprozedur |

**Agents**

* **Type**: Assembler
  * **who**: KIS-ETL-Strecke (DIZ)



## Resource Content

```json
{
  "resourceType" : "Provenance",
  "id" : "mii-exa-provenance-abrechnung-import",
  "meta" : {
    "profile" : ["https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft|0.2.0-rc.1"]
  },
  "target" : [{
    "reference" : "Procedure/op-1"
  }],
  "recorded" : "2025-03-13T08:15:00+01:00",
  "activity" : {
    "coding" : [{
      "system" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-provenance-prozedur-herkunft",
      "code" : "abrechnung",
      "display" : "Abrechnungsprozedur"
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
      "display" : "KIS-ETL-Strecke (DIZ)"
    }
  }],
  "entity" : [{
    "role" : "source",
    "what" : {
      "identifier" : {
        "system" : "https://example.org/fhir/identifiers/fall-nummer",
        "value" : "2025-KH-00472"
      },
      "display" : "Abrechnungsfall"
    }
  }]
}

```
