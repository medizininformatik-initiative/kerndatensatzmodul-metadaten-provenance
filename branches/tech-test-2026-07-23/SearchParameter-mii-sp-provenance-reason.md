# MII SP Provenance Reason - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **MII SP Provenance Reason**

## SearchParameter: MII SP Provenance Reason 

| | |
| :--- | :--- |
| *Official URL*:https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/SearchParameter/provenance-reason | *Version*:0.2.0-rc.1 |
| Active as of 2026-07-23 | *Computable Name*:MII_SP_Provenance_Reason |

 
Suchparameter für Provenance.reason. Ermöglicht das Filtern aller Provenance-Ressourcen nach Geschäftsgrund — insbesondere HPAYMT (Abrechnungskontext) für die Identifikation von Daten aus DRG-aufbereiteten Routinedatenstrecken (§21, §301 etc.). In FHIR R4 nicht als Standard-Suchparameter definiert. 



## Resource Content

```json
{
  "resourceType" : "SearchParameter",
  "id" : "mii-sp-provenance-reason",
  "url" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/SearchParameter/provenance-reason",
  "version" : "0.2.0-rc.1",
  "name" : "MII_SP_Provenance_Reason",
  "status" : "active",
  "experimental" : false,
  "date" : "2026-07-23T11:57:36+00:00",
  "publisher" : "Medizininformatik Initiative",
  "contact" : [{
    "name" : "Medizininformatik Initiative",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.medizininformatik-initiative.de/"
    }]
  }],
  "description" : "Suchparameter für Provenance.reason. Ermöglicht das Filtern aller Provenance-Ressourcen nach Geschäftsgrund — insbesondere HPAYMT (Abrechnungskontext) für die Identifikation von Daten aus DRG-aufbereiteten Routinedatenstrecken (§21, §301 etc.). In FHIR R4 nicht als Standard-Suchparameter definiert.",
  "code" : "reason",
  "base" : ["Provenance"],
  "type" : "token",
  "expression" : "Provenance.reason",
  "xpathUsage" : "normal",
  "multipleOr" : true,
  "multipleAnd" : true
}

```
