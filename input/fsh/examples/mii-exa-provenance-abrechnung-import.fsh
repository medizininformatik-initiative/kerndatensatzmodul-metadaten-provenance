Instance: mii-exa-provenance-abrechnung-import
InstanceOf: MII_PR_Provenance_Prozedur_Herkunft
Usage: #example
Title: "Provenance: Erstanlage aus Abrechnung"
Description: "Beispiel: Die OP-Prozedur wurde aus den Abrechnungsdaten (KIS) in das DIZ-Repository importiert."
* insert MetaProfile(https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft)
* target = Reference(Procedure/op-1)
* recorded = "2025-03-13T08:15:00+01:00"
* activity = $mii-cs-provenance-prozedur-herkunft#abrechnung "Abrechnungsprozedur"
* agent.type = $provenance-participant-type#assembler "Assembler"
* agent.who.display = "KIS-ETL-Strecke (DIZ)"
* entity.role = #source
* entity.what.identifier.system = "https://example.org/fhir/identifiers/fall-nummer"
* entity.what.identifier.value = "2025-KH-00472"
* entity.what.display = "Abrechnungsfall"
