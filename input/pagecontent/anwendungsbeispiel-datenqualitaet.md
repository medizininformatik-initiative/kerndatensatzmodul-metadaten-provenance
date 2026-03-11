### Szenario: Datenqualitätsprüfung mit Meta.tag

Neben der Herkunftsdokumentation ist die Datenqualitätsprüfung ein zentraler Anwendungsfall für Provenance-Metadaten. Ergebnisse von DQ-Prüfungen sollen an den geprüften Ressourcen hinterlegt werden, damit nachfolgende Datennutzungen (Forschung, Dashboards, Ausleitung) die Qualität der Daten einschätzen können.

Dieses Beispiel zeigt, wie DQ-Regeln als `Meta.tag` an Ressourcen annotiert werden können -- basierend auf Vorarbeiten von Matthias Löbe (MII Taskforce Metadaten) und dem [DQ-Framework der Universität Greifswald](https://dataquality.qihs.uni-greifswald.de/).

### Konzept: DQ-Regeln als CodeSystem

Ein zentrales CodeSystem definiert DQ-Regeln mit Properties, die den Regeltyp, Vergleichsoperatoren und Grenzwerte beschreiben. Wenn eine Ressource eine Regel erfüllt, wird der entsprechende Code als `meta.tag` gesetzt.

#### Beispielregeln

| Regel | Beschreibung | Typ | Parameter |
|-------|-------------|-----|-----------|
| `OP-1` | OP-Datum muss nach Aufnahmedatum liegen | `after` | Vergleich mit Aufnahme |
| `OP-2` | OP-Termin ist Pflichtfeld | `required` | -- |
| `Discharge-1` | Entlassung mind. 2 Tage nach OP | `after` | min: 2 Tage |
| `DosisMedic-1` | Medikamentendosis ist Pflichtfeld | `required` | konditional: Medikation vorhanden |
| `DosisMedic-2` | Dosis zwischen 50 und 250 mmol | `range` | min: 50, max: 250 |

### Beispiel: Observation mit bestandenen DQ-Prüfungen

Eine Medikamentendosis-Observation hat zwei DQ-Regeln bestanden (Pflichtfeld vorhanden und Wert im erlaubten Bereich). Beide Ergebnisse werden als `meta.tag` annotiert:

```json
{
  "resourceType": "Observation",
  "id": "dq-test-1",
  "meta": {
    "tag": [
      {
        "system": "http://mii.de/CodeSystem/dq-rule-successful",
        "code": "DosisMedic-1",
        "display": "Dosis of medication is a required item."
      },
      {
        "system": "http://mii.de/CodeSystem/dq-rule-successful",
        "code": "DosisMedic-2",
        "display": "Dosis of medication has to be between 50 and 250 mmol."
      }
    ]
  },
  "status": "final",
  "code": {
    "coding": [
      {
        "system": "http://snomed.info/sct",
        "code": "398232005"
      }
    ],
    "text": "Drug dose"
  },
  "subject": { "reference": "Patient/mighty-m" },
  "valueQuantity": {
    "value": 90,
    "unit": "mmol"
  }
}
```

**Interpretation:** Der Wert 90 mmol liegt im erlaubten Bereich (50--250), daher sind beide Regeln (`DosisMedic-1` und `DosisMedic-2`) als bestanden markiert.

### Greifswalder OBC DQ-Framework

Zusätzlich zu projektspezifischen Regeln steht das [DQ-Framework der Universität Greifswald](https://dataquality.qihs.uni-greifswald.de/) als standardisiertes Klassifikationssystem für Datenqualitätsindikatoren zur Verfügung. Es umfasst 34 Indikatoren in 4 Kategorien:

| Kategorie | DQI-Bereich | Beispiele |
|-----------|-------------|-----------|
| **Vollständigkeit** | DQI-1xxx | Unexpected data elements, Duplicates, Data type mismatch |
| **Fehlende Werte** | DQI-2xxx | Missing values, Non-response rate, Drop-out rate |
| **Korrektheit** | DQI-3xxx | Inadmissible values, Logical contradictions, Empirical contradictions |
| **Plausibilität** | DQI-4xxx | Univariate/multivariate outliers, Unexpected distributions, Reliability |

Diese Indikatoren können ebenfalls als `meta.tag` verwendet werden, um systematische DQ-Auffälligkeiten an Ressourcen zu annotieren:

```json
{
  "meta": {
    "tag": [
      {
        "system": "https://www.medizininformatik-initiative.de/fhir/core/modul-meta/CodeSystem/greifswald-obc-dq-framework",
        "code": "https://dataquality.qihs.uni-greifswald.de/#DQI-1003",
        "display": "Duplicates"
      }
    ]
  }
}
```

### Zusammenspiel mit Herkunftsdokumentation

DQ-Prüfungen und Herkunftsdokumentation ergänzen sich:

| Aspekt | Herkunft (Meta.tag) | DQ-Prüfung (Meta.tag) |
|--------|--------------------|-----------------------|
| **Frage** | Woher stammt die Ressource? | Wie gut ist die Datenqualität? |
| **Vokabular** | Datenerhebungskontext, Datentransformation | DQ-Regeln, DQ-Framework-Indikatoren |
| **Zeitpunkt** | Bei Import/Transformation | Nach Import (automatisiert oder manuell) |
| **Beispiel-Tag** | `datenerhebungskontext#abrechnung` | `dq-rule-successful#DosisMedic-2` |

Beide Ansätze nutzen denselben Mechanismus (`meta.tag`) und können an derselben Ressource koexistieren. Eine Observation kann gleichzeitig als "aus oBDS importiert" und "DQ-Regel DosisMedic-2 bestanden" ausgezeichnet sein.

### Offene Fragen

- Sollen fehlgeschlagene DQ-Regeln ebenfalls als Tag annotiert werden (z.B. in einem separaten CodeSystem `dq-rule-failed`)?
- Wie wird mit Regeln umgegangen, die nicht anwendbar sind (z.B. Dosisregel bei einer Ressource ohne Medikation)?
- Soll das Greifswalder DQ-Framework als offizielles MII-Vokabular übernommen werden?
- Wie verhält sich die DQ-Annotation bei Updates der Ressource -- sollen Tags bei erneutem Prüflauf aktualisiert werden?

*Quelle: MII Taskforce Metadaten (Matthias Löbe et al.), Greifswald OBC DQ-Framework*
