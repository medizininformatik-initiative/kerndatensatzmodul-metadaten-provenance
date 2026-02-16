### Überblick

Das Provenancekonzept der MII Taskforce Metadaten (Löbe et al., Juli 2025) beschreibt Lösungsvorschläge für Anwendungsfälle, die sich nicht durch dedizierte Elemente der FHIR-Ressourcen abbilden lassen (siehe [Ebene 1 der Technischen Grundlagen](technische-grundlagen.html)). Provenance-Implementierungen in der MII sollen nie dazu führen, dass Informationen nicht in den spezifisch dafür vorgesehenen Ressourcen, Elementen oder Attributen hinterlegt werden.

Im Vordergrund steht ein leichtgewichtiger Entwurf als einfach nutzbares Modell, der zeitnah und mit geringen Ressourcen in den DIZ umgesetzt und später erweitert werden kann. Er fokussiert auf HL7 FHIR als Austauschformat des MII-Kerndatensatzes (MII-KDS), berücksichtigt aber bei der Spezifikation die prinzipielle Anwendbarkeit von Datenmodell und Wertelisten in anderen Formaten zwecks internationaler Interoperabilität.

### Vokabulare zur inhaltlichen Beschreibung

Zentrales Ziel des Konzepts ist es, aus der Community geäußerte Bedarfe an Provenance-Informationen gleichförmig in der MII abzubilden. Dazu werden disjunkte Vokabulare erarbeitet und zentral gepflegt. Es werden nur solche Vokabulare angelegt, für die mindestens ein Datenhalter Bedarf sieht und eine Implementierung plant. Der Anwendungsfall jedes Vokabulars wird klar beschrieben. Die Entwicklung erfolgt in einem webbasierten, kollaborativen Werkzeug mit minimalem Audit Trail (WebProtege). Die technische Bereitstellung soll längerfristig über die MII-Infrastrukturen (Terminologieserver) erfolgen.

Aktuell sind folgende Vokabulare im Entwurf:

#### Gruppe Datencharakteristik

| Vokabular | Beschreibung |
|-----------|-------------|
| Datenklasse | Schutzklasse der Daten |
| Datenentstehung | Berechnete oder extrahierte Datumswerte |
| Datenerhebungskontext | Forschung, Versorgung, Abrechnung |
| Datenkategorie | Grob nach Einteilung der KDS-Module |

#### Gruppe Datenquelle

| Vokabular | Beschreibung |
|-----------|-------------|
| Datenlieferant | Erbringer der Daten (z.B. Organisationseinheit) |
| Datenbereitstellungsweg | Technische Bereitstellung |
| Datenquellformat | Format der Quelldaten |
| Datenquellmodell | Informationsmodellschema (z.B. OMOP) |

#### Gruppe Datenqualität und Kuration

| Vokabular | Beschreibung |
|-----------|-------------|
| Datenqualitätsannotation | Qualitätshinweise |
| Datenqualitätsprüfung | Erfolgreich/fehlgeschlagen |
| Datenqualitätsstufe | Qualitätsniveau |
| Validierung | Validierungsergebnis |

#### Gruppe Datenquellsystem

| Vokabular | Beschreibung |
|-----------|-------------|
| Datenquellsystemart | Primärsystem oder Sekundärsystem |
| Datenquellsystemhersteller | Akteur |
| Datenquellsystemname | Umgangsname (z.B. REDCap) |
| Datenquellsystemtyp | LIMS, PDMS, etc. |
| Datenquellsystemversion | Versionsinformation |

#### Gruppe Datentransformationssystem

| Vokabular | Beschreibung |
|-----------|-------------|
| Datentransformationssystemhersteller | Hersteller |
| Datentransformationssystemname | Name |
| Datentransformationssystemtyp | Typ |
| Datentransformationssystemversion | Version |

#### Gruppe Organisation

| Vokabular | Beschreibung |
|-----------|-------------|
| Organisation | Platzhalter bis Erweiterungsmodul Strukturdaten |
| Organisationseinheit | |
| Projekt | |

### Technische Implementierung in Meta.tag

Das Element `meta` ist Teil der abstrakten Ressource `Resource` und Bestandteil aller FHIR-Ressourcen. Somit steht es in allen FHIR-Ressourcen und Profilen gleichförmig zur Verfügung. Der Datentyp `Meta` enthält 6 Attribute, von denen 3 für Provenance prinzipiell in Frage kommen:

