// =============================================================================
// Anwendungsbeispiel: Abrechnungsdatenkontext (§21 KHEntgG, §301 SGB V, DRG-Aufbereitung)
//
// Ziel: Zeigen, wie die Provenance einer FHIR-Ressource aussieht, deren Daten
// aus einer DRG-aufbereiteten Routinedatenstrecke stammen — also dem
// gemeinsamen Aufbereitungsstand, aus dem auch §21- und §301-Lieferungen
// gespeist werden.
//
// Klinisches Szenario: Akuter Vorderwand-Myokardinfarkt mit PTCA, Aufenthalt
// 1.-15.3.2026. ETL-Job läuft am 16.3.2026 zeitnah nach Entlassung.
// =============================================================================

Alias: $sct                          = http://snomed.info/sct
Alias: $icd10gm                      = http://fhir.de/CodeSystem/bfarm/icd-10-gm
Alias: $ops                          = http://fhir.de/CodeSystem/bfarm/ops
Alias: $loinc                        = http://loinc.org
Alias: $iknr                         = http://fhir.de/NamingSystem/arge-ik/iknr
Alias: $v3-ActReason                 = http://terminology.hl7.org/CodeSystem/v3-ActReason
Alias: $v3-ActCode                   = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $diagnosis-role               = http://terminology.hl7.org/CodeSystem/diagnosis-role
Alias: $condition-ver-status         = http://terminology.hl7.org/CodeSystem/condition-ver-status
Alias: $condition-clinical           = http://terminology.hl7.org/CodeSystem/condition-clinical


// -----------------------------------------------------------------------------
// 1. Patient
// -----------------------------------------------------------------------------
Instance: pat-mi-001
InstanceOf: Patient
Usage: #example
Title: "Patient (Beispielfall Myokardinfarkt)"
Description: "Pseudonymisierter Beispielpatient für den Anwendungsfall Abrechnungsdatenkontext."
* identifier[0]
  * system = "https://example.org/fhir/sid/patienten-pseudonym"
  * value = "P21-MI-001"
* gender = #male
* birthDate = "1958-04-22"


// -----------------------------------------------------------------------------
// 2. Encounter (Aufenthalt)
// -----------------------------------------------------------------------------
Instance: enc-mi-001
InstanceOf: Encounter
Usage: #example
Title: "Encounter (Aufenthalt 1.-15.3.2026)"
Description: "Stationärer Aufenthalt mit Notfallaufnahme wegen akutem STEMI."
* status = #finished
* class = $v3-ActCode#IMP "inpatient encounter"
* subject = Reference(Patient/pat-mi-001)
* period.start = "2026-03-01T08:42:00+01:00"
* period.end   = "2026-03-15T14:30:00+01:00"
* hospitalization.admitSource = http://terminology.hl7.org/CodeSystem/admit-source#emd "From accident/emergency department"


// -----------------------------------------------------------------------------
// 3. Condition (Hauptdiagnose I21.0)
// -----------------------------------------------------------------------------
Instance: cond-mi-001-hd-i21
InstanceOf: Condition
Usage: #example
Title: "Condition: Hauptdiagnose I21.0"
Description: "Akuter transmuraler Myokardinfarkt der Vorderwand (HD nach §21/§301)."
* clinicalStatus = $condition-clinical#active
* verificationStatus = $condition-ver-status#confirmed
* category = $diagnosis-role#billing "Billing"
* code = $icd10gm#I21.0 "Akuter transmuraler Myokardinfarkt der Vorderwand"
* subject = Reference(Patient/pat-mi-001)
* encounter = Reference(Encounter/enc-mi-001)
* recordedDate = "2026-03-15"


// -----------------------------------------------------------------------------
// 4. Condition (Nebendiagnose I10.90)
// -----------------------------------------------------------------------------
Instance: cond-mi-001-nd-i10
InstanceOf: Condition
Usage: #example
Title: "Condition: Nebendiagnose I10.90"
Description: "Essentielle Hypertonie als Nebendiagnose. Erlöswirksam nach DRG-Logik (PCCL-relevant), wird daher in §21/§301 standardmäßig codiert."
* clinicalStatus = $condition-clinical#active
* verificationStatus = $condition-ver-status#confirmed
* category = $diagnosis-role#billing "Billing"
* code = $icd10gm#I10.90 "Essentielle Hypertonie, nicht näher bezeichnet"
* subject = Reference(Patient/pat-mi-001)
* encounter = Reference(Encounter/enc-mi-001)
* recordedDate = "2026-03-15"


