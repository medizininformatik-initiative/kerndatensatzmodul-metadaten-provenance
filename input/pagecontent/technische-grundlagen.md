Der folgende Abschnitt zählt relevante Standards und Initiativen auf, welche Einfluss auf die Entwicklung des Provenancekonzepts genommen haben. Die Verwendung existierender Standards ist nicht nur wissenschaftliche Best Practice, sondern stellt auch eine minimale Interoperabilität mit Daten aus anderen Repositorien sicher.

### Bemerkung zur terminologischen Abgrenzung

Die Abgrenzung von Daten und Metadaten ist nicht trivial und existierende Unterscheidungen sind nicht unumstritten. Dasselbe gilt auch für Provenance-Metadaten als Subtyp von Metadaten. Während die Einstufung von Provenance als Subklasse von Metadaten selbst mehrheitlich unstrittig ist, ist die Abgrenzung zwischen Provenance-Merkmal und anderweitigem Metadatum schwierig und wird im Rahmen dieses Konzepts großzügig interpretiert.

### Dublin Core (DC)

Unter Dublin Core, genauer Dublin Core Metadata Element Set (ISO 15836-1), wird eine Sammlung von initial 15 Merkmalen verstanden, die 1995 als einer der ersten nicht-technischen Standards abgestimmt wurde, um Metadaten in Webseiten (und anderen Web-Ressourcen) auszeichnen zu können. 2012 wurde eine Aktualisierung des Standards unter dem Namen DCMI Metadata Terms (DCTERMS, ISO 15836-2) vorgenommen. DCTERMS teilt die Metadaten in Kategorien/Hierarchien ein, definiert zusätzliche Merkmale (u.a. Provenance) und legt für einzelne Elemente Schemas und Datentypen fest. Aufgrund seiner Einfachheit und breiten Anwendbarkeit wird Dublin Core als einer der wenigen Metadatenstandards durchgängig benutzt.

### W3C PROV

W3C PROV ist ein Standard zur Beschreibung von Provenance-Information für das WWW und geht damit über die Beschreibung von Webseiten deutlich hinaus. Mit PROV lassen sich prinzipiell alle Dinge beschreiben, denen man eine Identifikationsnummer geben kann (physisch vorhanden, virtuell oder imaginär). PROV ist ein domänenunabhängiges Top-Level-Modell und basiert im Wesentlichen auf drei Konzepten:

- **Entität** -- Dinge, die beschrieben werden sollen
- **Aktivität** -- Handlung, die Entitäten erzeugt, benutzt oder verändert
- **Agent** -- Person, Organisation oder Software, die eine Form von Verantwortung für die Erzeugung, Benutzung oder Veränderungen einer Entität im Rahmen einer Aktivität haben

Wichtiger Unterschied zu Dublin Core ist die notwendige Behandlung von Aktivitäten, was das Modell ausdrucksstärker, aber auch komplexer macht.

PROV wurde 2013 standardisiert und bietet neben dem Datenmodell viele weitere Komponenten wie eine Ontologie, ein XML-Schema, eine Abfragesprache und ein Mapping nach Dublin Core. W3C PROV ist der Goldstandard im Bereich der wissenschaftlichen Provenance.

### FHIR Metamodell und FHIR Provenance Ressource

Provenance wurde seit Jahrzehnten in praktisch allen HL7-Standards bedacht und gelebt. Dementsprechend nimmt das Thema auch bei FHIR eine zentrale Rolle ein. Allerdings werden Provenance-Daten in FHIR nicht zentral gehalten, sondern an verschiedenen Stellen verteilt gespeichert. Hintergrund ist die Verwendung des **5Ws-Patterns** als ein zentrales Entwicklungsmuster in FHIR. "5Ws" steht für *Who -- What -- When -- Where -- Why* und bedeutet übertragen, dass alle FHIR-Ressourcen diese "W"-Fragen (falls anwendbar) beantworten müssen. Dadurch werden wichtige Provenance-Attribute durchgängig adressiert.

Provenance (im breiteren Verständnis) ist mindestens in 5 verschiedenen Ebenen realisierbar:

#### Ebene 1: Spezifische Attribute der FHIR-Ressourcen

Die wichtigste und weitverbreitetste Ebene. FHIR Observations haben neben einem konkreten Wert bspw. optionale Attribute für Status, Kategorie oder Publikationszeit. Damit lassen sich die meisten klinisch relevanten Provenance-Informationen erfassen. Vorteilhaft ist insbesondere die normierte Kodierung der einzelnen Attribute.

#### Ebene 2: AuditEvent

Die FHIR-Ressource `AuditEvent` deckt spezifische sicherheitsrelevante Aktionen ab. Sie überschneidet sich inhaltlich in einigen Punkten mit Provenance, da sie auch Updates von Werten behandelt, ist aber auch keine vollständige Untermenge, da sie bspw. auch Login-Versuche in ein Informationssystem unterstützt.

#### Ebene 3: FHIR Provenance Ressource

Die FHIR-Ressource `Provenance` erlaubt generische Provenance-Aussagen und basiert auf dem Standard W3C PROV. Sie wird von manchen FHIR-Ressourcen explizit adressiert (siehe `MedicationAdministration.eventHistory`), erfährt aber bislang **keine breite praktische Verwendung**. Daher ist ihre Best-Practice-Anwendung noch unklar. Prinzipiell wäre es auch möglich, Attribute aus anderen Ressourcen (siehe Ebene 1) zu duplizieren, um einen zusätzlichen Datenstrom für bestimmte Softwaresysteme zu generieren.

#### Ebene 4: Meta-Element

Der FHIR-Datentyp `Meta` ist Teil der abstrakten FHIR-Basisklasse `Resource` und somit Teil aller FHIR-Ressourcen. Die Elemente in Meta sind teilweise sehr spezifisch (z.B. Profilkonformität), teilweise sehr generisch. Insbesondere die Möglichkeit, beliebige Tags als codierte Begriffe aus einem kontrollierten Vokabular zu verwenden, bietet Optionen zur Abbildung von Provenance.

#### Ebene 5: Extensions

FHIR erlaubt die Definition eigener Erweiterungen, um lokale Konventionen durchzusetzen. Extensions können Provenance-Informationen enthalten, die dann jedoch nicht breit verwertbar sind. Daher ist dies die am wenigsten empfehlenswerte Variante.

### Zusammenfassung

> Zusammenfassend lässt sich feststellen: FHIR Provenance ist nicht gleich W3C PROV. FHIR bildet die meisten Merkmale in eigenen Attributen ab. Je nachdem, ob man Auditlogs als Teil von Provenance sieht, steht hierfür eine weitere Ressource zur Verfügung. Nur für den nicht anderweitig spezifizierbaren Rest steht die FHIR Provenance Ressource zur Verfügung -- die Erwartung der FHIR-Community ist, dass diese Ressource selten genutzt wird. Zusätzlich ist auch die FHIR-Provenance-Ressource an verschiedene HL7-Vokabulare gebunden und kann nicht völlig frei modelliert werden.

*Quelle: MII Taskforce Metadaten, Konzeptpapier v1.0, 13.07.2025 (Matthias Löbe et al.)*
