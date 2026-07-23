# Artifacts Summary - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* **Artifacts Summary**

## Artifacts Summary

This page provides a list of the FHIR artifacts defined as part of this implementation guide.

### Behavior: Search Parameters 

These define the properties by which a RESTful server can be searched. They can also be used for sorting and including related resources.

| | |
| :--- | :--- |
| [MII SP Provenance Reason](SearchParameter-mii-sp-provenance-reason.md) | Suchparameter für Provenance.reason. Ermöglicht das Filtern aller Provenance-Ressourcen nach Geschäftsgrund — insbesondere HPAYMT (Abrechnungskontext) für die Identifikation von Daten aus DRG-aufbereiteten Routinedatenstrecken (§21, §301 etc.). In FHIR R4 nicht als Standard-Suchparameter definiert. |

### Structures: Resource Profiles 

These define constraints on FHIR resources for systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [MII PR Provenance Ressourcen-Herkunft](StructureDefinition-mii-pr-provenance-prozedur-herkunft.md) | Provenance-Profil zur Dokumentation der Herkunft onkologischer FHIR-Ressourcen (oBDS-Import vs. Abrechnung) und des Deduplizierungsstatus. Anwendbar auf Prozeduren, Diagnosen, Tumorkonferenzen und weitere Ressourcentypen. |

### Terminology: Value Sets 

These define sets of codes used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Alle_DQ_Indikatoren_VS](ValueSet-primary.md) |  |
| [MII VS Provenance Prozedur Herkunft](ValueSet-mii-vs-provenance-prozedur-herkunft.md) | Value Set für die Herkunft onkologischer Prozeduren zur Unterscheidung von Datenquellen und Deduplizierungsstatus. |
| [Procedure Intent Value Set](ValueSet-procedure-intent-vs.md) | The purpose of a procedure. |

### Terminology: Code Systems 

These define new code systems used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [DQ_Rule_Successful](CodeSystem-dq-rule-successful.md) |  |
| [Greifswald OBC DQ-Framework](CodeSystem-Greifswald-OBC-DQ-Framework.md) | Data Quality Framework by COS. |
| [MII CS Datenquellsystem](CodeSystem-mii-cs-datenquellsystem.md) | Hierarchisches CodeSystem zur Klassifikation von Datenquellsystemen. Top-Level unterscheidet Primärsysteme (Erfassung am Ort der Versorgung) von Sekundärsystemen (Aufnahme/Transformation aus Primärsystemen). Darunter konkrete Systemtypen wie KIS, Abrechnungssystem, DRG-Grouper, DWH usw. Die Hierarchie erlaubt Subsumption-basierte Filter (z. B. ?type:below=Sekundaersystem).
| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| Stand 2026 existiert kein international etablierter CodeSystem-Standard für Datenquellsystem-Typen im Kontext klinischer Sekundärnutzung. Verwandte, aber nicht direkt anwendbare Quellen: ISO/IEC 25010 (Software-Qualitätsmodell, kein Typ-Katalog), IEC 62304 (Risiko-Klassen für Medizinprodukte-Software), HL7 v3 RoleCode (Einrichtungstypen, nicht IT-Systeme), IHE Actors (profil-spezifische Rollen wie Document Source / Repository), SNOMED CT (sehr grobe Codes wie 706594005 | Information system | oder 308040009 | Hospital information system | ), gematik Primärsystem-Definition (TI-spezifisch, nur Primär-Begriff). Dieses CodeSystem ist daher ein MII-spezifischer Vorschlag und kandidiert zur Übernahme in MII-weite Terminologie-Pflege. |
 |
| [MII CS Provenance Prozedur Herkunft](CodeSystem-mii-cs-provenance-prozedur-herkunft.md) | CodeSystem für die Herkunft onkologischer Prozeduren zur Unterscheidung von Datenquellen und Deduplizierungsstatus. |

### Example: Example Instances 

These are example instances that show what data produced and consumed by systems conforming with this implementation guide might look like.

