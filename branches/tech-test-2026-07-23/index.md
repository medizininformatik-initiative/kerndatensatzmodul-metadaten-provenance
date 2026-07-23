# Übersicht - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* **Übersicht**

## Übersicht

| | |
| :--- | :--- |
| *Official URL*:https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ImplementationGuide/mii-ig-metadaten-provenance-de-v2026 | *Version*:0.2.0-rc.1 |
| Draft as of 2026-07-23 | *Computable Name*:MII_IG_Metadaten_Provenance_DE |

Dieses Dokument beschreibt Konzepte und Implementierungsalternativen zur Unterstützung einer basalen Provenance im MII-Kerndatensatz. Es dient als informativer Beitrag zur Diskussion innerhalb der Medizininformatik-Initiative und stellt keine verbindliche Festlegung dar.

| | |
| :--- | :--- |
| Datum | 2025-02-16 |
| Version | 0.1.0 |
| Status | Entwurf (informativ) |
| Realm | DE |

### Leitmotiv: Von der Dokumentation zur Aktion

> **Metadaten, die Datenqualität nicht nur beschreiben, sondern operativ steuerbar machen – umsetzbar mit einer Zeile Code (`Meta.tag`) oder als begleitende Ressourceninfrastruktur (`FHIR Provenance`).**

Provenance-Metadaten im MII-Kerndatensatz sind mehr als passive Dokumentation. Sie sind der operative Ankerpunkt, um Datenqualitätsprobleme systematisch zu **erkennen**, zu **lokalisieren** und zu **beheben**:

1. **Beschreiben**– Woher stammen die Daten? Welches Quellsystem, welche ETL-Strecke, welches Datenmodell?
1. **Erkennen**– Welche Probleme haben die Daten? Duplikate, fehlende Werte, Widersprüche zwischen Quellen?
1. **Handeln**– Gezielte Abfragen und Korrekturen auf Basis der Metadaten: alle oBDS-Importe mit logischen Widersprüchen filtern, alle Duplikate eines Zeitraums identifizieren, fehlerhafte ETL-Läufe gezielt nachtransformieren.

Die MII Taskforce Metadaten verbindet dabei wissenschaftliche Grundlagen (Dublin Core, W3C PROV, Greifswalder DQ-Framework) mit der operativen Realität in den Datenintegrationszentren.

