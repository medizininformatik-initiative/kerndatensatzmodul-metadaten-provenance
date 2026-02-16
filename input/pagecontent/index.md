Dieses Dokument beschreibt Konzepte und Implementierungsalternativen zur Unterstützung einer basalen Provenance im MII-Kerndatensatz. Es dient als informativer Beitrag zur Diskussion innerhalb der Medizininformatik-Initiative und stellt keine verbindliche Festlegung dar.

| Veröffentlichung |  |
|---------|---|
| Datum   | 2025-02-16 |
| Version | 0.1.0 |
| Status  | Entwurf (informativ) |
| Realm   | DE |

### Zielsetzung

Versorgungsdaten unterscheiden sich in vielen Punkten von prospektiven Datensammlungen. Diese Unterschiede müssen ausgedrückt werden können, um korrekte Auswertungen zu ermöglichen. Dieses Dokument stellt zwei technische Ansätze zur Provenance-Auszeichnung gegenüber:

1. **Meta.tag-Ansatz** -- leichtgewichtige Auszeichnung über kontrollierte Vokabulare in `Resource.meta.tag` (Taskforce Metadaten, Löbe et al.)
2. **FHIR Provenance Ressource** -- eigene Provenance-Ressourcen mit Referenzen auf Quell- und Zielressourcen (BZKF obds-to-fhir, Gulden)

Beide Ansätze werden anhand konkreter Beispiele beschrieben und verglichen.

### Beitragende

- MII Taskforce Metadaten (Matthias Löbe et al.) -- Konzeptpapier v1.0, Juli 2025
- Christian Gulden (BZKF) -- Provenance-Implementierung in obds-to-fhir
- Thomas Debertshäuser (BIH/Charité) -- Redaktion und Zusammenführung

### Ansprechpartner

Fragen zu der vorliegenden Publikation können jederzeit unter [chat.fhir.org](https://chat.fhir.org) im Stream 'german/mi-initiative' gestellt werden.

Anmerkungen und Kritik in Form von 'Issues' im [GitHub-Projekt](https://github.com/medizininformatik-initiative/kerndatensatzmodul-metadaten-provenance/issues).

### Disclaimer

Dieser Leitfaden ist ein informativer Beitrag zu Spezifikationsalternativen. Er stellt keine normative Festlegung der Medizininformatik-Initiative dar.