| | |
| :--- | :--- |
| [Bundle: Abrechnungskontext (Beispielfall mi-001)](Bundle-bundle-abrechnungskontext-mi-001.md) | Collection-Bundle mit allen Ressourcen des Anwendungsbeispiels Abrechnungsdatenkontext. |
| [Condition: Hauptdiagnose I21.0](Condition-cond-mi-001-hd-i21.md) | Akuter transmuraler Myokardinfarkt der Vorderwand (HD nach §21/§301). |
| [Condition: Nebendiagnose I10.90](Condition-cond-mi-001-nd-i10.md) | Essentielle Hypertonie als Nebendiagnose. Erlöswirksam nach DRG-Logik (PCCL-relevant), wird daher in §21/§301 standardmäßig codiert. |
| [Device: ETL-Pipeline KIS-DRG → FHIR (v1.4.2)](Device-etl-p21-fhir-v142.md) | Versionierte ETL-Pipeline, die aus dem KIS-DRG-Aufbereitungsstand FHIR-Ressourcen für das DIZ erzeugt. Diese Pipeline ist der Author der FHIR-Ressourcen — nicht das datenliefernde Krankenhaus selbst und nicht der G-DRG-Grouper. |
| [Device: Ikarus-KIS am UKB (Quellsystem)](Device-src-ikarus-kis-ukb.md) | Krankenhausinformationssystem 'Ikarus-KIS' (fiktiver Hersteller mit Anlehnung an reale KIS-Anbieter) am UKB, hier in der Rolle als Quellsystem für DRG-aufbereitete Routinedaten. Klassifiziert per MII-CodeSystem als Sekundärsystem (zweckgebunden aufbereitet). |
| [DocumentReference: KIS-DRG-Aufbereitungsstand 2026-03-15](DocumentReference-kis-drg-aufbereitung-2026-03-15.md) | DRG-aufbereiteter Stand der KIS-Routinedaten zum Aufenthalt enc-mi-001. Gemeinsame Quelle für §21-CSV (an InEK), §301-DTA (an Krankenkasse) und FHIR-Bundle (ins DIZ). |
| [Encounter (Aufenthalt 1.-15.3.2026)](Encounter-enc-mi-001.md) | Stationärer Aufenthalt mit Notfallaufnahme wegen akutem STEMI. |
| [Organization: Universitätsklinikum Beispielstadt](Organization-org-ukb.md) | Datenlieferndes Krankenhaus, identifiziert über IKNR. |
| [Patient (Beispielfall Myokardinfarkt)](Patient-pat-mi-001.md) | Pseudonymisierter Beispielpatient für den Anwendungsfall Abrechnungsdatenkontext. |
| [Procedure: PTCA mit DES (8-837.k0)](Procedure-proc-mi-001-ptca.md) | Perkutane transluminale Koronarangioplastie mit Implantation eines Drug-Eluting-Stents. |
| [Provenance: Abrechnungskontext-ETL für Aufenthalt mi-001](Provenance-prov-abrechnungskontext-mi-001.md) | Dokumentiert, dass die FHIR-Ressourcen aus einer DRG-aufbereiteten Routinedatenstrecke stammen (Abrechnungskontext nach §21/§301-Inhaltsspec), erzeugt zeitnah durch eine versionierte ETL-Pipeline aus dem KIS-DRG-Aufbereitungsstand. |
| [Provenance: Deduplizierung](Provenance-mii-exa-provenance-deduplizierung.md) | Beispiel: Die OP-Prozedur wurde durch Zusammenführung der Abrechnungsprozedur (op-1 v1) und der oBDS-Importprozedur (op-2 v1) dedupliziert. Das Ergebnis ist op-1 v2. |
| [Provenance: Erstanlage Diagnose aus oBDS-Import](Provenance-mii-exa-provenance-obds-import-diagnose.md) | Beispiel: Die Primärtumor-Diagnose wurde aus dem oBDS-Melderegister via obds-to-fhir ETL in das DIZ-Repository importiert. |
| [Provenance: Erstanlage Tumorkonferenz aus oBDS-Import](Provenance-mii-exa-provenance-obds-import-tumorkonferenz.md) | Beispiel: Der Tumorkonferenz-CarePlan wurde aus dem oBDS-Melderegister via obds-to-fhir ETL in das DIZ-Repository importiert. |
| [Provenance: Erstanlage aus Abrechnung](Provenance-mii-exa-provenance-abrechnung-import.md) | Beispiel: Die OP-Prozedur wurde aus den Abrechnungsdaten (KIS) in das DIZ-Repository importiert. |
| [Provenance: Erstanlage aus oBDS-Import](Provenance-mii-exa-provenance-obds-import.md) | Beispiel: Die OP-Prozedur wurde aus dem oBDS-Melderegister via obds-to-fhir ETL in das DIZ-Repository importiert. |
| [dq-test-1](Observation-dq-test-1.md) |  |
| [mighty-m](Patient-mighty-m.md) | Example of Patient |

