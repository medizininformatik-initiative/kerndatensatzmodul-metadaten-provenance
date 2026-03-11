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

---

### Ressourcen-History: Konkrete FHIR-Beispiele

Die folgenden Beispiele zeigen den **Lebenszyklus der Procedure-Ressourcen** über ihre Versionshistorie (`meta.versionId`, `meta.lastUpdated`). Für jeden Schritt wird die Umsetzung mit beiden Ansätzen -- Meta.tag und FHIR Provenance -- dargestellt.

#### Zeitstrahl

| Zeitpunkt | Ereignis | Ressourcen |
|-----------|----------|------------|
| 13.03.2025 | Procedure A angelegt (Abrechnung) | `Procedure/op-1` v1 |
| 12.06.2025 | Procedure B angelegt (oBDS-Import) | `Procedure/op-2` v1 |
| 15.06.2025 | Deduplizierung: A wird mit B-Daten angereichert, B wird gelöscht | `Procedure/op-1` v2 |

---

#### Schritt 1: Procedure A -- Erstanlage aus Abrechnung (v1)

`GET [base]/Procedure/op-1/_history/1`

```json
{
  "resourceType": "Procedure",
  "id": "op-1",
  "meta": {
    "versionId": "1",
    "lastUpdated": "2025-03-13T08:15:00+01:00"
  },
  "status": "completed",
  "category": {
    "coding": [
      {
        "system": "http://snomed.info/sct",
        "code": "387713003",
        "display": "Surgical procedure (procedure)"
      }
    ]
  },
  "code": {
    "coding": [
      {
        "system": "http://fhir.de/CodeSystem/bfarm/ops",
        "version": "2025",
        "code": "5-870",
        "display": "Partielle (brusterhaltende) Exzision der Mamma und Destruktion von Mammagewebe"
      }
    ]
  },
  "subject": {
    "reference": "Patient/example-onko"
  },
  "performedDateTime": "2025-03-12"
}
```

**Zu beachten:** Keine onkologiespezifischen Informationen (Intention, Residualstatus, Komplikationen) -- diese liegen im Abrechnungsdatensatz nicht vor.

---

#### Schritt 2: Procedure B -- Erstanlage aus oBDS-Import (v1)

`GET [base]/Procedure/op-2/_history/1`

```json
{
  "resourceType": "Procedure",
  "id": "op-2",
  "meta": {
    "versionId": "1",
    "lastUpdated": "2025-06-12T14:30:00+02:00"
  },
  "status": "completed",
  "category": {
    "coding": [
      {
        "system": "http://snomed.info/sct",
        "code": "387713003",
        "display": "Surgical procedure (procedure)"
      }
    ]
  },
  "code": {
    "coding": [
      {
        "system": "http://fhir.de/CodeSystem/bfarm/ops",
        "version": "2025",
        "code": "5-870",
        "display": "Partielle (brusterhaltende) Exzision der Mamma und Destruktion von Mammagewebe"
      }
    ]
  },
  "subject": {
    "reference": "Patient/example-onko"
  },
  "performedDateTime": "2025-03-12",
  "extension": [
    {
      "url": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/StructureDefinition/mii-ex-onko-operation-intention",
      "valueCodeableConcept": {
        "coding": [
          {
            "system": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/CodeSystem/mii-cs-onko-intention",
            "code": "K",
            "display": "Kurativ"
          }
        ]
      }
    }
  ],
  "outcome": {
    "coding": [
      {
        "system": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/CodeSystem/mii-cs-onko-residualstatus",
        "code": "R0",
        "display": "Kein Residualtumor"
      }
    ]
  },
  "complication": [
    {
      "coding": [
        {
          "system": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/CodeSystem/mii-cs-onko-operation-komplikation",
          "code": "HNK",
          "display": "Harnwegsinfekt / Nephrologische Komplikationen"
        }
      ]
    }
  ]
}
```

**Zu beachten:** Diese Ressource enthält die onkologiespezifischen Informationen aus der Krebsregistermeldung. Gleichzeitig entsteht ein **Duplikat** -- dasselbe operative Ereignis ist jetzt zweimal im Repository.

---

#### Schritt 3: Deduplizierung -- Procedure A wird angereichert (v2)

Nach Erkennung des Duplikats (gleicher Patient, gleiches OP-Datum, gleicher OPS-Code) wird Procedure A mit den reichhaltigeren Daten aus Procedure B angereichert. Die folgenden Abschnitte zeigen, wie die Nachvollziehbarkeit dieses Vorgangs mit den beiden Ansätzen umgesetzt werden kann.