| Attribut | Kardinalität | Typ | Bewertung |
|----------|-------------|-----|-----------|
| `source` | 0..1 | uri | URI des Quellsystems. In der FHIR-Spezifikation explizit als Provenance bezeichnet. Für dieses Konzept jedoch **nicht vorgesehen**, da es nur einmal vorkommen kann und URIs lokal manuell verwaltet werden müssen. |
| `security` | 0..* | Coding | Sicherheits-/Vertraulichkeitsauszeichnung. Liegt im Bereich dieses Konzepts (Datenklasse), die genaue Abgrenzung (z.B. zwischen "normal" und "restricted") muss noch in den MII-Gremien abgestimmt werden. |
| `tag` | 0..* | Coding | Tags (Schlagwörter) aus einem kontrollierten Vokabular. Werden laut Spezifikation verwendet, um Ressourcen mit Prozessen und Arbeitsabläufen zu verknüpfen. **Bevorzugter Mechanismus dieses Konzepts.** |

Das Konzept basiert im Wesentlichen auf der Nutzung von `Meta.tag`. Einer Ressource (und über die Nutzung von `Bundle` auch Gruppen von Ressourcen) können beliebig viele Schlagwörter aus beliebig vielen Vokabularen (CodeSystems) zugeordnet werden. Dies erlaubt die notwendige Freiheit, beliebige Aussagen über Ressourcen treffen zu können, die aber auf zentral abgestimmte Vokabulare referenzieren. Tags interferieren nicht mit der normativen Semantik der FHIR-Ressourcen.

### Beispiel

Das folgende Minimalbeispiel in FSH zeigt die Umsetzung an einem Patienten "John Anyperson", für den mit dem Tag "success" aus dem abgestimmten Vokabular "Validation Outcome Code System" ausgesagt wird, dass eine Validierung erfolgreich war. Die eigentliche Aussage erfordert nur **1 Zeile Code**.

```fsh
CodeSystem:  ValidationOutcomeCS
Id:          mii-cs-validation-outcomes-add
Title:       "Validation Outcome Code System"
Description: "For demonstration, additional codes needed."
* ^url = "http://www.medizininformatik-initiative.de/fhir/ValueSet/mii-cs-validation-outcomes"
* #success "Success"
* #not-done "Not done"

Instance: PatientExample
InstanceOf: Patient
Description: "Example of Patient"
* name.family = "Anyperson"
* name.given[0] = "John"
* gender = #male
* birthDate = "1951-01-20"
* meta.tag[0] = ValidationOutcomeCS#success "Validierung erfolgreich"
```

### Vorteile

- Einfache Implementierbarkeit
- Bestehende ETL-Strecken können sukzessive geändert werden und erzeugen bis dahin keine "invaliden" MII-FHIR-Strukturen
- Existierende Daten können mit minimalem Aufwand ergänzt werden
- Geringer Aufwand verglichen mit zusätzlichen Ressourcen wie FHIR Provenance oder Extensions
- Bestehende Implementierungsleitfäden der MII-Module bleiben gültig
- Keine Performanzprobleme durch steigende Ressourcenzahl, keine Ausleitungsprobleme durch abhängige Ressourcen
- Umsetzung kann priorisiert in überschaubaren Schritten erfolgen

### Limitierungen

- Keine Nutzung des Ressourcentyps FHIR Provenance, der inhaltlich für solche Anwendungen vorgesehen ist -- damit limitierte Nützlichkeit im internationalen Kontext. Es steht den Datenhaltern aber frei, solche Ressourcen zusätzlich zu erzeugen.
- Limitierte Mächtigkeit: keine komplexen Aussagen mit mehreren Entitäten
- Keine ValueSets aus mehreren CodeSystems zusammensetzbar
- Keine normativen Pflichtfelder in v1.0

### Bezug zum MII-Kerndatensatz

Der Kerndatensatz der MII ist modular aufgebaut mit Basismodulen (verpflichtend) und Erweiterungsmodulen (konditional). Das vorliegende Konzept in Version 1.0 enthält keine besonderen Verpflichtungen für einzelne Module oder Modularten und erzeugt auch keine Abhängigkeiten der Informationsmodelle. Das bedeutet im Besonderen, dass es **keine Pflichtfelder** gibt. Obwohl das Fehlen von Pflichtfeldern häufig dazu führt, dass die Informationen nicht ausgezeichnet werden, sah die Taskforce die größere Gefahr in einer zeitlich langwierigen Konsentierung der Pflichtfelder.

### Ausblick

Das Konzept ist bislang nur prototypisch getestet und bedarf der Rückmeldung aus den implementierenden Datenintegrationszentren, um die Passförmigkeit für aktuelle Bedarfe und nötige Weiterentwicklungen abschätzen zu können. Die Taskforce Metadaten plant, eine verbesserte **Version 2.0 in 12 Monaten** abzustimmen und bereitzustellen. In dieser Version können dann auch Pflichtauszeichnungen (konditional für bestimmte Anwendungsfälle) enthalten sein. Spätere Versionen des Konzepts werden den Weg über die FHIR Provenance Ressource ausführen.

*Quelle: MII Taskforce Metadaten, Konzeptpapier v1.0, 13.07.2025 (Matthias Löbe et al.)*
