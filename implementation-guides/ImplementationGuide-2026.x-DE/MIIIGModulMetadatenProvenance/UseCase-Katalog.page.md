---
parent:
---

## {{page-title}}

Dieser Katalog beschreibt wiederkehrende Provenance-Szenarien in der MII. Jeder Use Case definiert, welche Felder der FHIR Provenance Ressource wie belegt werden.

### Übersicht

| # | Use Case | Activity | Agent | Entity |
|---|----------|----------|-------|--------|
| 1 | ETL-Import | CREATE | ETL-Tool (Device) | Quell-ID |
| 2 | Merge/Deduplizierung | UPDATE | Dedup-Service | Quellressourcen A, B |
| 3 | Pseudonymisierung | PSEUDONYMIZE | Pseudonymisierungsdienst | Original-Ressource |
| 4 | Qualitätsprüfung | VERIFY | Validator | -- |
| 5 | Spezifikations-Migration | UPDATE | Migrationsskript | Vorversion |

---

### Use Case 1: ETL-Import

Daten aus einem Quellsystem (KIS, oBDS-Meldung, Laborsystem) werden durch eine ETL-Strecke in FHIR-Ressourcen umgewandelt und in das DIZ-Repository geladen.

> "Diese Ressource wurde am [Zeitpunkt] durch [ETL-Tool] aus [Quellmeldung] erzeugt."

- `activity` = `v3-DataOperation#CREATE`
- `agent.who` = ETL-Tool als Device (z.B. obds-to-fhir v3.2.0)
- `entity.role` = `source`, `entity.what` = Identifier der Quellmeldung

**Referenzimplementierung:** [bzkf/obds-to-fhir](https://github.com/bzkf/obds-to-fhir) (Christian Gulden, BZKF)

---

### Use Case 2: Merge / Deduplizierung

Zwei FHIR-Ressourcen beschreiben dasselbe klinische Ereignis (z.B. Operation aus Abrechnungsdaten und oBDS-Import). Sie werden erkannt und zu einer angereicherten Ressource zusammengeführt.

> "Diese Ressource wurde am [Zeitpunkt] durch [Dedup-Service] aus [Ressource A] und [Ressource B] zusammengeführt."

- `activity` = `v3-DataOperation#UPDATE`
- `agent.who` = Dedup-Service (Device) oder DIZ (Organization)
- `entity[0]` = Quellressource A (`role` = `source`)
- `entity[1]` = Quellressource B (`role` = `source`)

Siehe auch: {{pagelink:Anwendungsbeispiel-Deduplizierung}}

---

### Use Case 3: Pseudonymisierung

Im Rahmen einer Datenausleitung (z.B. FDPG) werden personenbezogene Daten pseudonymisiert. Die pseudonymisierte Ressource unterscheidet sich von der Originalressource.

> "Diese Ressource wurde am [Zeitpunkt] durch [Pseudonymisierungsdienst] pseudonymisiert."

- `activity` = MII-Code `PSEUDONYMIZE` (zu definieren)
- `agent.who` = Pseudonymisierungsdienst (Device, z.B. gPAS)
- `entity.role` = `source`, `entity.what` = Identifier der Original-Ressource (nicht auflösbar)

**Hinweis:** Der Verweis auf die Original-Ressource sollte als nicht-auflösbarer Identifier gestaltet werden, um den Datenschutz zu wahren.

---

### Use Case 4: Qualitätsprüfung

Ein Validierungsdienst prüft FHIR-Ressourcen gegen Profilkonformität oder Plausibilitätsregeln. Die Provenance dokumentiert, **dass** eine Prüfung stattgefunden hat -- Details gehören in ein `OperationOutcome`.

> "Diese Ressource wurde am [Zeitpunkt] durch [Validator] geprüft."

- `activity` = `v3-DataOperation#VERIFY`
- `agent.who` = Validator (Device)

---

### Use Case 5: Spezifikations-Migration

Aufgrund einer Änderung der zugrunde liegenden Terminologien oder Spezifikationen werden bestehende Ressourcen migriert. Beispiele:

- Ein verwendeter SNOMED-Code wird in einer neuen Release inaktiviert und muss auf einen Nachfolge-Code umgeschlüsselt werden
- Eine CodeSystem-URL ändert sich
- Ein ValueSet wird überarbeitet und alte Codes werden durch neue ersetzt

> "Diese Ressource wurde am [Zeitpunkt] durch [Migrationsskript] aufgrund einer Spezifikationsänderung aktualisiert."

- `activity` = `v3-DataOperation#UPDATE`
- `agent.who` = Migrationsskript (Device)
- `entity.role` = `revision`, `entity.what` = Vorversion der Ressource

---

### Offene Fragen

- Reicht `v3-DataOperation` für alle Use Cases oder braucht die MII zusätzliche Activity-Codes?
- Soll ein einzelnes MII-Provenance-Profil alle Use Cases abdecken oder je Use Case ein eigenes Profil?
- Wie wird mit Verkettung umgegangen (Import → Merge → Pseudonymisierung)?
