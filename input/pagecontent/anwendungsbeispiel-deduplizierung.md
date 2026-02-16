### Szenario: Brustkrebs-Operation

Eine onkologische Operation -- die Entfernung eines Brustkrebs-Tumors -- wird am **12.03.2025** in einem Universitätsklinikum durchgeführt.

#### Schritt 1: Abrechnungsdokumentation (zeitnah)

Die Operation wird im Krankenhausinformationssystem (KIS) dokumentiert und OPS-kodiert. Innerhalb von 24 Stunden steht die Prozedur in den Abrechnungsdaten zur Verfügung. Im Rahmen der KDS-ETL-Strecke des Datenintegrationszentrums (DIZ) wird sie in eine FHIR Procedure-Ressource umgewandelt und in das DIZ-Repository geladen.

**Ergebnis:** `Procedure A` (Quelle: Abrechnung) liegt ab ca. **13.03.2025** im DIZ-Repository vor.

#### Schritt 2: Tumordokumentation und Krebsregistermeldung (Wochen bis Monate)

In den folgenden Wochen wird die klinische Tumordokumentation vervollständigt: Histologie, TNM-Staging, Residualstatus, onkologische Intention und ggf. Komplikationen werden erfasst und zusammengeführt. Die finale Krebsregistermeldung wird am **12.06.2025** an das Landeskrebsregister abgesendet.

#### Schritt 3: oBDS-Reimport (zeitversetzt)

Die Krebsregistermeldung wird mittels einer ETL-Strecke (z.B. [obds-to-fhir](https://github.com/bzkf/obds-to-fhir)) in FHIR-Ressourcen umgewandelt und in das DIZ-Repository integriert. Dabei entsteht eine zweite Procedure-Ressource für dieselbe Operation.

**Ergebnis:** `Procedure B` (Quelle: oBDS-Import) liegt ab ca. **12.06.2025** im DIZ-Repository vor.

#### Schritt 4: Duplikat

Dasselbe operative Ereignis vom 12.03.2025 ist jetzt durch **zwei unabhängige FHIR Procedure-Ressourcen** im Repository abgebildet:

| | Procedure A | Procedure B |
|--|------------|------------|
| **Quelle** | KIS/Abrechnung | oBDS-Meldung |
| **Verfügbar ab** | 13.03.2025 | 12.06.2025 |
| **OPS-Code** | 5-870 | 5-870 |
| **OP-Datum** | 12.03.2025 | 12.03.2025 |
| **Intention** | -- | K (kurativ) |
| **Residualstatus** | -- | R0 |
| **Komplikationen** | -- | HNK |

Procedure B ist in der Regel **reichhaltiger**, da die oBDS-Meldung onkologiespezifische Datenpunkte enthält, die im Abrechnungsdatensatz nicht vorliegen.

### Auswirkung auf nachfolgende Datennutzungen

Für nachfolgende Nutzungen der Daten -- Ausleitung für Forschungsvorhaben, Berichte, Dashboards -- wäre eine Deduplizierung indiziert, um die Datengenauigkeit zu gewährleisten:

- **Forschungsvorhaben**: Doppelte Prozeduren verfälschen Häufigkeitsauswertungen (z.B. "Anzahl der Brustkrebs-OPs pro Jahr")
- **Dashboards**: Überhöhte OP-Zahlen bei Qualitätsindikatoren
- **Datenausleitung (FDPG)**: Nutzende erhalten redundante Datensätze ohne Kontext zur Unterscheidung

### Ablaufdiagramm

<img src="Deduplizierung_Onko_OP.png" alt="Sequenzdiagramm Deduplizierung Onkologie-OP" width="100%"/>

### Herausforderungen

1. **Erkennung**: OPS-Code und Datum stimmen überein, aber die Ressourcen haben unterschiedliche IDs und ggf. leicht abweichende Attribute
2. **Anreicherung**: Die oBDS-Meldung enthält onkologiespezifische Informationen (Intention, Residualstatus, Komplikationen), die im Abrechnungsdatensatz fehlen. Bei einer Zusammenführung sollten diese Informationen erhalten bleiben.
3. **Zeitfenster**: Das OP-Datum kann in beiden Quellen identisch sein oder leicht abweichen
4. **Nachvollziehbarkeit**: Nach einer Zusammenführung muss dokumentiert sein, aus welchen Quellen die finale Ressource entstanden ist

### Offene Fragen

- Soll die Herkunftsmarkierung über `Meta.tag` (Taskforce-Ansatz) oder über eine `Provenance`-Ressource (BZKF-Ansatz) erfolgen?
- Reicht eine einfache Annotation ("diese Prozedur stammt aus dem oBDS") oder wird die volle Provenance-Kette benötigt?
- Wie wird die deduplizierte Ressource mit ihren Quellen verknüpft?
- Sollen die Quellressourcen erhalten bleiben oder durch die deduplizierte Ressource ersetzt werden?
- Wer ist verantwortlich für die Deduplizierung -- das DIZ, die ETL-Strecke, oder ein nachgelagerter Prozess?
