# Encounter (Aufenthalt 1.-15.3.2026) - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Encounter (Aufenthalt 1.-15.3.2026)**

## Example Encounter: Encounter (Aufenthalt 1.-15.3.2026)

**status**: Finished

**class**: [ActCode: IMP](http://terminology.hl7.org/7.2.0/CodeSystem-v3-ActCode.html#v3-ActCode-IMP) (inpatient encounter)

**subject**: [Anonymous Patient Male, DoB: 1958-04-22 ( https://example.org/fhir/sid/patienten-pseudonym#P21-MI-001)](Patient-pat-mi-001.md)

**period**: 2026-03-01 08:42:00+0100 --> 2026-03-15 14:30:00+0100

### Hospitalizations

| | |
| :--- | :--- |
| - | **AdmitSource** |
| * | From accident/emergency department |



## Resource Content

```json
{
  "resourceType" : "Encounter",
  "id" : "enc-mi-001",
  "status" : "finished",
  "class" : {
    "system" : "http://terminology.hl7.org/CodeSystem/v3-ActCode",
    "code" : "IMP",
    "display" : "inpatient encounter"
  },
  "subject" : {
    "reference" : "Patient/pat-mi-001"
  },
  "period" : {
    "start" : "2026-03-01T08:42:00+01:00",
    "end" : "2026-03-15T14:30:00+01:00"
  },
  "hospitalization" : {
    "admitSource" : {
      "coding" : [{
        "system" : "http://terminology.hl7.org/CodeSystem/admit-source",
        "code" : "emd",
        "display" : "From accident/emergency department"
      }]
    }
  }
}

```
