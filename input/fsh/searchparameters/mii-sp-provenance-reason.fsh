// Custom SearchParameter — schließt eine Lücke im FHIR-R4-Standard:
// Für Provenance gibt es in R4 keinen Standard-Suchparameter auf das
// reason-Feld. Damit Sekundärnutzer:innen Ressourcen nach
// Geschäftsgrund (z. B. HPAYMT für Abrechnungskontext) filtern können,
// definieren wir ihn hier.
//
// Hinweis: SearchParameter werden in FSH als Instance modelliert. Daher
// keine Caret-Rules (^url, ^version, ...) und keine Rulesets, die
// Caret-Rules enthalten — alle Felder als reguläre Properties.

Instance: mii-sp-provenance-reason
InstanceOf: SearchParameter
Usage: #definition
Title: "MII SP Provenance Reason"
Description: "Suchparameter für Provenance.reason. Ermöglicht das Filtern aller Provenance-Ressourcen nach Geschäftsgrund — insbesondere HPAYMT (Abrechnungskontext) für die Identifikation von Daten aus DRG-aufbereiteten Routinedatenstrecken (§21, §301 etc.). In FHIR R4 nicht als Standard-Suchparameter definiert."
* url = "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/SearchParameter/provenance-reason"
* version = "0.2.0-rc.1"
* name = "MII_SP_Provenance_Reason"
* status = #draft
* experimental = true
* publisher = "Medizininformatik Initiative"
* contact[0].telecom[0].system = #url
* contact[0].telecom[0].value = "https://www.medizininformatik-initiative.de"
* code = #reason
* base = #Provenance
* type = #token
* expression = "Provenance.reason"
* xpathUsage = #normal
* multipleOr = true
* multipleAnd = true