---

### Ansatz 1: Meta.tag

Beim Meta.tag-Ansatz wird die Herkunfts- und Deduplizierungsinformation **direkt an der Procedure-Ressource** in `meta.tag` hinterlegt. Tags werden gemäß FHIR-Spezifikation bei Updates automatisch in die neue Version übernommen (sofern nicht explizit überschrieben).

#### Schritt 1 → Procedure A v1 mit Meta.tag

```json
{
  "resourceType": "Procedure",
  "id": "op-1",
  "meta": {
    "versionId": "1",
    "lastUpdated": "2025-03-13T08:15:00+01:00",
    "tag": [
      {
        "system": "http://www.medizininformatik-initiative.de/fhir/CodeSystem/mii-cs-datenerhebungskontext",
        "code": "abrechnung",
        "display": "Abrechnung/Routinedaten"
      }
    ]
  },
  "status": "completed",
  "code": {
    "coding": [
      {
        "system": "http://fhir.de/CodeSystem/bfarm/ops",
        "version": "2025",
        "code": "5-870",
        "display": "Partielle (brusterhaltende) Exzision der Mamma und Destruktion von Mammagewebe"
      }
    ]
  },
  "subject": { "reference": "Patient/example-onko" },
  "performedDateTime": "2025-03-12"
}
```

#### Schritt 2 → Procedure B v1 mit Meta.tag

```json
{
  "resourceType": "Procedure",
  "id": "op-2",
  "meta": {
    "versionId": "1",
    "lastUpdated": "2025-06-12T14:30:00+02:00",
    "tag": [
      {
        "system": "http://www.medizininformatik-initiative.de/fhir/CodeSystem/mii-cs-datenerhebungskontext",
        "code": "obds-import",
        "display": "Import aus oBDS-Melderegister"
      }
    ]
  },
  "status": "completed",
  "code": {
    "coding": [
      {
        "system": "http://fhir.de/CodeSystem/bfarm/ops",
        "version": "2025",
        "code": "5-870",
        "display": "Partielle (brusterhaltende) Exzision der Mamma und Destruktion von Mammagewebe"
      }
    ]
  },
  "subject": { "reference": "Patient/example-onko" },
  "performedDateTime": "2025-03-12",
  "extension": [
    {
      "url": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/StructureDefinition/mii-ex-onko-operation-intention",
      "valueCodeableConcept": {
        "coding": [{ "system": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/CodeSystem/mii-cs-onko-intention", "code": "K", "display": "Kurativ" }]
      }
    }
  ],
  "outcome": {
    "coding": [{ "system": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/CodeSystem/mii-cs-onko-residualstatus", "code": "R0", "display": "Kein Residualtumor" }]
  },
  "complication": [
    { "coding": [{ "system": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/CodeSystem/mii-cs-onko-operation-komplikation", "code": "HNK", "display": "Harnwegsinfekt / Nephrologische Komplikationen" }] }
  ]
}
```

#### Schritt 3 → Procedure A v2 nach Deduplizierung (Meta.tag)

`GET [base]/Procedure/op-1/_history/2`

```json
{
  "resourceType": "Procedure",
  "id": "op-1",
  "meta": {
    "versionId": "2",
    "lastUpdated": "2025-06-15T10:00:00+02:00",
    "tag": [
      {
        "system": "http://www.medizininformatik-initiative.de/fhir/CodeSystem/mii-cs-datenerhebungskontext",
        "code": "abrechnung",
        "display": "Abrechnung/Routinedaten"
      },
      {
        "system": "http://www.medizininformatik-initiative.de/fhir/CodeSystem/mii-cs-datenerhebungskontext",
        "code": "obds-import",
        "display": "Import aus oBDS-Melderegister"
      },
      {
        "system": "http://www.medizininformatik-initiative.de/fhir/CodeSystem/mii-cs-datentransformation",
        "code": "deduplizierung",
        "display": "Deduplizierung/Zusammenführung"
      }
    ]
  },
  "status": "completed",
  "code": {
    "coding": [
      {
        "system": "http://fhir.de/CodeSystem/bfarm/ops",
        "version": "2025",
        "code": "5-870",
        "display": "Partielle (brusterhaltende) Exzision der Mamma und Destruktion von Mammagewebe"
      }
    ]
  },
  "subject": { "reference": "Patient/example-onko" },
  "performedDateTime": "2025-03-12",
  "extension": [
    {
      "url": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/StructureDefinition/mii-ex-onko-operation-intention",
      "valueCodeableConcept": {
        "coding": [{ "system": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/CodeSystem/mii-cs-onko-intention", "code": "K", "display": "Kurativ" }]
      }
    }
  ],
  "outcome": {
    "coding": [{ "system": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/CodeSystem/mii-cs-onko-residualstatus", "code": "R0", "display": "Kein Residualtumor" }]
  },
  "complication": [
    { "coding": [{ "system": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/CodeSystem/mii-cs-onko-operation-komplikation", "code": "HNK", "display": "Harnwegsinfekt / Nephrologische Komplikationen" }] }
  ]
}
```

