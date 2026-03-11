CodeSystem: MII_CS_Provenance_Prozedur_Herkunft
Id: mii-cs-provenance-prozedur-herkunft
Title: "MII CS Provenance Prozedur Herkunft"
Description: "CodeSystem für die Herkunft onkologischer Prozeduren zur Unterscheidung von Datenquellen und Deduplizierungsstatus."
* ^meta.profile = "http://hl7.org/fhir/StructureDefinition/shareablecodesystem"
* ^url = "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-provenance-prozedur-herkunft"
* ^status = #draft
* ^experimental = true
* insert Publisher
* insert PR_CS_VS_Version
* ^caseSensitive = true
* ^valueSet = "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/ValueSet/mii-vs-provenance-prozedur-herkunft"
* ^content = #complete
* #obds-import "Import aus oBDS-Melderegister" "Die Prozedur wurde aus dem onkologischen Basisdatensatz (oBDS) via Krebsregistermeldung reimportiert."
* #abrechnung "Abrechnungsprozedur" "Die Prozedur stammt aus dem Abrechnungssystem (KIS/Routinedaten) des Krankenhauses."
* #deduplizierung "Deduplizierung/Zusammenführung" "Die Prozedur ist das Ergebnis einer Deduplizierung/Zusammenführung von Daten aus unterschiedlichen Quellen."