**Voraussetzung:** Damit Metadaten actionable sind, müssen sie nicht nur **setzbar** (**settable**), sondern auch **abfragbar** (**retrievable**) sein. Metadaten, die zwar geschrieben, aber nicht über Suchparameter gefunden werden können, verlieren ihren operativen Nutzen. Dies ist eine reale Einschränkung: Bei bestimmten FHIR-Server-Konfigurationen (z.B. HAPI FHIR im INLINE-Modus) ist die `_tag`-Suche standardmäßig nicht verfügbar (siehe [Verhalten von Meta.tag auf FHIR-Servern](ansatz-metatag.md#verhalten-von-metatag-auf-fhir-servern)). Die Wahl des Ansatzes hängt daher auch von der **vorhandenen Infrastruktur** ab.

### Zielsetzung

Versorgungsdaten unterscheiden sich in vielen Punkten von prospektiven Datensammlungen. Diese Unterschiede müssen ausgedrückt werden können, um korrekte Auswertungen zu ermöglichen. Dieses Dokument stellt zwei technische Ansätze zur Provenance-Auszeichnung gegenüber:

1. **Meta.tag-Ansatz**– leichtgewichtige Auszeichnung über kontrollierte Vokabulare in`Resource.meta.tag`(Taskforce Metadaten, Löbe et al.). Pragmatisch, sofort implementierbar, mit einer Zeile Code pro Aussage. Setzt voraus, dass der FHIR-Server die`_tag`-Suche unterstützt.
1. **FHIR Provenance Ressource**– eigene Provenance-Ressourcen mit Referenzen auf Quell- und Zielressourcen (BZKF obds-to-fhir, Gulden). Strukturiert, international interoperabel, mit vollständiger Transformationskette. Unabhängig von der Tag-Konfiguration des Servers, da Provenance als reguläre Ressource gespeichert und durchsucht wird.

Beide Ansätze sind **komplementär**, nicht gegensätzlich. Welcher Ansatz (oder welche Kombination) im konkreten Fall geeignet ist, hängt von den Anforderungen an Aussagekraft, Implementierungsaufwand und der vorhandenen Server-Infrastruktur ab. Sie werden anhand konkreter Beispiele – insbesondere am [Deduplizierungsszenario in der Onkologie](anwendungsbeispiel-deduplizierung.md) mit vollständiger Ressourcen-History – beschrieben und verglichen.

### Beitragende

* MII Taskforce Metadaten (Matthias Löbe et al.) – Konzeptpapier v1.0, Juli 2025
* Christian Gulden (BZKF) – Provenance-Implementierung in obds-to-fhir
* Thomas Debertshäuser (BIH/Charité) – Redaktion und Zusammenführung

### Ansprechpartner

Fragen zu der vorliegenden Publikation können jederzeit unter [chat.fhir.org](https://chat.fhir.org) im Stream 'german/mi-initiative' gestellt werden.

Anmerkungen und Kritik in Form von 'Issues' im [GitHub-Projekt](https://github.com/medizininformatik-initiative/kerndatensatzmodul-metadaten-provenance/issues).

### Disclaimer

Dieser Leitfaden ist ein informativer Beitrag zu Spezifikationsalternativen. Er stellt keine normative Festlegung der Medizininformatik-Initiative dar.



## Resource Content

```json
{
  "resourceType" : "ImplementationGuide",
  "id" : "mii-ig-metadaten-provenance-de-v2026",
  "language" : "de-DE",
  "url" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ImplementationGuide/mii-ig-metadaten-provenance-de-v2026",
  "version" : "0.2.0-rc.1",
  "name" : "MII_IG_Metadaten_Provenance_DE",
  "title" : "MII IG Kerndatensatz-Modul Metadaten Provenance",
  "status" : "draft",
  "date" : "2026-07-23T11:57:36+00:00",
  "publisher" : "Medizininformatik Initiative",
  "contact" : [{
    "name" : "Medizininformatik Initiative",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.medizininformatik-initiative.de/"
    }]
  }],
  "description" : "MII Modul zur Dokumentation der Herkunft und Deduplizierung onkologischer Prozeduren (oBDS-Import vs. Abrechnung)",
  "packageId" : "mii-ig-metadaten-provenance-de-v2026",
  "license" : "CC0-1.0",
  "fhirVersion" : ["4.0.1"],
  "dependsOn" : [{
    "id" : "hl7tx",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on HL7 Terminology"
    }],
    "uri" : "http://terminology.hl7.org/ImplementationGuide/hl7.terminology",
    "packageId" : "hl7.terminology.r4",
    "version" : "7.2.0"
  },
  {
    "id" : "hl7ext",
    "extension" : [{
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/implementationguide-dependency-comment",
      "valueMarkdown" : "Automatically added as a dependency - all IGs depend on the HL7 Extension Pack"
    }],
    "uri" : "http://hl7.org/fhir/extensions/ImplementationGuide/hl7.fhir.uv.extensions",
    "packageId" : "hl7.fhir.uv.extensions.r4",
    "version" : "5.3.0"
  },
  {
    "id" : "de_basisprofil_r4",
    "uri" : "http://fhir.org/packages/de.basisprofil.r4/ImplementationGuide/de.basisprofil.r4",
    "packageId" : "de.basisprofil.r4",
    "version" : "1.5.x"
  },
  {
    "id" : "de_medizininformatikinitiative_kerndatensatz_meta",
    "uri" : "https://www.medizininformatik-initiative.de/fhir/modul-meta/ImplementationGuide/mii-ig-meta",
    "packageId" : "de.medizininformatikinitiative.kerndatensatz.meta",
    "version" : "2026.0.x"
  },
  {
    "id" : "de_medizininformatikinitiative_kerndatensatz_base",
    "uri" : "https://www.medizininformatik-initiative.de/fhir/modul-base/ImplementationGuide/mii-ig-base",
    "packageId" : "de.medizininformatikinitiative.kerndatensatz.base",
    "version" : "2026.0.x"
  },
  {
    "id" : "de_medizininformatikinitiative_kerndatensatz_onkologie",
    "uri" : "http://fhir.org/packages/de.medizininformatikinitiative.kerndatensatz.onkologie/ImplementationGuide/de.medizininformatikinitiative.kerndatensatz.onkologie",
    "packageId" : "de.medizininformatikinitiative.kerndatensatz.onkologie",
    "version" : "2026.0.x"
  }],
  "definition" : {
    "extension" : [{
      "extension" : [{
        "url" : "code",
        "valueString" : "copyrightyear"
      },
      {
        "url" : "value",
        "valueString" : "2025+"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "releaselabel"
      },
      {
        "url" : "value",
        "valueString" : "ci-build"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "autoload-resources"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "template/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "input/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-qa"
      },
      {
        "url" : "value",
        "valueString" : "temp/qa"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-temp"
      },
      {
        "url" : "value",
        "valueString" : "temp/pages"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-output"
      },
      {
        "url" : "value",
        "valueString" : "output"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-suppressed-warnings"
      },
      {
        "url" : "value",
        "valueString" : "input/ignoreWarnings.txt"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "path-history"
      },
      {
        "url" : "value",
        "valueString" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/history.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "template-html"
      },
      {
        "url" : "value",
        "valueString" : "template-page.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "template-md"
      },
      {
        "url" : "value",
        "valueString" : "template-page-md.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-contact"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-context"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-copyright"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-jurisdiction"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-license"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-publisher"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-version"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "apply-wg"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "active-tables"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "fmm-definition"
      },
      {
        "url" : "value",
        "valueString" : "http://hl7.org/fhir/versions.html#maturity"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "propagate-status"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "excludelogbinaryformat"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueString" : "tabbed-snapshots"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-internal-dependency",
      "valueCode" : "hl7.fhir.uv.tools.r4#1.1.2"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "copyrightyear"
      },
      {
        "url" : "value",
        "valueString" : "2025+"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "releaselabel"
      },
      {
        "url" : "value",
        "valueString" : "ci-build"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "autoload-resources"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "template/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-liquid"
      },
      {
        "url" : "value",
        "valueString" : "input/liquid"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-qa"
      },
      {
        "url" : "value",
        "valueString" : "temp/qa"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-temp"
      },
      {
        "url" : "value",
        "valueString" : "temp/pages"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-output"
      },
      {
        "url" : "value",
        "valueString" : "output"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-suppressed-warnings"
      },
      {
        "url" : "value",
        "valueString" : "input/ignoreWarnings.txt"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "path-history"
      },
      {
        "url" : "value",
        "valueString" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/history.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "template-html"
      },
      {
        "url" : "value",
        "valueString" : "template-page.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "template-md"
      },
      {
        "url" : "value",
        "valueString" : "template-page-md.html"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-contact"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-context"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-copyright"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-jurisdiction"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-license"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-publisher"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-version"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "apply-wg"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "active-tables"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "fmm-definition"
      },
      {
        "url" : "value",
        "valueString" : "http://hl7.org/fhir/versions.html#maturity"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "propagate-status"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "excludelogbinaryformat"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    },
    {
      "extension" : [{
        "url" : "code",
        "valueCode" : "tabbed-snapshots"
      },
      {
        "url" : "value",
        "valueString" : "true"
      }],
      "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-parameter"
    }],
    "resource" : [{
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-primary.html"
      }],
      "reference" : {
        "reference" : "ValueSet/primary"
      },
      "name" : "Alle_DQ_Indikatoren_VS",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Bundle"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Bundle-bundle-abrechnungskontext-mi-001.html"
      }],
      "reference" : {
        "reference" : "Bundle/bundle-abrechnungskontext-mi-001"
      },
      "name" : "Bundle: Abrechnungskontext (Beispielfall mi-001)",
      "description" : "Collection-Bundle mit allen Ressourcen des Anwendungsbeispiels Abrechnungsdatenkontext.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Condition"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Condition-cond-mi-001-hd-i21.html"
      }],
      "reference" : {
        "reference" : "Condition/cond-mi-001-hd-i21"
      },
      "name" : "Condition: Hauptdiagnose I21.0",
      "description" : "Akuter transmuraler Myokardinfarkt der Vorderwand (HD nach §21/§301).",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Condition"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Condition-cond-mi-001-nd-i10.html"
      }],
      "reference" : {
        "reference" : "Condition/cond-mi-001-nd-i10"
      },
      "name" : "Condition: Nebendiagnose I10.90",
      "description" : "Essentielle Hypertonie als Nebendiagnose. Erlöswirksam nach DRG-Logik (PCCL-relevant), wird daher in §21/§301 standardmäßig codiert.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Device"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Device-etl-p21-fhir-v142.html"
      }],
      "reference" : {
        "reference" : "Device/etl-p21-fhir-v142"
      },
      "name" : "Device: ETL-Pipeline KIS-DRG → FHIR (v1.4.2)",
      "description" : "Versionierte ETL-Pipeline, die aus dem KIS-DRG-Aufbereitungsstand FHIR-Ressourcen für das DIZ erzeugt. Diese Pipeline ist der Author der FHIR-Ressourcen — nicht das datenliefernde Krankenhaus selbst und nicht der G-DRG-Grouper.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Device"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Device-src-ikarus-kis-ukb.html"
      }],
      "reference" : {
        "reference" : "Device/src-ikarus-kis-ukb"
      },
      "name" : "Device: Ikarus-KIS am UKB (Quellsystem)",
      "description" : "Krankenhausinformationssystem 'Ikarus-KIS' (fiktiver Hersteller mit Anlehnung an reale KIS-Anbieter) am UKB, hier in der Rolle als Quellsystem für DRG-aufbereitete Routinedaten. Klassifiziert per MII-CodeSystem als Sekundärsystem (zweckgebunden aufbereitet).",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "DocumentReference"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "DocumentReference-kis-drg-aufbereitung-2026-03-15.html"
      }],
      "reference" : {
        "reference" : "DocumentReference/kis-drg-aufbereitung-2026-03-15"
      },
      "name" : "DocumentReference: KIS-DRG-Aufbereitungsstand 2026-03-15",
      "description" : "DRG-aufbereiteter Stand der KIS-Routinedaten zum Aufenthalt enc-mi-001. Gemeinsame Quelle für §21-CSV (an InEK), §301-DTA (an Krankenkasse) und FHIR-Bundle (ins DIZ).",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Observation"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Observation-dq-test-1.html"
      }],
      "reference" : {
        "reference" : "Observation/dq-test-1"
      },
      "name" : "dq-test-1",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-dq-rule-successful.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/dq-rule-successful"
      },
      "name" : "DQ_Rule_Successful",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Encounter"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Encounter-enc-mi-001.html"
      }],
      "reference" : {
        "reference" : "Encounter/enc-mi-001"
      },
      "name" : "Encounter (Aufenthalt 1.-15.3.2026)",
      "description" : "Stationärer Aufenthalt mit Notfallaufnahme wegen akutem STEMI.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-Greifswald-OBC-DQ-Framework.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/Greifswald-OBC-DQ-Framework"
      },
      "name" : "Greifswald OBC DQ-Framework",
      "description" : "Data Quality Framework by COS.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Patient"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Patient-mighty-m.html"
      }],
      "reference" : {
        "reference" : "Patient/mighty-m"
      },
      "name" : "mighty-m",
      "description" : "Example of Patient",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-mii-cs-datenquellsystem.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/mii-cs-datenquellsystem"
      },
      "name" : "MII CS Datenquellsystem",
      "description" : "Hierarchisches CodeSystem zur Klassifikation von Datenquellsystemen. Top-Level unterscheidet Primärsysteme (Erfassung am Ort der Versorgung) von Sekundärsystemen (Aufnahme/Transformation aus Primärsystemen). Darunter konkrete Systemtypen wie KIS, Abrechnungssystem, DRG-Grouper, DWH usw. Die Hierarchie erlaubt Subsumption-basierte Filter (z. B. ?type:below=Sekundaersystem).\n\nStand 2026 existiert kein international etablierter CodeSystem-Standard für Datenquellsystem-Typen im Kontext klinischer Sekundärnutzung. Verwandte, aber nicht direkt anwendbare Quellen: ISO/IEC 25010 (Software-Qualitätsmodell, kein Typ-Katalog), IEC 62304 (Risiko-Klassen für Medizinprodukte-Software), HL7 v3 RoleCode (Einrichtungstypen, nicht IT-Systeme), IHE Actors (profil-spezifische Rollen wie Document Source / Repository), SNOMED CT (sehr grobe Codes wie 706594005 |Information system| oder 308040009 |Hospital information system|), gematik Primärsystem-Definition (TI-spezifisch, nur Primär-Begriff). Dieses CodeSystem ist daher ein MII-spezifischer Vorschlag und kandidiert zur Übernahme in MII-weite Terminologie-Pflege.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "CodeSystem"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "CodeSystem-mii-cs-provenance-prozedur-herkunft.html"
      }],
      "reference" : {
        "reference" : "CodeSystem/mii-cs-provenance-prozedur-herkunft"
      },
      "name" : "MII CS Provenance Prozedur Herkunft",
      "description" : "CodeSystem für die Herkunft onkologischer Prozeduren zur Unterscheidung von Datenquellen und Deduplizierungsstatus.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "StructureDefinition:resource"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "StructureDefinition-mii-pr-provenance-prozedur-herkunft.html"
      }],
      "reference" : {
        "reference" : "StructureDefinition/mii-pr-provenance-prozedur-herkunft"
      },
      "name" : "MII PR Provenance Ressourcen-Herkunft",
      "description" : "Provenance-Profil zur Dokumentation der Herkunft onkologischer FHIR-Ressourcen (oBDS-Import vs. Abrechnung) und des Deduplizierungsstatus. Anwendbar auf Prozeduren, Diagnosen, Tumorkonferenzen und weitere Ressourcentypen.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "SearchParameter"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "SearchParameter-mii-sp-provenance-reason.html"
      }],
      "reference" : {
        "reference" : "SearchParameter/mii-sp-provenance-reason"
      },
      "name" : "MII SP Provenance Reason",
      "description" : "Suchparameter für Provenance.reason. Ermöglicht das Filtern aller Provenance-Ressourcen nach Geschäftsgrund — insbesondere HPAYMT (Abrechnungskontext) für die Identifikation von Daten aus DRG-aufbereiteten Routinedatenstrecken (§21, §301 etc.). In FHIR R4 nicht als Standard-Suchparameter definiert.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-mii-vs-provenance-prozedur-herkunft.html"
      }],
      "reference" : {
        "reference" : "ValueSet/mii-vs-provenance-prozedur-herkunft"
      },
      "name" : "MII VS Provenance Prozedur Herkunft",
      "description" : "Value Set für die Herkunft onkologischer Prozeduren zur Unterscheidung von Datenquellen und Deduplizierungsstatus.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Organization"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Organization-org-ukb.html"
      }],
      "reference" : {
        "reference" : "Organization/org-ukb"
      },
      "name" : "Organization: Universitätsklinikum Beispielstadt",
      "description" : "Datenlieferndes Krankenhaus, identifiziert über IKNR.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Patient"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Patient-pat-mi-001.html"
      }],
      "reference" : {
        "reference" : "Patient/pat-mi-001"
      },
      "name" : "Patient (Beispielfall Myokardinfarkt)",
      "description" : "Pseudonymisierter Beispielpatient für den Anwendungsfall Abrechnungsdatenkontext.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "ValueSet"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "ValueSet-procedure-intent-vs.html"
      }],
      "reference" : {
        "reference" : "ValueSet/procedure-intent-vs"
      },
      "name" : "Procedure Intent Value Set",
      "description" : "The purpose of a procedure.",
      "exampleBoolean" : false
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Procedure"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Procedure-proc-mi-001-ptca.html"
      }],
      "reference" : {
        "reference" : "Procedure/proc-mi-001-ptca"
      },
      "name" : "Procedure: PTCA mit DES (8-837.k0)",
      "description" : "Perkutane transluminale Koronarangioplastie mit Implantation eines Drug-Eluting-Stents.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Provenance"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Provenance-prov-abrechnungskontext-mi-001.html"
      }],
      "reference" : {
        "reference" : "Provenance/prov-abrechnungskontext-mi-001"
      },
      "name" : "Provenance: Abrechnungskontext-ETL für Aufenthalt mi-001",
      "description" : "Dokumentiert, dass die FHIR-Ressourcen aus einer DRG-aufbereiteten Routinedatenstrecke stammen (Abrechnungskontext nach §21/§301-Inhaltsspec), erzeugt zeitnah durch eine versionierte ETL-Pipeline aus dem KIS-DRG-Aufbereitungsstand.",
      "exampleBoolean" : true
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Provenance"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Provenance-mii-exa-provenance-deduplizierung.html"
      }],
      "reference" : {
        "reference" : "Provenance/mii-exa-provenance-deduplizierung"
      },
      "name" : "Provenance: Deduplizierung",
      "description" : "Beispiel: Die OP-Prozedur wurde durch Zusammenführung der Abrechnungsprozedur (op-1 v1) und der oBDS-Importprozedur (op-2 v1) dedupliziert. Das Ergebnis ist op-1 v2.",
      "exampleCanonical" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Provenance"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Provenance-mii-exa-provenance-abrechnung-import.html"
      }],
      "reference" : {
        "reference" : "Provenance/mii-exa-provenance-abrechnung-import"
      },
      "name" : "Provenance: Erstanlage aus Abrechnung",
      "description" : "Beispiel: Die OP-Prozedur wurde aus den Abrechnungsdaten (KIS) in das DIZ-Repository importiert.",
      "exampleCanonical" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Provenance"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Provenance-mii-exa-provenance-obds-import.html"
      }],
      "reference" : {
        "reference" : "Provenance/mii-exa-provenance-obds-import"
      },
      "name" : "Provenance: Erstanlage aus oBDS-Import",
      "description" : "Beispiel: Die OP-Prozedur wurde aus dem oBDS-Melderegister via obds-to-fhir ETL in das DIZ-Repository importiert.",
      "exampleCanonical" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Provenance"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Provenance-mii-exa-provenance-obds-import-diagnose.html"
      }],
      "reference" : {
        "reference" : "Provenance/mii-exa-provenance-obds-import-diagnose"
      },
      "name" : "Provenance: Erstanlage Diagnose aus oBDS-Import",
      "description" : "Beispiel: Die Primärtumor-Diagnose wurde aus dem oBDS-Melderegister via obds-to-fhir ETL in das DIZ-Repository importiert.",
      "exampleCanonical" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft"
    },
    {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/resource-information",
        "valueString" : "Provenance"
      },
      {
        "url" : "http://hl7.org/fhir/StructureDefinition/implementationguide-page",
        "valueUri" : "Provenance-mii-exa-provenance-obds-import-tumorkonferenz.html"
      }],
      "reference" : {
        "reference" : "Provenance/mii-exa-provenance-obds-import-tumorkonferenz"
      },
      "name" : "Provenance: Erstanlage Tumorkonferenz aus oBDS-Import",
      "description" : "Beispiel: Der Tumorkonferenz-CarePlan wurde aus dem oBDS-Melderegister via obds-to-fhir ETL in das DIZ-Repository importiert.",
      "exampleCanonical" : "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft"
    }],
    "page" : {
      "extension" : [{
        "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
        "valueUrl" : "toc.html"
      }],
      "nameUrl" : "toc.html",
      "title" : "Table of Contents",
      "generation" : "html",
      "page" : [{
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "index.html"
        }],
        "nameUrl" : "index.html",
        "title" : "Übersicht",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "motivation.html"
        }],
        "nameUrl" : "motivation.html",
        "title" : "Motivation und Problemstellung",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "technische-grundlagen.html"
        }],
        "nameUrl" : "technische-grundlagen.html",
        "title" : "Technische Grundlagen",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "isik.html"
        }],
        "nameUrl" : "isik.html",
        "title" : "ISiK: Kennzeichnung von Fremdübernahmen",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "ansatz-metatag.html"
        }],
        "nameUrl" : "ansatz-metatag.html",
        "title" : "Ansatz 1: Meta.tag (Taskforce Metadaten)",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "ansatz-fhir-provenance.html"
        }],
        "nameUrl" : "ansatz-fhir-provenance.html",
        "title" : "Ansatz 2: FHIR Provenance Ressource (BZKF)",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "usecase-katalog.html"
        }],
        "nameUrl" : "usecase-katalog.html",
        "title" : "Use-Case-Katalog",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "anwendungsbeispiel-deduplizierung.html"
        }],
        "nameUrl" : "anwendungsbeispiel-deduplizierung.html",
        "title" : "Anwendungsbeispiel: Deduplizierung Onkologie-Prozedur",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "anwendungsbeispiel-datenqualitaet.html"
        }],
        "nameUrl" : "anwendungsbeispiel-datenqualitaet.html",
        "title" : "Anwendungsbeispiel: Datenqualitätsprüfung",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "anwendungsbeispiel-abrechnungskontext.html"
        }],
        "nameUrl" : "anwendungsbeispiel-abrechnungskontext.html",
        "title" : "Anwendungsbeispiel: Abrechnungsdatenkontext (KHEntgG, SGB V, DRG)",
        "generation" : "markdown"
      },
      {
        "extension" : [{
          "url" : "http://hl7.org/fhir/tools/StructureDefinition/ig-page-name",
          "valueUrl" : "dq-framework.html"
        }],
        "nameUrl" : "dq-framework.html",
        "title" : "Datenqualitätsindikatoren (DQ-Framework)",
        "generation" : "markdown"
      }]
    },
    "parameter" : [{
      "code" : "path-resource",
      "value" : "input/capabilities"
    },
    {
      "code" : "path-resource",
      "value" : "input/examples"
    },
    {
      "code" : "path-resource",
      "value" : "input/extensions"
    },
    {
      "code" : "path-resource",
      "value" : "input/models"
    },
    {
      "code" : "path-resource",
      "value" : "input/operations"
    },
    {
      "code" : "path-resource",
      "value" : "input/profiles"
    },
    {
      "code" : "path-resource",
      "value" : "input/resources"
    },
    {
      "code" : "path-resource",
      "value" : "input/vocabulary"
    },
    {
      "code" : "path-resource",
      "value" : "input/maps"
    },
    {
      "code" : "path-resource",
      "value" : "input/testing"
    },
    {
      "code" : "path-resource",
      "value" : "input/history"
    },
    {
      "code" : "path-resource",
      "value" : "fsh-generated/resources"
    },
    {
      "code" : "path-pages",
      "value" : "template/config"
    },
    {
      "code" : "path-pages",
      "value" : "input/images"
    },
    {
      "code" : "path-tx-cache",
      "value" : "input-cache/txcache"
    }]
  }
}

```
