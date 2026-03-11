Dieses Dokument beschreibt Konzepte und Implementierungsalternativen zur Unterstützung einer basalen Provenance im MII-Kerndatensatz. Es dient als informativer Beitrag zur Diskussion innerhalb der Medizininformatik-Initiative und stellt keine verbindliche Festlegung dar.

| Veröffentlichung |  |
|---------|---|
| Datum   | 2025-02-16 |
| Version | 0.1.0 |
| Status  | Entwurf (informativ) |
| Realm   | DE |

### Leitmotiv: Von der Dokumentation zur Aktion

> **Metadaten, die Datenqualität nicht nur beschreiben, sondern operativ steuerbar machen -- umsetzbar mit einer Zeile Code (`Meta.tag`) oder als begleitende Ressourceninfrastruktur (`FHIR Provenance`).**

Provenance-Metadaten im MII-Kerndatensatz sind mehr als passive Dokumentation. Sie sind der operative Ankerpunkt, um Datenqualitätsprobleme systematisch zu **erkennen**, zu **lokalisieren** und zu **beheben**:

1. **Beschreiben** -- Woher stammen die Daten? Welches Quellsystem, welche ETL-Strecke, welches Datenmodell?
2. **Erkennen** -- Welche Probleme haben die Daten? Duplikate, fehlende Werte, Widersprüche zwischen Quellen?
3. **Handeln** -- Gezielte Abfragen und Korrekturen auf Basis der Metadaten: alle oBDS-Importe mit logischen Widersprüchen filtern, alle Duplikate eines Zeitraums identifizieren, fehlerhafte ETL-Läufe gezielt nachtransformieren.

Die MII Taskforce Metadaten verbindet dabei wissenschaftliche Grundlagen (Dublin Core, W3C PROV, Greifswalder DQ-Framework) mit der operativen Realität in den Datenintegrationszentren.

### Zielsetzung

Versorgungsdaten unterscheiden sich in vielen Punkten von prospektiven Datensammlungen. Diese Unterschiede müssen ausgedrückt werden können, um korrekte Auswertungen zu ermöglichen. Dieses Dokument stellt zwei technische Ansätze zur Provenance-Auszeichnung gegenüber:

1. **Meta.tag-Ansatz** -- leichtgewichtige Auszeichnung über kontrollierte Vokabulare in `Resource.meta.tag` (Taskforce Metadaten, Löbe et al.). Pragmatisch, sofort implementierbar, mit einer Zeile Code pro Aussage.
2. **FHIR Provenance Ressource** -- eigene Provenance-Ressourcen mit Referenzen auf Quell- und Zielressourcen (BZKF obds-to-fhir, Gulden). Strukturiert, international interoperabel, mit vollständiger Transformationskette.

Beide Ansätze sind **komplementär**, nicht gegensätzlich. Sie werden anhand konkreter Beispiele -- insbesondere am [Deduplizierungsszenario in der Onkologie](anwendungsbeispiel-deduplizierung.html) mit vollständiger Ressourcen-History -- beschrieben und verglichen.

### Beitragende

- MII Taskforce Metadaten (Matthias Löbe et al.) -- Konzeptpapier v1.0, Juli 2025
- Christian Gulden (BZKF) -- Provenance-Implementierung in obds-to-fhir
- Thomas Debertshäuser (BIH/Charité) -- Redaktion und Zusammenführung

### Ansprechpartner

Fragen zu der vorliegenden Publikation können jederzeit unter [chat.fhir.org](https://chat.fhir.org) im Stream 'german/mi-initiative' gestellt werden.

Anmerkungen und Kritik in Form von 'Issues' im [GitHub-Projekt](https://github.com/medizininformatik-initiative/kerndatensatzmodul-metadaten-provenance/issues).

### Disclaimer

Dieser Leitfaden ist ein informativer Beitrag zu Spezifikationsalternativen. Er stellt keine normative Festlegung der Medizininformatik-Initiative dar.
