### Konzept

Die [US Core Basic Provenance](https://www.hl7.org/fhir/us/core/basic-provenance.html) Spezifikation ist der bislang am weitesten verbreitete Implementierungsleitfaden für FHIR Provenance. Sie definiert einen pragmatischen Ansatz, der sich auf die wesentlichen Informationen beschränkt und als Vorbild für eine MII-Adaption dienen kann.

### Der "Last Hop"-Ansatz

Statt die vollständige Provenance-Kette einer Ressource zu rekonstruieren, fokussiert US Core auf den **"Last Hop"**:

> "The most important information is the last organization making a meaningful clinical update to the data and the prior system providing it."

Dieser Ansatz ist pragmatisch: Er beantwortet die häufigsten Fragen (Wer hat zuletzt geändert? Woher kam die Information?) ohne den vollen Aufwand einer lückenlosen Provenance-Kette.

### Sechs Kernelemente

US Core definiert sechs Elemente als Basis jeder Provenance-Aussage:

| Element | FHIR-Mapping | Beschreibung |
|---------|-------------|--------------|
| **Timestamp** | `Provenance.recorded` | Zeitpunkt der Erstellung/Änderung (mit Zeitzone) |
| **Target Resource** | `Provenance.target` | Die Ressource, über die eine Aussage getroffen wird |
| **Author** | `Provenance.agent.who` | Person, die für die Daten verantwortlich ist |
| **Author Organization** | `Provenance.agent.onBehalfOf` | Organisation des Autors |
| **Transmitter** | `Provenance.agent.who` | System, das die Information übermittelt hat |
| **Transmitter Organization** | `Provenance.agent.onBehalfOf` | Organisation des Transmitters |

### Use Cases

#### 1. Clinical Information Reconciliation and Incorporation (CIRI)

Externe klinische Daten (z.B. von anderen Krankenhäusern, Health Information Exchanges) werden von einem Kliniker geprüft, abgeglichen und in das lokale System übernommen. Bei der Übernahme wird der prüfende Kliniker zum neuen Autor.

**MII-Analogie:** Zusammenführung von oBDS-Import und Abrechnungsdaten (Merge/Deduplizierung). Das DIZ übernimmt die Rolle des "Reconcilers".

#### 2. HIE Redistribution

Eine Health Information Exchange leitet klinische Informationen ohne inhaltliche Veränderung weiter. Autorenschaft bleibt beim Original, die HIE wird als Transmitter dokumentiert.

**MII-Analogie:** ETL-Import von oBDS-Daten ohne inhaltliche Transformation -- die Daten werden lediglich in FHIR konvertiert und weitergeleitet.

#### 3. HIE Transformation

Eine HIE empfängt Daten in einem Format (HL7 v2, CDA) und transformiert sie in ein anderes (FHIR). Die Autorenschaft kann auf die HIE als Transformer übergehen.

**MII-Analogie:** obds-to-fhir ETL-Strecke (Gulden/BZKF), die oBDS-XML in MII-KDS-konforme FHIR-Ressourcen umwandelt. Auch: Pseudonymisierung als Transformation.

#### 4. Single-Site Acceptance

Ein Arzt bestätigt eingehende Daten ohne externe Abstimmung. Der akzeptierende Arzt wird zum Autor.

**MII-Analogie:** Qualitätsprüfung/Validierung durch das DIZ.

### Übertragbarkeit auf die MII

Der US Core Ansatz lässt sich gut auf die MII übertragen, erfordert aber Anpassungen:

| US Core | MII-Kontext | Unterschied |
|---------|-------------|-------------|
| Fokus auf Kliniker als Author | Fokus auf Systeme/Organisationen als Agent | In der MII sind ETL-Tools und DIZ die Hauptakteure, nicht einzelne Kliniker |
| NPI als Identifier | Keine einheitliche Organisationskennung | MII benötigt eigenes Identifikationsschema für DIZ und ETL-Tools |
| Kein Spec-Migrations-Use-Case | Jährliche Ballot-Zyklen, oBDS-Versionsänderungen | MII-spezifischer Bedarf für technische Migrationen |
| Kein Pseudonymisierungs-Use-Case | Datenschutzanforderungen (FDPG-Ausleitung) | MII-spezifischer Bedarf |

*Quelle: [US Core Basic Provenance (v8.0.0)](https://www.hl7.org/fhir/us/core/basic-provenance.html), [HL7 Basic Provenance IG](https://confluence.hl7.org/display/SEC/Basic+Provenance+Implementation+Guide)*