// -----------------------------------------------------------------------------
// 5. Procedure (PTCA mit DES, OPS 8-837.k0)
// -----------------------------------------------------------------------------
Instance: proc-mi-001-ptca
InstanceOf: Procedure
Usage: #example
Title: "Procedure: PTCA mit DES (8-837.k0)"
Description: "Perkutane transluminale Koronarangioplastie mit Implantation eines Drug-Eluting-Stents."
* status = #completed
* code = $ops#8-837.k0 "Perkutan-transluminale Gefäßintervention an Herz und Koronargefäßen: Einlegen eines beschichteten Stents in Koronargefäße: Ein Stent"
* subject = Reference(Patient/pat-mi-001)
* encounter = Reference(Encounter/enc-mi-001)
* performedDateTime = "2026-03-01T11:18:00+01:00"


// -----------------------------------------------------------------------------
// 6. Organization (datenlieferndes Krankenhaus)
// -----------------------------------------------------------------------------
Instance: org-ukb
InstanceOf: Organization
Usage: #example
Title: "Organization: Universitätsklinikum Beispielstadt"
Description: "Datenlieferndes Krankenhaus, identifiziert über IKNR."
* identifier[0]
  * system = $iknr
  * value = "260100000"
* name = "Universitätsklinikum Beispielstadt"
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"


// -----------------------------------------------------------------------------
// 7. Device (ETL-Job als Author der FHIR-Ressourcen)
// -----------------------------------------------------------------------------
Instance: etl-p21-fhir-v142
InstanceOf: Device
Usage: #example
Title: "Device: ETL-Pipeline KIS-DRG → FHIR (v1.4.2)"
Description: "Versionierte ETL-Pipeline, die aus dem KIS-DRG-Aufbereitungsstand FHIR-Ressourcen für das DIZ erzeugt. Diese Pipeline ist der Author der FHIR-Ressourcen — nicht das datenliefernde Krankenhaus selbst und nicht der G-DRG-Grouper."
* status = #active
* deviceName[0]
  * name = "p21-to-fhir ETL-Pipeline"
  * type = #user-friendly-name
* version[0].value = "1.4.2"
* manufacturer = "Universitätsklinikum Beispielstadt – DIZ-IT"
* note.text = "Transformiert den KIS-DRG-Aufbereitungsstand (gleicher Stand, aus dem auch §21-CSV und §301-DTA gespeist werden) in FHIR R4 nach MII-KDM-Profilen."


// -----------------------------------------------------------------------------
// 8. Device — das Quellsystem (Ikarus-KIS, fiktiv, Anlehnung an Dedalus)
//
// Beschreibt das KIS, aus dem die DRG-aufbereiteten Daten stammen.
// Klassifikation per MII_CS_Datenquellsystem (hierarchisch).
// Im Beispiel verwenden wir bewusst nur das Top-Level (#Sekundaersystem) —
// die Children (Abrechnungssystem, KIS, DRG_Grouper, ...) sind im
// CodeSystem vorgehalten und können nach Bedarf eingesetzt werden.
// -----------------------------------------------------------------------------
Instance: src-ikarus-kis-ukb
InstanceOf: Device
Usage: #example
Title: "Device: Ikarus-KIS am UKB (Quellsystem)"
Description: "Krankenhausinformationssystem 'Ikarus-KIS' (fiktiver Hersteller mit Anlehnung an reale KIS-Anbieter) am UKB, hier in der Rolle als Quellsystem für DRG-aufbereitete Routinedaten. Klassifiziert per MII-CodeSystem als Sekundärsystem (zweckgebunden aufbereitet)."
* status = #active
* deviceName[0]
  * name = "Ikarus-KIS — Subsystem Abrechnung"
  * type = #user-friendly-name
* type
  * coding[0] = $mii-cs-datenquellsystem#Sekundaersystem "Sekundärsystem"
