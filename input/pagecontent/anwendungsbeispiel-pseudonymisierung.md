### Anwendungsbeispiel Pseudonymisierung eines Patienten

Diese Seite diskutitiert mögliche Umsetzungsvarianten für das Szenario "Pseudonymisierung eines Patienten".

```fsh
Alias: $v3-ActCode = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $v3-ActReason = http://terminology.hl7.org/CodeSystem/v3-ActReason
Alias: $v3-DataOperation = http://terminology.hl7.org/CodeSystem/v3-DataOperation
Alias: $v3-ObservationValue = http://terminology.hl7.org/CodeSystem/v3-ObservationValue
Alias: $contractsignertypecodes = http://terminology.hl7.org/CodeSystem/contractsignertypecodes
Alias: $provenance-participant-type = http://terminology.hl7.org/CodeSystem/provenance-participant-type

Instance: prov-ex-pseudonymisierung-001
InstanceOf: Provenance
Usage: #example
```

#### Punkt 1: Brauchen wir eine Profilierung von Provenance?
```
* meta.profile = "http://example.org/fhir/StructureDefinition/Provenance-Pseudonymisierung"
```
Meiner Meinung nach noch nicht zu beantworten. Es könnte sinnvoll sein, falls wir MS oder Extensions haben werden. Es könnte auch sein, dass wir mehrere Profile haben oder keine.

#### Punkt 2: Sollten FHIR Meta.tag und FHIR Provenance zusammen verwendet werden?
```
* meta.tag = $v3-ObservationValue#PSEUD "pseudonymized"
```
Hier könnte man ausdrücken, dass eine Pseudonymisierung durchgeführt wurde. Es ist natürlich diskutabel, inwieweit das bei einer Provenanceressource sinnvoll ist.

#### Punkt 3: Zielobjekt, Ziel ist der pseudoynmisierte Patient allein?
```
* target = Reference(Patient/patient-pseudonymisiert-001) "Pseudonymisierter Patient"
* target.type = "Patient"
```
Der pseudoynmisierte Patient ist das natürliche Ziel der Ressource. Der originale Patient eher nicht? Oder eine andere Ressource?

#### Punkt 4: Zeitpunkt der Pseudonymisierung und der Erfassung
```
* occurredDateTime = "2026-03-02T10:15:00+01:00"
* recorded = "2026-03-02T10:15:05+01:00"
```
Aus meiner Sicht relativ klar.

#### Punkt 5: Leitlinie zur Pseudonymisierung
```
* policy = "urn:uuid:mii-pseudonymisierungsleitlinie"
```
Dann bräuchte man eine kanonische URL zur MII-Leitlinie.

#### Punkt 6: Ort der Pseudonymisierung
```
* location = Reference(Location/Hauptgebaeude)
```
Erscheint für eine Software-initiierte Aktivität irrelevant, würde ich nicht befüllen.

#### Punkt 7: Hintergrund
Reasons sind bevorzugt nach [V3 ValueSet SetPurposeOfUse](https://hl7.org/fhir/R4/v3/PurposeOfUse/vs.html) (Extensible) zu kodieren, was eine Teilmenge von [V3 CodeSystem ActReason](https://hl7.org/fhir/R4/v3/ActReason/cs.html) ist.
```
* reason = $v3-ActReason#HRESCH "health research"
* reason.text = "Pseudonymisierung zur Nutzung für Forschungszwecke"
Oder
* reason = $v3-ActReason#METADATA "metadata management"
```
Oder gibt es noch etwas Besseres (#DEID, #PSEUDO)? Oder mehrere Gründe auszeichnen?

#### Punkt 8: Typ der Aktivität
Der Typ der Aktivität ist bevorzugt nach [Provenance activity type](https://hl7.org/fhir/R4/valueset-provenance-activity-type.html) (Extensible) zu kodieren.
```
* activity = $v3-ActCode#PSEUD "Pseudonymization"
Oder
* activity = $v3-DataOperation#UPDATE "Update"

```
Es kann nur ein Code gewählt werden. Hält die Gematik Terminologiekonzepte?

#### Punkt 9: Typ des Agenten
```
* 
```

#### Punkt 10: Rolle des Agenten
```
* 
```

#### Punkt 11: Agent
```
* 
```

#### Punkt 12: Im Namen von
```
* 
```
Kann auch ein Device sein.

#### Punkt 13: Rolle des Hilfsobjekts
```
* 
```
#### Punkt 14: Hilfsobjekt
```
* 
```
#### Punkt 15: Verantwortlicher Agent für das Hilfsobjekt
```
* 
```
#### Punkt 16: Digitale Signatur
Der Unterzeichner sollte mit einem Provenance.agent übereinstimmen. Der Zweck der Signatur wird angegeben.
```
* signature.type = urn:iso-astm:E1762-95:2013#1.2.840.10065.1.12.1.5 "Verification Signature"
* signature.when = "2026-03-02T10:15:05+01:00"
* signature.who.identifier.system = "urn:ietf:rfc:3986"
* signature.who.identifier.value = "urn:uuid:software-pseudonymizer-12345"
* signature.who.display = "PseudoGen Engine v2.4.1"
* signature.targetFormat = #application/fhir+json
* signature.sigFormat = #application/signature+xml
* signature.data = "VGhpcyBpcyBhIGR1bW15IHNpZ25hdHVyZQ=="
```
