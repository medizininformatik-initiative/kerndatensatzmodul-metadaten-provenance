### Ausgangslage

Versorgungsdaten unterscheiden sich in vielen Punkten von prospektiven Datensammlungen, die klinische Forscher gewohnt sind. In bisher erfolgten Datennutzungsprojekten der MII sind teilweise Probleme in der Interpretation der Daten durch Dritte aufgetreten. Diese Eigenheiten waren in der Struktur der Versorgungsdaten begründet und keine Fehler des Datenausleitungsprozesses.

### Typische Probleme

- **Fehlende Daten** aufgrund systemischer Restriktionen (zeitliche oder örtliche Nichtverfügbarkeit)
- **Mehrfache Dateninstanzen** desselben Datums wegen multipler Speicherung (Laborinformationssystem, KIS, Kommunikationsserver)
- **Widersprüchliche Daten** durch verschiedene Transformationsprozesse (Diagnosen in klinischer Dokumentation vs. § 21 Datensatz)
- **Unterschiedlich aktuelle Daten** (vorläufige Meldungen, Korrekturen, Ausschlüsse, Vidierung)
- **Modifizierte Aussagen** durch bestimmte Attribute (z.B. Ausschlussdiagnosen)
- **Transformationsartefakte** durch Kurations-, Pseudonymisierungs-, Anonymisierungs- oder Minimierungsverfahren

### Fragestellungen

Beim Verstehen und Nachvollziehen von Ergebnissen aus wissenschaftlichen Publikationen stellen sich häufig Fragen wie:

- Welche Gruppe hat die Daten verantwortlich erhoben? Wem gehören sie?
- Mit welcher Zielsetzung wurden sie erhoben? Forschung, Behandlung, administrative Belange?
- Welche Messmethoden wurden verwendet? Gemessen, gefragt, geschätzt, errechnet?
- Wo kommen die Daten her? Welche Werkzeuge wurden zur Generierung genutzt?
- Wann wurde der Datensatz erzeugt? Welche Änderungen gab es an den Originaldaten?
- Welche Abhängigkeiten von anderen Daten gibt es?
- Wurden die Daten kuratiert oder Datenqualitätschecks angewendet?
- Wurden die Daten im Zuge der Ausleitung geprüft oder verändert?

Viele dieser Antworten lassen sich im Nachhinein nicht mehr oder nur mit gewaltigem Aufwand erbringen. Es ist daher von großer Bedeutung, wichtige Parameter frühzeitig zu erfassen.

### Herausforderung: Einfachheit vs. Vollständigkeit

Es gibt eine Vielzahl theoretisch interessanter Parameter. Der Aufwand der Erfassung aller möglichen Parameter ist vom Datenproduzenten nicht leistbar. Daher ist eine Konsolidierung und Konsentierung der benötigten Merkmale nach realem Bedarf erforderlich.

Eine weitere wichtige Anforderung besteht in der Harmonisierung der Ausprägung. Es ist erwartbar, dass die Verpflichtung zur Erfassung der Herkunft in einem gleichnamigen Merkmal eine Vielzahl verschiedener Interpretationen und Ausprägungen hervorbringen würde, die schwer vergleichbar und nicht maschinell interpretierbar wären.

Zusammenfassend ergibt sich die Herausforderung, zwischen einem **einfachen, intuitiv handhabbaren** (aber eventuell ausdrucksbeschränktem) Vokabular und einem **sehr detaillierten, kompletten** Vokabular, welches aber schwer zu erlernen und implementieren ist, zu entscheiden.

*Quelle: MII Taskforce Metadaten, Konzeptpapier v1.0, Juli 2025 (Matthias Löbe et al.)*