* manufacturer = "Ikarus Healthcare GmbH (fiktiv)"
* modelNumber = "Ikarus-KIS 2025.1"
* owner = Reference(Organization/org-ukb)
* note.text = "Fiktiver KIS-Hersteller. Der Name spielt auf die Mythologie an (Ikarus = Sohn des Dedalus) und ist NICHT mit einem realen Produkt assoziiert."


// -----------------------------------------------------------------------------
// 9. DocumentReference (KIS-DRG-Aufbereitungsstand als Quelle)
//
// Wichtig: Wir referenzieren NICHT die §21-CSV-Lieferung an InEK als Quelle,
// weil die zum Zeitpunkt der ETL-Ausführung noch nicht existiert. Quelle
// der FHIR-Daten ist der gemeinsame KIS-DRG-Aufbereitungsstand, aus dem
// parallel sowohl die §21-/§301-Lieferungen als auch das FHIR-Bundle
// abgeleitet werden.
// -----------------------------------------------------------------------------
Instance: kis-drg-aufbereitung-2026-03-15
InstanceOf: DocumentReference
Usage: #example
Title: "DocumentReference: KIS-DRG-Aufbereitungsstand 2026-03-15"
Description: "DRG-aufbereiteter Stand der KIS-Routinedaten zum Aufenthalt enc-mi-001. Gemeinsame Quelle für §21-CSV (an InEK), §301-DTA (an Krankenkasse) und FHIR-Bundle (ins DIZ)."
* status = #current
* type = $loinc#11506-3 "Subsequent evaluation note"
* category = $v3-ActReason#HPAYMT "Payment"
* date = "2026-03-15T23:00:00+01:00"
// author trägt das verantwortliche Krankenhaus UND das Quellsystem.
// Damit lebt die Source-System-Information sauber an dem Artefakt, das das
// System produziert hat — nicht an der Provenance des nachgelagerten ETL-Laufs
// (denn an dem ist das KIS gar nicht beteiligt).
* author[0] = Reference(Organization/org-ukb)
* author[+] = Reference(Device/src-ikarus-kis-ukb)
* identifier[0]
  * system = "https://example.org/fhir/sid/kis-drg-aufbereitung"
  * value = "UKB-260100000-enc-mi-001-2026-03-15"
* description = "Gemeinsamer DRG-Aufbereitungsstand (Codierung + Grouping). Schwester-Outputs: §21-CSV (Lieferung an InEK Q1/2027), §301-DTA (innerhalb von 3 Werktagen an Krankenkasse), FHIR-Bundle (zeitnah ins DIZ)."
* content[0]
  * attachment.title = "KIS-DRG-Aufbereitungsstand UKB enc-mi-001 (2026-03-15)"
  * attachment.contentType = #application/octet-stream


// -----------------------------------------------------------------------------
// 10. Provenance — der Kern dieses Beispiels
//
// Modellierungs-Entscheidungen:
//  - target: alle FHIR-Ressourcen, die der ETL-Lauf erzeugt hat (Patient,
//    Encounter, Conditions, Procedure)
//  - recorded: Zeitpunkt der ETL-Ausführung (zeitnah, einen Tag nach Entlassung)
//  - occurredPeriod: der dokumentierte Aufenthalt
//  - policy: §21-Inhaltsspec, nach der aufbereitet wurde (NICHT „diese Daten
//    gingen an InEK" — das ist eine andere Aussage)
//  - reason: HPAYMT als load-bearing Marker für „Abrechnungskontext"
//  - agent[assembler]: der ETL-Job (Device) — er stellt die FHIR-Ressourcen
//    routinemäßig zusammen (matched MII-Onkologie-Precedent: KIS-ETL als assembler)
//  - agent[performer]: das datenliefernde Krankenhaus
//  - Source-System (Ikarus-KIS) ist NICHT Agent dieser Provenance — es war nicht
//    am ETL-Lauf beteiligt, sondern hat den Quell-Aufbereitungsstand erzeugt.
//    Das Source-System lebt daher an DocumentReference.author (siehe oben).
//  - entity[source]: der KIS-DRG-Aufbereitungsstand (NICHT die §21-CSV)
// -----------------------------------------------------------------------------
Instance: prov-abrechnungskontext-mi-001
InstanceOf: Provenance
Usage: #example
Title: "Provenance: Abrechnungskontext-ETL für Aufenthalt mi-001"
Description: "Dokumentiert, dass die FHIR-Ressourcen aus einer DRG-aufbereiteten Routinedatenstrecke stammen (Abrechnungskontext nach §21/§301-Inhaltsspec), erzeugt zeitnah durch eine versionierte ETL-Pipeline aus dem KIS-DRG-Aufbereitungsstand."

