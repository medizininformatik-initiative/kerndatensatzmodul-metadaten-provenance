# Device: Ikarus-KIS am UKB (Quellsystem) - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Device: Ikarus-KIS am UKB (Quellsystem)**

## Example Device: Device: Ikarus-KIS am UKB (Quellsystem)

**status**: Active

**manufacturer**: Ikarus Healthcare GmbH (fiktiv)

### DeviceNames

| | | |
| :--- | :--- | :--- |
| - | **Name** | **Type** |
| * | Ikarus-KIS — Subsystem Abrechnung | User Friendly name |

**modelNumber**: Ikarus-KIS 2025.1

**type**: Sekundärsystem

**owner**: [Organization Universitätsklinikum Beispielstadt](Organization-org-ukb.md)

**note**: 

> 

Fiktiver KIS-Hersteller. Der Name spielt auf die Mythologie an (Ikarus = Sohn des Dedalus) und ist NICHT mit einem realen Produkt assoziiert.




## Resource Content

```json
{
  "resourceType" : "Device",
  "id" : "src-ikarus-kis-ukb",
  "status" : "active",
  "manufacturer" : "Ikarus Healthcare GmbH (fiktiv)",
  "deviceName" : [{
    "name" : "Ikarus-KIS — Subsystem Abrechnung",
    "type" : "user-friendly-name"
  }],
  "modelNumber" : "Ikarus-KIS 2025.1",
  "type" : {
    "coding" : [{
      "system" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-datenquellsystem",
      "code" : "Sekundaersystem",
      "display" : "Sekundärsystem"
    }]
  },
  "owner" : {
    "reference" : "Organization/org-ukb"
  },
  "note" : [{
    "text" : "Fiktiver KIS-Hersteller. Der Name spielt auf die Mythologie an (Ikarus = Sohn des Dedalus) und ist NICHT mit einem realen Produkt assoziiert."
  }]
}

```
