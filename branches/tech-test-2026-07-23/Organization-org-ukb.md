# Organization: Universitätsklinikum Beispielstadt - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Organization: Universitätsklinikum Beispielstadt**

## Example Organization: Organization: Universitätsklinikum Beispielstadt

**identifier**: `http://fhir.de/NamingSystem/arge-ik/iknr`/260100000

**type**: Healthcare Provider

**name**: Universitätsklinikum Beispielstadt



## Resource Content

```json
{
  "resourceType" : "Organization",
  "id" : "org-ukb",
  "identifier" : [{
    "system" : "http://fhir.de/NamingSystem/arge-ik/iknr",
    "value" : "260100000"
  }],
  "type" : [{
    "coding" : [{
      "system" : "http://terminology.hl7.org/CodeSystem/organization-type",
      "code" : "prov",
      "display" : "Healthcare Provider"
    }]
  }],
  "name" : "Universitätsklinikum Beispielstadt"
}

```
