# Condition: Hauptdiagnose I21.0 - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Condition: Hauptdiagnose I21.0**

## Example Condition: Condition: Hauptdiagnose I21.0

**clinicalStatus**: Active

**verificationStatus**: Confirmed

**category**: Billing

**code**: Akuter transmuraler Myokardinfarkt der Vorderwand

**subject**: [Anonymous Patient Male, DoB: 1958-04-22 ( https://example.org/fhir/sid/patienten-pseudonym#P21-MI-001)](Patient-pat-mi-001.md)

**encounter**: [Encounter: status = finished; class = inpatient encounter (ActCode#IMP); period = 2026-03-01 08:42:00+0100 --> 2026-03-15 14:30:00+0100](Encounter-enc-mi-001.md)

**recordedDate**: 2026-03-15



## Resource Content

```json
{
  "resourceType" : "Condition",
  "id" : "cond-mi-001-hd-i21",
  "clinicalStatus" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/condition-clinical",
      "code" : "active"
    }]
  },
  "verificationStatus" : {
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/condition-ver-status",
      "code" : "confirmed"
    }]
  },
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/diagnosis-role",
      "code" : "billing",
      "display" : "Billing"
    }]
  }],
  "code" : {
    "coding" : [{
      "system" : "http://fhir.de/CodeSystem/bfarm/icd-10-gm",
      "code" : "I21.0",
      "display" : "Akuter transmuraler Myokardinfarkt der Vorderwand"
    }]
  },
  "subject" : {
    "reference" : "Patient/pat-mi-001"
  },
  "encounter" : {
    "reference" : "Encounter/enc-mi-001"
  },
  "recordedDate" : "2026-03-15"
}

```
