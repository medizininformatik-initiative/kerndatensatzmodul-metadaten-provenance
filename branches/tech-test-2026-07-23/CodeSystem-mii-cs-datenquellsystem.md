# MII CS Datenquellsystem - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **MII CS Datenquellsystem**

## CodeSystem: MII CS Datenquellsystem (Experimental) 

| | |
| :--- | :--- |
| *Official URL*:https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-datenquellsystem | *Version*:0.2.0-rc.1 |
| Draft as of 2026-07-23 | *Computable Name*:MII_CS_Datenquellsystem |

 
Hierarchisches CodeSystem zur Klassifikation von Datenquellsystemen. Top-Level unterscheidet Primärsysteme (Erfassung am Ort der Versorgung) von Sekundärsystemen (Aufnahme/Transformation aus Primärsystemen). Darunter konkrete Systemtypen wie KIS, Abrechnungssystem, DRG-Grouper, DWH usw. Die Hierarchie erlaubt Subsumption-basierte Filter (z. B. ?type:below=Sekundaersystem). 

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| Stand 2026 existiert kein international etablierter CodeSystem-Standard für Datenquellsystem-Typen im Kontext klinischer Sekundärnutzung. Verwandte, aber nicht direkt anwendbare Quellen: ISO/IEC 25010 (Software-Qualitätsmodell, kein Typ-Katalog), IEC 62304 (Risiko-Klassen für Medizinprodukte-Software), HL7 v3 RoleCode (Einrichtungstypen, nicht IT-Systeme), IHE Actors (profil-spezifische Rollen wie Document Source / Repository), SNOMED CT (sehr grobe Codes wie 706594005 | Information system | oder 308040009 | Hospital information system | ), gematik Primärsystem-Definition (TI-spezifisch, nur Primär-Begriff). Dieses CodeSystem ist daher ein MII-spezifischer Vorschlag und kandidiert zur Übernahme in MII-weite Terminologie-Pflege. |

 

 This Code system is referenced in the content logical definition of the following value sets: 

* This CodeSystem is not used here; it may be used elsewhere (e.g. specifications and/or implementations that use this content)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "mii-cs-datenquellsystem",
  "meta" : {
    "profile" : ["http://hl7.org/fhir/StructureDefinition/shareablecodesystem"]
  },
  "url" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-datenquellsystem",
  "version" : "0.2.0-rc.1",
  "name" : "MII_CS_Datenquellsystem",
  "title" : "MII CS Datenquellsystem",
  "status" : "draft",
  "experimental" : true,
  "date" : "2026-07-23T11:57:36+00:00",
  "publisher" : "Medizininformatik Initiative",
  "contact" : [{
    "name" : "Medizininformatik Initiative",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.medizininformatik-initiative.de/"
    }]
  }],
  "description" : "Hierarchisches CodeSystem zur Klassifikation von Datenquellsystemen. Top-Level unterscheidet Primärsysteme (Erfassung am Ort der Versorgung) von Sekundärsystemen (Aufnahme/Transformation aus Primärsystemen). Darunter konkrete Systemtypen wie KIS, Abrechnungssystem, DRG-Grouper, DWH usw. Die Hierarchie erlaubt Subsumption-basierte Filter (z. B. ?type:below=Sekundaersystem).\n\nStand 2026 existiert kein international etablierter CodeSystem-Standard für Datenquellsystem-Typen im Kontext klinischer Sekundärnutzung. Verwandte, aber nicht direkt anwendbare Quellen: ISO/IEC 25010 (Software-Qualitätsmodell, kein Typ-Katalog), IEC 62304 (Risiko-Klassen für Medizinprodukte-Software), HL7 v3 RoleCode (Einrichtungstypen, nicht IT-Systeme), IHE Actors (profil-spezifische Rollen wie Document Source / Repository), SNOMED CT (sehr grobe Codes wie 706594005 |Information system| oder 308040009 |Hospital information system|), gematik Primärsystem-Definition (TI-spezifisch, nur Primär-Begriff). Dieses CodeSystem ist daher ein MII-spezifischer Vorschlag und kandidiert zur Übernahme in MII-weite Terminologie-Pflege.",
  "caseSensitive" : true,
  "hierarchyMeaning" : "is-a",
  "content" : "complete",
  "count" : 13,
  "concept" : [{
    "code" : "Primaersystem",
    "display" : "Primärsystem",
    "definition" : "System der Primärerfassung am Ort der Versorgung — Daten entstehen hier zum ersten Mal.",
    "concept" : [{
      "code" : "KIS",
      "display" : "Krankenhausinformationssystem",
      "definition" : "Zentrales klinisches Informationssystem des Krankenhauses (Aufnahme, Verlegung, Entlassung, Doku)."
    },
    {
      "code" : "Tumordoku",
      "display" : "Tumordokumentationssystem",
      "definition" : "Spezialsystem zur klinischen Tumordokumentation."
    },
    {
      "code" : "LIS",
      "display" : "Laborinformationssystem",
      "definition" : "System zur Verwaltung von Laborbefunden und -anforderungen."
    },
    {
      "code" : "RIS",
      "display" : "Radiologie-Informationssystem",
      "definition" : "System zur Verwaltung radiologischer Befunde und Untersuchungen."
    },
    {
      "code" : "PACS",
      "display" : "Picture Archiving and Communication System",
      "definition" : "Bildarchivierungssystem (Radiologie, Pathologie etc.)."
    },
    {
      "code" : "OP_Doku",
      "display" : "OP-Dokumentationssystem",
      "definition" : "Dokumentationssystem für operative Eingriffe."
    }]
  },
  {
    "code" : "Sekundaersystem",
    "display" : "Sekundärsystem",
    "definition" : "System, das Daten aus Primärsystemen aufnimmt oder transformiert (zweckgebunden aufbereitet).",
    "concept" : [{
      "code" : "Abrechnungssystem",
      "display" : "Abrechnungssystem",
      "definition" : "System oder Subsystem zur Erstellung von Abrechnungs- und DRG-Datensätzen (§21 KHEntgG, §301 SGB V)."
    },
    {
      "code" : "DRG_Grouper",
      "display" : "DRG-Grouper",
      "definition" : "System zur DRG-/PEPP-Klassifikation."
    },
    {
      "code" : "DWH",
      "display" : "Data Warehouse",
      "definition" : "Konsolidiertes Datenarchiv für Auswertung und Reporting."
    },
    {
      "code" : "Forschungsdaten",
      "display" : "Forschungsdaten- / DIZ-System",
      "definition" : "Forschungsdaten-Plattform oder Datenintegrationszentrum (z. B. MII-DIZ-Repository)."
    },
    {
      "code" : "Krebsregister",
      "display" : "Krebsregister",
      "definition" : "Klinisches oder epidemiologisches Krebsregister."
    }]
  }]
}

```
