# Provenance: Abrechnungskontext-ETL für Aufenthalt mi-001 - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Provenance: Abrechnungskontext-ETL für Aufenthalt mi-001**

## Example Provenance: Provenance: Abrechnungskontext-ETL für Aufenthalt mi-001

Provenance for: 

* [Anonymous Patient Male, DoB: 1958-04-22 ( https://example.org/fhir/sid/patienten-pseudonym#P21-MI-001)](Patient-pat-mi-001.md)
* [Encounter: status = finished; class = inpatient encounter (ActCode#IMP); period = 2026-03-01 08:42:00+0100 --> 2026-03-15 14:30:00+0100](Encounter-enc-mi-001.md)
* [Condition Akuter transmuraler Myokardinfarkt der Vorderwand](Condition-cond-mi-001-hd-i21.md)
* [Condition Essentielle Hypertonie, nicht näher bezeichnet](Condition-cond-mi-001-nd-i10.md)
* [Procedure Perkutan-transluminale Gefäßintervention an Herz und Koronargefäßen: Einlegen eines beschichteten Stents in Koronargefäße: Ein Stent](Procedure-proc-mi-001-ptca.md)

Summary

| | |
| :--- | :--- |
| Occurrence | 2026-03-01 08:42:00+0100 --> 2026-03-15 14:30:00+0100 |
| Recorded | 2026-03-16 03:12:00+0100 |
| Policy | * [https://www.gesetze-im-internet.de/khentgg/__21.html](https://simplifier.net/resolve?scope=de.basisprofil.r4@1.5.4&canonical=https://www.gesetze-im-internet.de/khentgg/__21.html)
* [https://www.gesetze-im-internet.de/sgb_5/__301.html](https://simplifier.net/resolve?scope=de.basisprofil.r4@1.5.4&canonical=https://www.gesetze-im-internet.de/sgb_5/__301.html)
 |
| Activity | create |

**Agents**

* **Type**: Assembler
  * **who**: [Device: status = active; manufacturer = Universitätsklinikum Beispielstadt – DIZ-IT; note = Transformiert den KIS-DRG-Aufbereitungsstand (gleicher Stand, aus dem auch §21-CSV und §301-DTA gespeist werden) in FHIR R4 nach MII-KDM-Profilen.](Device-etl-p21-fhir-v142.md)
* **Type**: Performer
  * **who**: [Organization Universitätsklinikum Beispielstadt](Organization-org-ukb.md)



## Resource Content

```json
{
  "resourceType" : "Provenance",
  "id" : "prov-abrechnungskontext-mi-001",
  "target" : [{
    "reference" : "Patient/pat-mi-001"
  },
  {
    "reference" : "Encounter/enc-mi-001"
  },
  {
    "reference" : "Condition/cond-mi-001-hd-i21"
  },
  {
    "reference" : "Condition/cond-mi-001-nd-i10"
  },
  {
    "reference" : "Procedure/proc-mi-001-ptca"
  }],
  "occurredPeriod" : {
    "start" : "2026-03-01T08:42:00+01:00",
    "end" : "2026-03-15T14:30:00+01:00"
  },
  "recorded" : "2026-03-16T03:12:00+01:00",
  "policy" : ["https://www.gesetze-im-internet.de/khentgg/__21.html",
  "https://www.gesetze-im-internet.de/sgb_5/__301.html"],
  "reason" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
      "code" : "HPAYMT",
      "display" : "Payment"
    }]
  }],
  "activity" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-DataOperation",
      "code" : "CREATE",
      "display" : "create"
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
      "reference" : "Device/etl-p21-fhir-v142"
    }
  },
  {
    "type" : {
      "coding" : [{
        "system" : "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
        "code" : "performer",
        "display" : "Performer"
      }]
    },
    "who" : {
      "reference" : "Organization/org-ukb"
    }
  }],
  "entity" : [{
    "role" : "source",
    "what" : {
      "reference" : "DocumentReference/kis-drg-aufbereitung-2026-03-15"
    }
  }]
}

```
