### Metadaten als Ankerpunkt für Datenqualität

Provenance-Metadaten dienen nicht nur der passiven Dokumentation der Datenherkunft. Sie sind der **zentrale Ankerpunkt, um Datenqualitätsprobleme systematisch zu erkennen, zu lokalisieren und zu beheben**.

Der Zusammenhang ist direkt: Wenn bekannt ist, *woher* eine Ressource stammt (Abrechnung, oBDS, manueller Import), *wann* sie transformiert wurde und *durch welches System*, dann lassen sich DQ-Fehler gezielt zuordnen:

- **Erkennung**: Über `_tag`-Suchen können alle Ressourcen mit einem bestimmten DQ-Problem gefiltert werden -- z.B. alle Duplikate (`DQI-1003`) oder alle Werte außerhalb des erlaubten Bereichs (`DQI-3001`).
- **Lokalisierung**: Die Herkunfts-Tags zeigen, *welche Quelle* das Problem verursacht hat -- liegt der Fehler in der KIS-ETL-Strecke oder im oBDS-Import?
- **Behebung**: Über die Kombination von Herkunfts- und DQ-Tags lassen sich gezielte Korrekturen anstoßen -- z.B. "alle Prozeduren aus `obds-import` mit `DQI-3002` (ungültige Datumswerte) erneut transformieren".

```
GET [base]/Procedure?_tag=obds-import&_tag=https://...greifswald-obc-dq-framework|DQI-3002
```

Ohne Metadaten bleiben DQ-Probleme unsichtbar oder müssen aufwendig manuell recherchiert werden. **Die Metadaten machen die Datenqualität abfragbar und adressierbar.**

---

### Greifswald OBC DQ-Framework

