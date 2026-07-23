# Procedure: PTCA mit DES (8-837.k0) - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Procedure: PTCA mit DES (8-837.k0)**

## Example Procedure: Procedure: PTCA mit DES (8-837.k0)

**status**: Completed

**code**: Perkutan-transluminale Gefäßintervention an Herz und Koronargefäßen: Einlegen eines beschichteten Stents in Koronargefäße: Ein Stent

**subject**: [Anonymous Patient Male, DoB: 1958-04-22 ( https://example.org/fhir/sid/patienten-pseudonym#P21-MI-001)](Patient-pat-mi-001.md)

**encounter**: [Encounter: status = finished; class = inpatient encounter (ActCode#IMP); period = 2026-03-01 08:42:00+0100 --> 2026-03-15 14:30:00+0100](Encounter-enc-mi-001.md)

**performed**: 2026-03-01 11:18:00+0100



## Resource Content

```json
{
  "resourceType" : "Procedure",
  "id" : "proc-mi-001-ptca",
  "status" : "completed",
  "code" : {
    "coding" : [{
      "system" : "http://fhir.de/CodeSystem/bfarm/ops",
      "code" : "8-837.k0",
      "display" : "Perkutan-transluminale Gefäßintervention an Herz und Koronargefäßen: Einlegen eines beschichteten Stents in Koronargefäße: Ein Stent"
    }]
  },
  "subject" : {
    "reference" : "Patient/pat-mi-001"
  },
  "encounter" : {
    "reference" : "Encounter/enc-mi-001"
  },
  "performedDateTime" : "2026-03-01T11:18:00+01:00"
}

```
