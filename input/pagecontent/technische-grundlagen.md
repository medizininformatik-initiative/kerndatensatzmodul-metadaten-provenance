### Relevante Standards

#### Dublin Core (DC)

Dublin Core (ISO 15836) ist eine Sammlung von Metadatenmerkmalen, die 1995 als einer der ersten nicht-technischen Standards für Web-Ressourcen abgestimmt wurde. Die Aktualisierung DCMI Metadata Terms (DCTERMS, ISO 15836-2) von 2012 definiert u.a. das Merkmal "Provenance" und legt für einzelne Elemente Schemas und Datentypen fest. Aufgrund seiner Einfachheit und breiten Anwendbarkeit wird Dublin Core durchgängig genutzt.

#### W3C PROV

W3C PROV ist ein domänenunabhängiges Top-Level-Modell zur Beschreibung von Provenance-Information, basierend auf drei Konzepten:

- **Entität** -- Dinge, die beschrieben werden sollen
- **Aktivität** -- Handlung, die Entitäten erzeugt, benutzt oder verändert
- **Agent** -- Person, Organisation oder Software mit Verantwortung für Entitäten/Aktivitäten

W3C PROV wurde 2013 standardisiert und ist der Goldstandard im Bereich der wissenschaftlichen Provenance.

### Provenance in FHIR

Provenance ist in FHIR nicht zentral, sondern auf verschiedenen Ebenen realisierbar:

#### Ebene 1: Ressourcen-Attribute (5Ws-Pattern)

Alle FHIR-Ressourcen beantworten (falls anwendbar) die "5W"-Fragen: Who, What, When, Where, Why. Observations haben z.B. Attribute für Status, Kategorie und Publikationszeit. **Dies deckt die meisten klinisch relevanten Provenance-Informationen ab.**

#### Ebene 2: AuditEvent

Die Ressource `AuditEvent` deckt sicherheitsrelevante Aktionen ab (Login-Versuche, Datenzugriffe). Sie überschneidet sich inhaltlich teilweise mit Provenance.

#### Ebene 3: FHIR Provenance Ressource

Die Ressource `Provenance` erlaubt generische Provenance-Aussagen basierend auf W3C PROV. Sie wird von manchen Ressourcen explizit adressiert (z.B. `MedicationAdministration.eventHistory`), erfährt aber bislang **keine breite praktische Verwendung**.

#### Ebene 4: Meta-Element

Der Datentyp `Meta` ist Teil aller FHIR-Ressourcen und enthält drei für Provenance relevante Attribute:

| Attribut | Kardinalität | Typ | Beschreibung |
|----------|-------------|-----|--------------|
| `source` | 0..1 | uri | URI des Quellsystems; kann nur einmal vorkommen |
| `security` | 0..* | Coding | Sicherheits-/Vertraulichkeitsauszeichnung |
| `tag` | 0..* | Coding | Schlagwörter aus kontrollierten Vokabularen |

#### Ebene 5: Extensions

Eigene Erweiterungen für lokale Konventionen. Am wenigsten interoperabel, da nicht breit verwertbar.

### Zusammenfassung

> FHIR Provenance ist nicht gleich W3C PROV. FHIR bildet die meisten Merkmale in eigenen Attributen ab. Nur für den nicht anderweitig spezifizierbaren Rest steht die FHIR Provenance Ressource zur Verfügung -- die Erwartung der FHIR-Community ist, dass diese Ressource selten genutzt wird.

*Quelle: MII Taskforce Metadaten, Konzeptpapier v1.0, Juli 2025 (Matthias Löbe et al.)*
