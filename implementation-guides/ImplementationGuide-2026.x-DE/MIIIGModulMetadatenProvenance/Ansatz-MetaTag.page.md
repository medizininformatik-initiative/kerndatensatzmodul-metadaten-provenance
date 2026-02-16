---
parent:
---

## {{page-title}}

### Konzept

Die MII Taskforce Metadaten (Löbe et al., Juli 2025) schlägt einen leichtgewichtigen Ansatz auf Basis von `Resource.meta.tag` vor. Einer Ressource können beliebig viele Schlagwörter aus zentral abgestimmten Vokabularen (CodeSystems) zugeordnet werden.

### Vokabulare

Folgende Vokabulargruppen sind im Entwurf:

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

### Beispiel

```
CodeSystem:  ValidationOutcomeCS
Id:          mii-cs-validation-outcomes-add
Title:       "Validation Outcome Code System"
Description: "Additional codes for validation outcomes."
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

Die eigentliche Provenance-Aussage erfordert nur **1 Zeile Code** (`meta.tag`).

### Vorteile

- Einfache Implementierbarkeit
- Bestehende ETL-Strecken können sukzessive geändert werden, ohne "invalide" Strukturen zu erzeugen
- Existierende Daten können mit minimalem Aufwand ergänzt werden
- Geringer Aufwand verglichen mit FHIR Provenance oder Extensions
- Bestehende Implementierungsleitfäden bleiben gültig
- Keine Performanzprobleme durch steigende Ressourcenzahl

### Limitierungen

- Keine Nutzung der FHIR Provenance Ressource (limitierte internationale Interoperabilität)
- Limitierte Mächtigkeit: keine komplexen Aussagen mit mehreren Entitäten
- Keine ValueSets aus mehreren CodeSystems zusammensetzbar
- Keine normativen Pflichtfelder in v1.0

### Bezug zum MII-Kerndatensatz

Das Konzept v1.0 enthält keine besonderen Verpflichtungen für einzelne Module. Es gibt keine Pflichtfelder. Die Taskforce plant eine verbesserte Version 2.0 in 12 Monaten, die auch Pflichtauszeichnungen (konditional für bestimmte Anwendungsfälle) enthalten kann.

*Quelle: MII Taskforce Metadaten, Konzeptpapier v1.0, 13.07.2025 (Matthias Löbe et al.)*
