Instance: mii-exa-provenance-deduplizierung
InstanceOf: MII_PR_Provenance_Prozedur_Herkunft
Usage: #example
Title: "Provenance: Deduplizierung"
Description: "Beispiel: Die OP-Prozedur wurde durch Zusammenführung der Abrechnungsprozedur (op-1 v1) und der oBDS-Importprozedur (op-2 v1) dedupliziert. Das Ergebnis ist op-1 v2."
* insert MetaProfile(https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft)
* target = Reference(Procedure/op-1)
* recorded = "2025-06-15T10:00:00+02:00"
* activity = $mii-cs-provenance-prozedur-herkunft#deduplizierung "Deduplizierung/Zusammenführung"
* agent.type = $provenance-participant-type#assembler "Assembler"
* agent.who = Reference(Device/dedup-service)
* agent.who.display = "Deduplizierungsdienst (DIZ)"
* entity[0].role = #source
* entity[0].what = Reference(Procedure/op-1)
* entity[0].what.display = "Abrechnungsprozedur (Original, v1)"
* entity[1].role = #source
* entity[1].what = Reference(Procedure/op-2)
* entity[1].what.display = "oBDS-Importprozedur (zusammengeführt, v1)"
