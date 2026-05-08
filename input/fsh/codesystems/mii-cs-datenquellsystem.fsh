CodeSystem: MII_CS_Datenquellsystem
Id: mii-cs-datenquellsystem
Title: "MII CS Datenquellsystem"
Description: "Hierarchisches CodeSystem zur Klassifikation von Datenquellsystemen. Top-Level unterscheidet Primärsysteme (Erfassung am Ort der Versorgung) von Sekundärsystemen (Aufnahme/Transformation aus Primärsystemen). Darunter konkrete Systemtypen wie KIS, Abrechnungssystem, DRG-Grouper, DWH usw. Die Hierarchie erlaubt Subsumption-basierte Filter (z. B. ?type:below=Sekundaersystem).\n\nStand 2026 existiert kein international etablierter CodeSystem-Standard für Datenquellsystem-Typen im Kontext klinischer Sekundärnutzung. Verwandte, aber nicht direkt anwendbare Quellen: ISO/IEC 25010 (Software-Qualitätsmodell, kein Typ-Katalog), IEC 62304 (Risiko-Klassen für Medizinprodukte-Software), HL7 v3 RoleCode (Einrichtungstypen, nicht IT-Systeme), IHE Actors (profil-spezifische Rollen wie Document Source / Repository), SNOMED CT (sehr grobe Codes wie 706594005 |Information system| oder 308040009 |Hospital information system|), gematik Primärsystem-Definition (TI-spezifisch, nur Primär-Begriff). Dieses CodeSystem ist daher ein MII-spezifischer Vorschlag und kandidiert zur Übernahme in MII-weite Terminologie-Pflege."
* ^meta.profile = "http://hl7.org/fhir/StructureDefinition/shareablecodesystem"
* ^url = "https://www.medizininformatik-initiative.de/fhir/ext/modul-metadaten-provenance/CodeSystem/mii-cs-datenquellsystem"
* ^status = #draft
* ^experimental = true
* ^hierarchyMeaning = #is-a
* insert Publisher
* insert PR_CS_VS_Version
* ^caseSensitive = true
* ^content = #complete

// === Top-Level ===
* #Primaersystem    "Primärsystem"   "System der Primärerfassung am Ort der Versorgung — Daten entstehen hier zum ersten Mal."
* #Sekundaersystem  "Sekundärsystem" "System, das Daten aus Primärsystemen aufnimmt oder transformiert (zweckgebunden aufbereitet)."

// === Primärsysteme (Children, vorgehalten für künftige Nutzung) ===
* #Primaersystem #KIS              "Krankenhausinformationssystem"           "Zentrales klinisches Informationssystem des Krankenhauses (Aufnahme, Verlegung, Entlassung, Doku)."
* #Primaersystem #Tumordoku        "Tumordokumentationssystem"               "Spezialsystem zur klinischen Tumordokumentation."
* #Primaersystem #LIS              "Laborinformationssystem"                  "System zur Verwaltung von Laborbefunden und -anforderungen."
* #Primaersystem #RIS              "Radiologie-Informationssystem"            "System zur Verwaltung radiologischer Befunde und Untersuchungen."
* #Primaersystem #PACS             "Picture Archiving and Communication System" "Bildarchivierungssystem (Radiologie, Pathologie etc.)."
* #Primaersystem #OP_Doku          "OP-Dokumentationssystem"                 "Dokumentationssystem für operative Eingriffe."

// === Sekundärsysteme (Children, vorgehalten für künftige Nutzung) ===
* #Sekundaersystem #Abrechnungssystem "Abrechnungssystem"                     "System oder Subsystem zur Erstellung von Abrechnungs- und DRG-Datensätzen (§21 KHEntgG, §301 SGB V)."
* #Sekundaersystem #DRG_Grouper       "DRG-Grouper"                           "System zur DRG-/PEPP-Klassifikation."
* #Sekundaersystem #DWH               "Data Warehouse"                        "Konsolidiertes Datenarchiv für Auswertung und Reporting."
* #Sekundaersystem #Forschungsdaten   "Forschungsdaten- / DIZ-System"         "Forschungsdaten-Plattform oder Datenintegrationszentrum (z. B. MII-DIZ-Repository)."
* #Sekundaersystem #Krebsregister     "Krebsregister"                         "Klinisches oder epidemiologisches Krebsregister."