Das [Datenqualitäts-Framework der Universität Greifswald](https://dataquality.qihs.uni-greifswald.de/) (COS -- Center of Open Science) definiert ein standardisiertes Klassifikationssystem für Datenqualitätsindikatoren. Es bietet eine systematische Kategorisierung von DQ-Problemen, die in klinischen und Forschungsdatensätzen auftreten können.

Das Framework ist in **4 Hauptkategorien** mit insgesamt **34 Indikatoren** gegliedert. Jeder Indikator hat einen eindeutigen Code (`DQI-XXXX`), einen englischen Kurznamen und eine Definition.

{% raw %}
<div markdown="1" class="bg-info">
**Hinweis:** Die Zuordnung des Greifswalder DQ-Frameworks zum Meta.tag-Ansatz der Taskforce Metadaten ist ein erster Entwurf. Die genaue Abbildung auf MII-Vokabulare (Datenqualitätsannotation, Datenqualitätsprüfung, Datenqualitätsstufe, Validierung) wird in der Community abgestimmt.
</div>
{% endraw %}

---

### Kategorie 1: Integrität (DQI-1xxx)

Prüft, ob die **Struktur und Vollständigkeit der Datenelemente** den Erwartungen entspricht -- unabhängig von den konkreten Werten.

| Code | Indikator | Beschreibung |
|------|-----------|-------------|
| DQI-1001 | Unexpected data elements | Die beobachtete Menge an Datenelementen stimmt nicht mit der erwarteten überein. |
| DQI-1002 | Unexpected data records | Die beobachtete Menge an Datensätzen stimmt nicht mit der erwarteten überein. |
| DQI-1003 | Duplicates | Dieselben Datenelemente oder Datensätze erscheinen mehrfach. |
| DQI-1004 | Data record mismatch | Datensätze aus verschiedenen Datenquellen stimmen nicht wie erwartet überein. |
| DQI-1005 | Data element mismatch | Datenelemente aus verschiedenen Datenquellen stimmen nicht wie erwartet überein. |
| DQI-1006 | Data type mismatch | Der beobachtete Datentyp stimmt nicht mit dem erwarteten überein. |
| DQI-1007 | Inhomogeneous value formats | Die Werte haben über verschiedene Datenfelder hinweg inhomogene Formate. |
| DQI-1008 | Uncertain missingness status | Systemseitige Missing-Werte (NA, Null, etc.) erscheinen dort, wo ein qualifizierter Missing-Code erwartet wird. |

**MII-Bezug:** DQI-1003 (Duplicates) ist direkt relevant für das [Deduplizierungsszenario](anwendungsbeispiel-deduplizierung.html) -- die Erkennung von Duplikaten zwischen Abrechnungs- und oBDS-Prozeduren.

---

### Kategorie 2: Vollständigkeit (DQI-2xxx)

Prüft, ob **alle erwarteten Werte vorhanden** sind.

| Code | Indikator | Beschreibung |
|------|-----------|-------------|
| DQI-2001 | Missing values | Datenfelder ohne Messwert. |
| DQI-2002 | Non-response rate | Anteil der berechtigten Beobachtungseinheiten, für die keine Information erhoben werden konnte. |
| DQI-2003 | Refusal rate | Anteil der berechtigten Personen, die die Informationsgabe verweigern. |
| DQI-2004 | Drop-out rate | Anteil der Teilnehmenden, die die Studie vorzeitig abbrechen. |
| DQI-2005 | Missing due to specified reason | Fehlende Information aufgrund eines spezifizierten Grundes. |

**MII-Bezug:** DQI-2001 (Missing values) kann z.B. genutzt werden, um Ressourcen zu markieren, bei denen Pflichtfelder im MII-KDS fehlen (etwa fehlende Diagnosesicherung bei einer Onkologie-Diagnose).

---

### Kategorie 3: Korrektheit (DQI-3xxx)

Prüft, ob die **Werte innerhalb der erlaubten Bereiche und logisch konsistent** sind.

| Code | Indikator | Beschreibung |
|------|-----------|-------------|
| DQI-3001 | Inadmissible numerical values | Numerische Werte liegen außerhalb der erlaubten Bereiche. |
| DQI-3002 | Inadmissible time-date values | Datums-/Zeitwerte liegen außerhalb der erlaubten Bereiche. |
| DQI-3003 | Inadmissible categorical values | Kategoriale Werte entsprechen nicht den erlaubten Kategorien. |
| DQI-3004 | Inadmissible standardized vocabulary | Werte entsprechen nicht dem Referenzvokabular. |
| DQI-3005 | Inadmissible precision | Die Präzision numerischer Werte entspricht nicht der erwarteten. |
| DQI-3006 | Uncertain numerical values | Numerische Werte sind unsicher oder unwahrscheinlich (außerhalb erwarteter Bereiche). |
| DQI-3007 | Uncertain time-date values | Datumswerte sind unsicher oder unwahrscheinlich (außerhalb erwarteter Bereiche). |
| DQI-3008 | Logical contradictions | Verschiedene Datenwerte erscheinen in logisch unmöglichen Kombinationen. |
| DQI-3009 | Empirical contradictions | Verschiedene Datenwerte erscheinen in Kombinationen, die empirisch als unmöglich gelten. |

**MII-Bezug:**
- DQI-3002 kann z.B. OP-Daten markieren, bei denen das Operationsdatum vor dem Geburtsdatum liegt.
- DQI-3004 ist relevant für die FHIR-Validierung -- Codes, die nicht im gebundenen ValueSet enthalten sind.
- DQI-3008 kann Widersprüche zwischen Abrechnungs- und oBDS-Daten kennzeichnen (z.B. unterschiedliche OPS-Codes für dieselbe OP).

---

### Kategorie 4: Plausibilität (DQI-4xxx)

Prüft, ob die **statistischen Eigenschaften der Daten** den Erwartungen entsprechen -- basierend auf Verteilungen, Assoziationen und Reliabilität.

| Code | Indikator | Beschreibung |
|------|-----------|-------------|
| DQI-4001 | Univariate outliers | Numerische Werte weichen in univariater Analyse deutlich ab. |
| DQI-4002 | Multivariate outliers | Numerische Werte weichen in multivariater Analyse deutlich ab. |
| DQI-4003 | Unexpected locations | Beobachtete Lageparameter weichen von erwarteten ab. |
| DQI-4004 | Unexpected shape | Die beobachtete Verteilungsform weicht von der erwarteten ab. |
| DQI-4005 | Unexpected scale | Beobachtete Skalenparameter weichen von erwarteten ab. |
| DQI-4006 | Unexpected proportions | Beobachtete Anteile weichen von erwarteten ab. |
| DQI-4007 | Unexpected association strength | Die beobachtete Stärke einer Assoziation weicht von der erwarteten ab. |
| DQI-4008 | Unexpected association direction | Die beobachtete Richtung einer Assoziation weicht von der erwarteten ab. |
| DQI-4009 | Unexpected association form | Die beobachtete Form einer Assoziation weicht von der erwarteten ab. |
| DQI-4010 | Inter-Class reliability | Unterschiede zwischen Klassen (z.B. Untersuchenden) bei Messung derselben Objekte. |
| DQI-4011 | Intra-Class reliability | Unterschiede innerhalb von Klassen bei Messung derselben Objekte. |
| DQI-4012 | Disagreement with gold standard | Unterschiede zu einem Goldstandard bei Messung derselben Objekte. |

**MII-Bezug:** DQI-4001 (Outliers) könnte z.B. Laborwerte markieren, die statistisch deutlich von der erwarteten Verteilung abweichen. DQI-4006 kann auf Standortebene genutzt werden, um ungewöhnliche Häufigkeitsverteilungen zu identifizieren.

---

### Technische Umsetzung als Meta.tag

Jeder DQI-Indikator kann als `meta.tag` an einer FHIR-Ressource annotiert werden:

```json
{
  "meta": {
    "tag": [
      {
        "system": "https://www.medizininformatik-initiative.de/fhir/core/modul-meta/CodeSystem/greifswald-obc-dq-framework",
        "code": "https://dataquality.qihs.uni-greifswald.de/#DQI-3008",
        "display": "Logical contradictions"
      }
    ]
  }
}
```

#### Anwendung: Widerspruch zwischen Abrechnungs- und oBDS-Daten

Im [Deduplizierungsszenario](anwendungsbeispiel-deduplizierung.html) könnten vor der Zusammenführung DQ-Indikatoren gesetzt werden, um erkannte Probleme zu dokumentieren:

```json
{
  "resourceType": "Procedure",
  "id": "op-1",
  "meta": {
    "versionId": "2",
    "tag": [
      {
        "system": "http://www.medizininformatik-initiative.de/fhir/CodeSystem/mii-cs-datenerhebungskontext",
        "code": "abrechnung",
        "display": "Abrechnung/Routinedaten"
      },
      {
        "system": "http://www.medizininformatik-initiative.de/fhir/CodeSystem/mii-cs-datentransformation",
        "code": "deduplizierung",
        "display": "Deduplizierung/Zusammenführung"
      },
      {
        "system": "https://www.medizininformatik-initiative.de/fhir/core/modul-meta/CodeSystem/greifswald-obc-dq-framework",
        "code": "https://dataquality.qihs.uni-greifswald.de/#DQI-1003",
        "display": "Duplicates"
      }
    ]
  }
}
```

In diesem Beispiel werden **drei Arten von Tags** kombiniert:
1. **Herkunft** (`datenerhebungskontext#abrechnung`) -- woher stammen die Daten?
2. **Transformation** (`datentransformation#deduplizierung`) -- was wurde mit den Daten gemacht?
3. **Datenqualität** (`DQI-1003`) -- welche DQ-Auffälligkeiten wurden erkannt?

### Mapping auf Taskforce-Vokabulare

Das Greifswalder DQ-Framework lässt sich auf die von der Taskforce Metadaten definierten Vokabulare der [Gruppe Datenqualität und Kuration](ansatz-metatag.html) abbilden:

| Taskforce-Vokabular | DQ-Framework-Mapping | Beispiel |
|---------------------|---------------------|---------|
| Datenqualitätsannotation | DQI-Indikatoren als Qualitätshinweise | `DQI-3008` = "Logischer Widerspruch erkannt" |
| Datenqualitätsprüfung | Ergebnis einer regelbasierten Prüfung | `dq-rule-successful#OP-1` = "OP nach Aufnahme: bestanden" |
| Datenqualitätsstufe | Aggregierte Bewertung auf Basis der DQI | z.B. "hoch" wenn keine DQI-3xxx Indikatoren gesetzt |
| Validierung | FHIR-Validierungsergebnis | `validation-outcome#success` = "FHIR-Profil validiert" |

### Offene Fragen

- Sollen die DQI-Codes direkt als Meta.tag verwendet werden, oder soll ein MII-eigenes Mapping-CodeSystem erstellt werden?
- Wie wird zwischen "DQ-Problem erkannt" und "DQ-Prüfung bestanden" unterschieden -- separate CodeSystems (`dq-rule-successful` vs. `dq-rule-failed`)?
- Soll das DQ-Framework über den MII-Terminologieserver bereitgestellt werden?
- Wie werden DQ-Tags bei Ressourcen-Updates behandelt -- bleiben alte DQ-Ergebnisse erhalten oder werden sie bei erneutem Prüflauf überschrieben?

*Quelle: [Greifswald OBC DQ-Framework](https://dataquality.qihs.uni-greifswald.de/), MII Taskforce Metadaten (Matthias Löbe et al.)*
