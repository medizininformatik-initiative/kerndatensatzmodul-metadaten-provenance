# DocumentReference: KIS-DRG-Aufbereitungsstand 2026-03-15 - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **DocumentReference: KIS-DRG-Aufbereitungsstand 2026-03-15**

## Example DocumentReference: DocumentReference: KIS-DRG-Aufbereitungsstand 2026-03-15

**identifier**: `https://example.org/fhir/sid/kis-drg-aufbereitung`/UKB-260100000-enc-mi-001-2026-03-15

**status**: Current

**type**: Subsequent evaluation note

**category**: Payment

**date**: 2026-03-15 23:00:00+0100

**author**: 

* [Organization Universitätsklinikum Beispielstadt](Organization-org-ukb.md)
* [Device: status = active; manufacturer = Ikarus Healthcare GmbH (fiktiv); modelNumber = Ikarus-KIS 2025.1; type = Sekundärsystem; note = Fiktiver KIS-Hersteller. Der Name spielt auf die Mythologie an (Ikarus = Sohn des Dedalus) und ist NICHT mit einem realen Produkt assoziiert.](Device-src-ikarus-kis-ukb.md)

**description**: Gemeinsamer DRG-Aufbereitungsstand (Codierung + Grouping). Schwester-Outputs: §21-CSV (Lieferung an InEK Q1/2027), §301-DTA (innerhalb von 3 Werktagen an Krankenkasse), FHIR-Bundle (zeitnah ins DIZ).

> **content**

### Attachments

| | | |
| :--- | :--- | :--- |
| - | **ContentType** | **Title** |
| * | application/octet-stream | KIS-DRG-Aufbereitungsstand UKB enc-mi-001 (2026-03-15) |




## Resource Content

```json
{
  "resourceType" : "DocumentReference",
  "id" : "kis-drg-aufbereitung-2026-03-15",
  "identifier" : [{
    "system" : "https://example.org/fhir/sid/kis-drg-aufbereitung",
    "value" : "UKB-260100000-enc-mi-001-2026-03-15"
  }],
  "status" : "current",
  "type" : {
    "coding" : [{
      "system" : "http://loinc.org",
      "code" : "11506-3",
      "display" : "Subsequent evaluation note"
    }]
  },
  "category" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/v3-ActReason",
      "code" : "HPAYMT",
      "display" : "Payment"
    }]
  }],
  "date" : "2026-03-15T23:00:00+01:00",
  "author" : [{
    "reference" : "Organization/org-ukb"
  },
  {
    "reference" : "Device/src-ikarus-kis-ukb"
  }],
  "description" : "Gemeinsamer DRG-Aufbereitungsstand (Codierung + Grouping). Schwester-Outputs: §21-CSV (Lieferung an InEK Q1/2027), §301-DTA (innerhalb von 3 Werktagen an Krankenkasse), FHIR-Bundle (zeitnah ins DIZ).",
  "content" : [{
    "attachment" : {
      "contentType" : "application/octet-stream",
      "title" : "KIS-DRG-Aufbereitungsstand UKB enc-mi-001 (2026-03-15)"
    }
  }]
}

```
