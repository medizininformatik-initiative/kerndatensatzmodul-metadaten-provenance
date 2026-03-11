Profile: MII_PR_Provenance_Prozedur_Herkunft
Parent: Provenance
Id: mii-pr-provenance-prozedur-herkunft
Title: "MII PR Provenance Ressourcen-Herkunft"
Description: "Provenance-Profil zur Dokumentation der Herkunft onkologischer FHIR-Ressourcen (oBDS-Import vs. Abrechnung) und des Deduplizierungsstatus. Anwendbar auf Prozeduren, Diagnosen, Tumorkonferenzen und weitere Ressourcentypen."
* insert PR_CS_VS_Version
* insert Publisher
* ^status = #draft
* ^experimental = true
* ^url = "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft"
* insert Translation(^title, de-DE, MII PR Provenance Ressourcen-Herkunft)
* insert Translation(^description, de-DE, Provenance-Profil zur Dokumentation der Herkunft onkologischer FHIR-Ressourcen und des Deduplizierungsstatus.)

// Target: Die Ressource(n), deren Herkunft dokumentiert wird
* target 1..* MS
* target only Reference(Procedure or Condition or CarePlan or Observation or Resource)
* insert Label(target, Ziel-Ressource, Die FHIR-Ressource deren Herkunft dokumentiert wird)

// Recorded: Zeitpunkt der Herkunftsdokumentation
* recorded 1..1 MS
* insert Label(recorded, Dokumentationszeitpunkt, Zeitpunkt zu dem die Herkunftsinformation erfasst wurde)

// Activity: Art der Herkunft (obds-import, abrechnung, deduplizierung)
* activity 1..1 MS
* activity from MII_VS_Provenance_Prozedur_Herkunft (extensible)
* activity.coding 1..* MS
* activity.coding.system 1..1 MS
* activity.coding.code 1..1 MS
* insert Label(activity, Herkunftsart, Art der Datenherkunft oder Datentransformation: oBDS-Import\, Abrechnung oder Deduplizierung)

// Agent: Wer hat die Zuordnung/Deduplizierung durchgeführt
* agent 1..* MS
* agent.type MS
* agent.type from http://hl7.org/fhir/ValueSet/provenance-agent-type (extensible)
* agent.who 1..1 MS
* agent.who only Reference(Organization or Device or Practitioner or PractitionerRole)
* insert Label(agent, Verantwortlicher Agent, Organisation\, System oder Person\, die die Herkunftszuordnung oder Deduplizierung durchgeführt hat)

// Entity: Bei Deduplizierung - Quellressourcen
* entity 0..* MS
* entity.role MS
* entity.what 1..1 MS
* entity.what only Reference(Procedure or Condition or CarePlan or Observation or Resource)
* insert Label(entity, Quellressource, Bei Deduplizierung: die ursprüngliche Quellressource die zusammengeführt wurde)
