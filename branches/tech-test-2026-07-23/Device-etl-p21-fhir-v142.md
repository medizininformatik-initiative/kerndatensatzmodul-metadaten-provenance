# Device: ETL-Pipeline KIS-DRG → FHIR (v1.4.2) - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Device: ETL-Pipeline KIS-DRG → FHIR (v1.4.2)**

## Example Device: Device: ETL-Pipeline KIS-DRG → FHIR (v1.4.2)

**status**: Active

**manufacturer**: Universitätsklinikum Beispielstadt – DIZ-IT

### DeviceNames

| | | |
| :--- | :--- | :--- |
| - | **Name** | **Type** |
| * | p21-to-fhir ETL-Pipeline | User Friendly name |

### Versions

| | |
| :--- | :--- |
| - | **Value** |
| * | 1.4.2 |

**note**: 

> 

Transformiert den KIS-DRG-Aufbereitungsstand (gleicher Stand, aus dem auch §21-CSV und §301-DTA gespeist werden) in FHIR R4 nach MII-KDM-Profilen.




## Resource Content

```json
{
  "resourceType" : "Device",
  "id" : "etl-p21-fhir-v142",
  "status" : "active",
  "manufacturer" : "Universitätsklinikum Beispielstadt – DIZ-IT",
  "deviceName" : [{
    "name" : "p21-to-fhir ETL-Pipeline",
    "type" : "user-friendly-name"
  }],
  "version" : [{
    "value" : "1.4.2"
  }],
  "note" : [{
    "text" : "Transformiert den KIS-DRG-Aufbereitungsstand (gleicher Stand, aus dem auch §21-CSV und §301-DTA gespeist werden) in FHIR R4 nach MII-KDM-Profilen."
  }]
}

```