**Was passiert ist:**
- Die Tags aus v1 (`abrechnung`) werden automatisch in v2 übernommen (FHIR-Spezifikation)
- Ein neuer Tag `obds-import` zeigt, dass Daten aus dem oBDS-Import eingeflossen sind
- Der Tag `deduplizierung` markiert die Zusammenführung
- Die Ressource wurde mit Intention, Residualstatus und Komplikationen aus Procedure B angereichert
- `Procedure/op-2` kann anschließend gelöscht werden (`DELETE`)

**Limitierung:** Meta.tag dokumentiert *dass* eine Deduplizierung stattgefunden hat, aber nicht *welche* Quellressource zusammengeführt wurde und *wer* die Zusammenführung durchgeführt hat.

#### History-Abfrage (Meta.tag)

```
GET [base]/Procedure/op-1/_history
```

Liefert ein Bundle mit Version 2 (dedupliziert, angereichert) und Version 1 (nur Abrechnungsdaten) -- die vollständige Entwicklung der Ressource ist über die Versionshistorie nachvollziehbar.

---

### Ansatz 2: FHIR Provenance

Beim Provenance-Ansatz werden **separate Provenance-Ressourcen** angelegt, die den Lebenszyklus dokumentieren. Die Procedure-Ressource selbst bleibt frei von Metadaten-Tags. Dieser Ansatz orientiert sich am [Provenance-Profil im Onkologie-Modul](https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/StructureDefinition/mii-pr-onko-provenance-prozedur-herkunft) (`feature/provenance-prozedur-herkunft`).

#### Schritt 1 → Provenance bei Erstanlage (Abrechnung)

Zeitgleich mit der Anlage von `Procedure/op-1` wird eine Provenance-Ressource erstellt:

```json
{
  "resourceType": "Provenance",
  "id": "prov-op-1-abrechnung",
  "target": [
    { "reference": "Procedure/op-1/_history/1" }
  ],
  "recorded": "2025-03-13T08:15:00+01:00",
  "activity": {
    "coding": [
      {
        "system": "http://terminology.hl7.org/CodeSystem/v3-DataOperation",
        "code": "CREATE",
        "display": "create"
      }
    ]
  },
  "agent": [
    {
      "type": {
        "coding": [
          {
            "system": "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
            "code": "assembler",
            "display": "Assembler"
          }
        ]
      },
      "who": {
        "display": "KIS-ETL-Strecke (DIZ)"
      }
    }
  ],
  "entity": [
    {
      "role": "source",
      "what": {
        "identifier": {
          "system": "https://example.org/fhir/identifiers/fall-nummer",
          "value": "2025-KH-00472"
        },
        "display": "Abrechnungsfall"
      }
    }
  ]
}
```

#### Schritt 2 → Provenance bei oBDS-Import

Zeitgleich mit der Anlage von `Procedure/op-2`:

```json
{
  "resourceType": "Provenance",
  "id": "prov-op-2-obds",
  "target": [
    { "reference": "Procedure/op-2/_history/1" }
  ],
  "recorded": "2025-06-12T14:30:00+02:00",
  "activity": {
    "coding": [
      {
        "system": "http://terminology.hl7.org/CodeSystem/v3-DataOperation",
        "code": "CREATE",
        "display": "create"
      }
    ]
  },
  "agent": [
    {
      "type": {
        "coding": [
          {
            "system": "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
            "code": "assembler",
            "display": "Assembler"
          }
        ]
      },
      "who": {
        "identifier": {
          "system": "https://bzkf.github.io/obds-to-fhir/identifiers/obds-to-fhir-device-id",
          "value": "obds-to-fhir-2.1.0"
        },
        "display": "obds-to-fhir ETL"
      }
    }
  ],
  "entity": [
    {
      "role": "source",
      "what": {
        "identifier": {
          "system": "https://bzkf.github.io/obds-to-fhir/identifiers/obds-meldung-id",
          "value": "2025-M-00891"
        },
        "display": "oBDS-Meldung Brustkrebs-OP"
      }
    }
  ]
}
```