* target[0] = Reference(Patient/pat-mi-001)
* target[+] = Reference(Encounter/enc-mi-001)
* target[+] = Reference(Condition/cond-mi-001-hd-i21)
* target[+] = Reference(Condition/cond-mi-001-nd-i10)
* target[+] = Reference(Procedure/proc-mi-001-ptca)

* recorded = "2026-03-16T03:12:00+01:00"
* occurredPeriod
  * start = "2026-03-01T08:42:00+01:00"
  * end   = "2026-03-15T14:30:00+01:00"

* policy[0] = "https://www.gesetze-im-internet.de/khentgg/__21.html"
* policy[+] = "https://www.gesetze-im-internet.de/sgb_5/__301.html"

* reason = $v3-ActReason#HPAYMT "Payment"
// activity beschreibt die Datenoperation (CREATE/UPDATE/...), NICHT den
// Geschäftsgrund (der steckt in reason). Hier: der ETL-Job legt neue
// FHIR-Ressourcen an.
* activity = $v3-DataOperation#CREATE "create"

// Assembler: der ETL-Job stellt die FHIR-Ressourcen routinemäßig zusammen
// (FHIR-Definition: "device that operates independently of an author on
// custodial routines"). Konsistent mit MII-Onkologie-Precedent.
* agent[0]
  * type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#assembler "Assembler"
  * who = Reference(Device/etl-p21-fhir-v142)
// Performer: das datenliefernde Krankenhaus (Träger-Org)
* agent[+]
  * type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#performer "Performer"
  * who = Reference(Organization/org-ukb)

* entity[0]
  * role = #source
  * what = Reference(DocumentReference/kis-drg-aufbereitung-2026-03-15)


// -----------------------------------------------------------------------------
// 11. Bundle (collection) — packt alles zusammen
// -----------------------------------------------------------------------------
Instance: bundle-abrechnungskontext-mi-001
InstanceOf: Bundle
Usage: #example
Title: "Bundle: Abrechnungskontext (Beispielfall mi-001)"
Description: "Collection-Bundle mit allen Ressourcen des Anwendungsbeispiels Abrechnungsdatenkontext."
* type = #collection
* timestamp = "2026-03-16T03:12:00+01:00"
* identifier
  * system = "https://medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/bundle"
  * value = "abrechnungskontext-mi-001"

* entry[0]
  * fullUrl = "http://example.org/fhir/Patient/pat-mi-001"
  * resource = pat-mi-001
* entry[+]
  * fullUrl = "http://example.org/fhir/Encounter/enc-mi-001"
  * resource = enc-mi-001
* entry[+]
  * fullUrl = "http://example.org/fhir/Condition/cond-mi-001-hd-i21"
  * resource = cond-mi-001-hd-i21
* entry[+]
  * fullUrl = "http://example.org/fhir/Condition/cond-mi-001-nd-i10"
  * resource = cond-mi-001-nd-i10
* entry[+]
  * fullUrl = "http://example.org/fhir/Procedure/proc-mi-001-ptca"
  * resource = proc-mi-001-ptca
* entry[+]
  * fullUrl = "http://example.org/fhir/Organization/org-ukb"
  * resource = org-ukb
* entry[+]
  * fullUrl = "http://example.org/fhir/Device/etl-p21-fhir-v142"
  * resource = etl-p21-fhir-v142
* entry[+]
  * fullUrl = "http://example.org/fhir/Device/src-ikarus-kis-ukb"
  * resource = src-ikarus-kis-ukb
* entry[+]
  * fullUrl = "http://example.org/fhir/DocumentReference/kis-drg-aufbereitung-2026-03-15"
  * resource = kis-drg-aufbereitung-2026-03-15
* entry[+]
  * fullUrl = "http://example.org/fhir/Provenance/prov-abrechnungskontext-mi-001"
  * resource = prov-abrechnungskontext-mi-001
