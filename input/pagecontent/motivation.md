### Motivation

Versorgungsdaten unterscheiden sich in vielen Punkten von prospektiven Datensammlungen, die klinische Forscher gewohnt sind. Diese Unterschiede müssen ausgedrückt werden können, um korrekte statistische Auswertungen zu ermöglichen. Beispiele sind:

- Fehlende Daten aufgrund systemischer Restriktionen (zeitliche oder örtliche Nichtverfügbarkeit)
- Mehrfache Dateninstanzen desselben Datums wegen multipler Speicherung (Laborinformationssystem, KIS, Kommunikationsserver)
- Widersprüchliche Daten durch verschiedene Transformationsprozesse (Diagnosen in klinischer Dokumentation vs. § 21 Datensatz)
- Unterschiedlich aktuelle Daten (vorläufige Meldungen, Korrekturen, Ausschlüsse, Vidierung)
- Daten, deren Aussage durch bestimmte Attribute modifiziert oder gar negiert wird (z.B. Ausschlussdiagnosen)
- Daten, die bei Transformationsprozessen bearbeitet worden und sich von den Quellsystemen unterscheiden, bspw. durch Kurations-, Pseudonymisierungs-, Anonymisierungs- oder Minimierungsverfahren

### Problematik

Medizinische Daten können bekanntermaßen komplex, groß, schnelllebig und heterogen sein. Im klinischen Alltag werden sie von unterschiedlichen Akteuren mit Hilfe unterschiedlicher Informationssysteme und mit unterschiedlichem Verwendungsziel erhoben. Sollen sie für Zwecke der Forschung genutzt werden, müssen bestimmte Anforderungen an einen Datensatz im Hinblick auf Zugreifbarkeit, Qualität und Vertrauenswürdigkeit erfüllt werden. Datennutzungsprojekte, die Daten aus verschiedenen Quellen über komplexe Verarbeitungsketten zusammenführen, benötigen für die einzelnen Datenpunkte eine Auszeichnung des Kontexts, in dem sie erhoben wurden und der Veränderungen, die in einzelnen Zwischenschritten vorgenommen werden.

Gerade beim Verstehen und Nachvollziehen von Ergebnissen aus wissenschaftlichen Publikationen stellen sich häufig Fragen wie:

- Welche Gruppe hat die Daten verantwortlich erhoben? Expertise? Wem gehören sie?
- Mit welcher Zielsetzung wurden sie erhoben? Forschung, Behandlung, administrative Belange?
- Welche Messmethoden wurden verwendet? Gemessen, gefragt, geschätzt, errechnet?
- Wo kommen die Daten her? Welche Werkzeuge wurden zur Generierung des Datensatzes bzw. der statistischen Ergebnisse genutzt?
- Wann wurde der Datensatz erzeugt? Welche Änderungen gab es an den Originaldaten?
- Welche Abhängigkeiten von anderen Daten gibt es?
- Wurden die Daten kuratiert oder Datenqualitätschecks angewendet?
- Wurden die Daten im Zuge der Ausleitung geprüft oder verändert, um Anforderungen wie Datensparsamkeit, Datenschutz oder syntaktischer Korrektheit sicherzustellen?

Viele der Antworten auf solche Fragen lassen sich im Nachhinein nicht mehr oder nur mit gewaltigem Aufwand erbringen. Es ist daher von großer Bedeutung, wichtige Parameter frühzeitig zu erfassen.

Auf der anderen Seite lässt sich leicht erkennen, dass es eine Vielzahl theoretisch interessanter Parameter geben könnte und der Aufwand der Erfassung aller möglichen Parameter vom Datenproduzenten nicht leistbar ist. Daher ist eine Konsolidierung und Konsentierung der benötigten Merkmale nach realem Bedarf erforderlich.

### Herausforderung: Einfachheit vs. Vollständigkeit

Eine weitere wichtige Anforderung besteht in der Harmonisierung der Ausprägung der Merkmale. Es ist erwartbar, dass beispielsweise die Verpflichtung zur Erfassung der Herkunft in einem gleichnamigen Merkmal eine Vielzahl verschiedener Interpretationen und Ausprägungen hervorbringen würde, die schwer vergleichbar und nicht maschinell interpretierbar wären.

Zusammenfassend ergibt sich daraus die Herausforderung, zwischen einem **einfachen, intuitiv handhabbaren** (aber eventuell ausdrucksbeschränktem) Vokabular und einem **sehr detaillierten, kompletten** Vokabular, welches aber schwer zu erlernen und implementieren ist, zu entscheiden.

*Quelle: MII Taskforce Metadaten, Konzeptpapier v1.0, 13.07.2025 (Matthias Löbe et al.)*
