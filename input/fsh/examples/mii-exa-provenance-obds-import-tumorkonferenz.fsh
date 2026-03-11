Instance: mii-exa-provenance-obds-import-tumorkonferenz
InstanceOf: MII_PR_Provenance_Prozedur_Herkunft
Usage: #example
Title: "Provenance: Erstanlage Tumorkonferenz aus oBDS-Import"
Description: "Beispiel: Der Tumorkonferenz-CarePlan wurde aus dem oBDS-Melderegister via obds-to-fhir ETL in das DIZ-Repository importiert."
* insert MetaProfile(https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/StructureDefinition/mii-pr-provenance-prozedur-herkunft)
* target = Reference(CarePlan/tumorkonferenz-brustkrebs)
* recorded = "2025-06-12T14:31:00+02:00"
* activity = $mii-cs-provenance-prozedur-herkunft#obds-import "Import aus oBDS-Melderegister"
* agent.type = $provenance-participant-type#assembler "Assembler"
* agent.who.identifier.system = "https://bzkf.github.io/obds-to-fhir/identifiers/obds-to-fhir-device-id"
* agent.who.identifier.value = "obds-to-fhir-2.1.0"
* agent.who.display = "obds-to-fhir ETL"
* entity.role = #source
* entity.what.identifier.system = "https://bzkf.github.io/obds-to-fhir/identifiers/obds-meldung-id"
* entity.what.identifier.value = "2025-M-00891"
* entity.what.display = "oBDS-Meldung Tumorkonferenz-Beschluss"