#### Schritt 3 → Provenance bei Deduplizierung

Nach der Zusammenführung (`Procedure/op-1` v1 → v2) wird eine dritte Provenance-Ressource angelegt:

```json
{
  "resourceType": "Provenance",
  "id": "prov-op-1-deduplizierung",
  "target": [
    { "reference": "Procedure/op-1/_history/2" }
  ],
  "recorded": "2025-06-15T10:00:00+02:00",
  "activity": {
    "coding": [
      {
        "system": "https://www.medizininformatik-initiative.de/fhir/ext/modul-onko/CodeSystem/mii-cs-onko-prozedur-herkunft",
        "code": "deduplizierung",
        "display": "Deduplizierung/Zusammenführung"
      }
    ]
  },
  "agent": [
    {
      "type": {
        "coding": [
          {
            "system": "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
            "code": "assembler",
            "display": "Assembler"
          }
        ]
      },
      "who": {
        "reference": "Device/dedup-service",
        "display": "Deduplizierungsdienst (DIZ)"
      }
    }
  ],
  "entity": [
    {
      "role": "source",
      "what": {
        "reference": "Procedure/op-1/_history/1",
        "display": "Abrechnungsprozedur (Original)"
      }
    },
    {
      "role": "source",
      "what": {
        "reference": "Procedure/op-2/_history/1",
        "display": "oBDS-Importprozedur (zusammengeführt)"
      }
    }
  ]
}
```

**Was dokumentiert wird:**
- `target` → die neue Version (v2) der deduplizierten Procedure
- `activity` → Deduplizierung als Herkunftsart
- `agent` → das System, das die Zusammenführung durchgeführt hat
- `entity` → **beide** Quellressourcen mit Versionsreferenz, so dass die vollständige Herkunft nachvollziehbar ist

#### History-Abfrage (Provenance)

Die Versionshistorie der Procedure selbst bleibt identisch:

```
GET [base]/Procedure/op-1/_history
```

Zusätzlich können alle Provenance-Ressourcen für eine Procedure abgefragt werden:

```
GET [base]/Provenance?target=Procedure/op-1
```

Dies liefert zwei Provenance-Instanzen: die Erstanlage (`CREATE` aus Abrechnung) und die Deduplizierung -- die vollständige **Transformationskette**.

---

### Vergleich am Beispiel

| Aspekt | Meta.tag | FHIR Provenance |
|--------|----------|-----------------|
| **Herkunft erkennbar?** | Ja (`tag: abrechnung`, `obds-import`) | Ja (`entity.what` mit Quellverweis) |
| **Deduplizierung erkennbar?** | Ja (`tag: deduplizierung`) | Ja (`activity: deduplizierung`) |
| **Quellressourcen referenziert?** | Nein | Ja (`entity[0]`, `entity[1]` mit `_history`-Referenz) |
| **Verantwortliches System?** | Nein | Ja (`agent.who`) |
| **Zusätzliche Ressourcen?** | 0 | 3 Provenance-Instanzen |
| **Abfrage über `_tag`?** | Ja: `GET [base]/Procedure?_tag=deduplizierung` | Nein (indirekt über `Provenance?target=`) |
| **Versionshistorie?** | Tags wandern automatisch mit | Provenance referenziert explizit `_history/N` |

### Offene Fragen

- Sollen beide Ansätze kombiniert werden (Meta.tag für schnelle Filterung, Provenance für vollständige Nachvollziehbarkeit)?
- Sollen die Quellressourcen (`Procedure/op-2`) nach der Deduplizierung erhalten bleiben oder gelöscht werden?
- Wie verhalten sich die `_history`-Referenzen in Provenance bei der Datenausleitung über das FDPG?
- Wer ist verantwortlich für die Deduplizierung -- das DIZ, die ETL-Strecke, oder ein nachgelagerter Prozess?
- Soll eine MII-weite Empfehlung zum Deduplizierungs-Zeitfenster (z.B. +/- 7 Tage um das OP-Datum) ausgesprochen werden?
