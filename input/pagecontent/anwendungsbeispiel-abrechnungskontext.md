### Worum es geht

Wenn in MII-/DIZ-Diskussionen von **„&#167;21-Daten"** die Rede ist, ist meist nicht die tatsächlich an die InEK übermittelte Datenlieferung gemeint, sondern eine **DRG-aufbereitete Routinedatenstrecke**, die zeitnah aus dem Krankenhausinformationssystem (KIS) nach FHIR ausgespielt wird. Diese Seite schärft den Begriff und zeigt, **wie sich der Abrechnungs-Charakter solcher Daten sauber per FHIR Provenance dokumentieren lässt**, ohne den Begriff „&#167;21" zu überdehnen.

### Begriffsklärung: drei Lesarten von „&#167;21-Daten"

| Lesart | Was gemeint ist | Wann verfügbar | Realität im DIZ? |
|---|---|---|---|
| **A. Die &#167;21-CSV-Lieferung** | Das konkrete CSV-Paket, das das Krankenhaus jährlich an die InEK übermittelt (`Stamm.csv`, `Fall.csv`, `FAB.csv`, `ICD.csv`, `OPS.csv`, `Entgelte.csv`, `ZE.csv`) | bis 31.03. des Folgejahres (Frist nach KHEntgG &#167;21) | Selten — die FHIR-Daten werden in der Regel **nicht** aus dieser Lieferung rück-transformiert |
| **B. &#167;21-konforme Aufbereitung** | Daten nach &#167;21-Inhaltsspec aufbereitet (DRG-Codierung, Grouping, Filterregeln), aber **nicht** als CSV-Lieferung an InEK, sondern parallel als FHIR-Bundle ins DIZ | zeitnah (täglich/wöchentlich) | **Häufig** — entspricht der typischen DIZ-ETL-Strecke |
| **C. DRG-aufbereitete Routinedaten** | Lose Bezeichnung für „Daten aus dem KIS, durch Codierung und DRG-Logik geprägt", ohne strikten Bezug zur &#167;21-Spec | live | **Häufig** — z. B. interne fall-begleitende Codierung |

In der Praxis treffen DIZ-Daten meist **Lesart B** oder **C**. Die Provenance dieser Seite modelliert genau diesen Fall: zeitnahe FHIR-Erzeugung aus dem KIS-DRG-Aufbereitungsstand, **nicht** Ableitung aus einer &#167;21-CSV-Lieferung.

### &#167;21 vs. &#167;301: die große Schnittmenge

Sowohl die jährliche &#167;21-Lieferung an die InEK als auch die fall-bezogene &#167;301-Übermittlung an die Krankenkassen werden aus **demselben KIS-DRG-Aufbereitungsstand** gespeist. Inhaltlich überlappen sie sich stark.

| Eigenschaft | &#167;301 SGB V | &#167;21 KHEntgG |
|---|---|---|
| **Empfänger** | Krankenkasse des Versicherten | InEK (Datenannahmestelle) |
| **Format** | EDIFACT/DTA | CSV |
| **Zeitpunkt** | je Fall, **zeitnah** (Aufnahme: 3 Werktage; Entlassung: nach Codierung) | jährlich, bis 31.03. Folgejahr |
| **Versicherten-Identifikation** | ja (KV-Nr., Versichertenstatus) | nein (pseudonymisiert) |
| **DRG/Entgelte** | fall-individuell (Rechnung) | aggregiert (Kalkulation) |
| **Gemeinsam** | Aufnahme/Entlassung, **HD/ND mit Sicherheitskennzeichen**, **OPS mit Datum**, Fachabteilungen, DRG, Belegungstage |

Für die Sekundärnutzung tragen beide Quellen denselben **DRG-codierten Kern**. Die wichtigste gemeinsame Eigenschaft ist nicht die Format- oder Empfängerwahl, sondern die **Filterung durch die Abrechnungs-/DRG-Logik** — und genau diese Eigenschaft soll die Provenance dokumentieren.

```
KIS-DRG-Aufbereitung 2026-03-15
       ├─→ &#167;301-DTA       (3 Werktage nach Entlassung, an Krankenkasse)
       ├─→ FHIR-Bundle    (zeitnah, ins DIZ)              ← Quelle dieses Beispiels
       └─→ &#167;21-CSV        (Q1 2027, an InEK)
```

### Warum das für die Provenance wichtig ist

Aus dieser Schwester-Output-Konstellation folgen drei Modellierungs-Entscheidungen:

1. **`Provenance.entity.what` zeigt nicht auf die &#167;21-CSV**, sondern auf den **gemeinsamen KIS-DRG-Aufbereitungsstand**. Die &#167;21-Lieferung ist ein paralleler Output, nicht der Vorfahre der FHIR-Daten.
2. **`Provenance.agent[author] = Device (ETL-Job)`** — nicht das Krankenhaus, nicht der G-DRG-Grouper. Die FHIR-Ressource wird durch die ETL-Pipeline erzeugt.
3. **`Provenance.reason = HPAYMT`** trägt den Abrechnungs-Charakter; **`policy`** verweist auf &#167;21- bzw. &#167;301-Spec als „nach welcher Inhaltsdefinition wurde aufbereitet".

### Klinisches Beispiel: Akuter Myokardinfarkt mit PTCA

**Szenario:** 67-jähriger Patient, stationäre Aufnahme als Notfall am 01.03.2026 mit akutem Vorderwand-STEMI. Sofortige PTCA mit Drug-Eluting-Stent. Entlassung nach 14 Tagen am 15.03.2026. ETL-Lauf in der Nacht zum 16.03.2026.

**Codierung im DRG-Kontext:**

| | Code | Bedeutung |
|---|---|---|
| **HD** | `I21.0` | Akuter transmuraler Myokardinfarkt der Vorderwand |
| **ND** | `I10.90` | Essentielle Hypertonie (PCCL-relevant, daher codiert) |
| **OPS** | `8-837.k0` | PTCA mit Implantation eines beschichteten Stents (1 Stent) |

Dieser Fall hat einen **deutlichen Abrechnungs-Bias**: Die ND `I10.90` wird codiert, weil sie erlöswirksam ist (PCCL-relevant für die DRG-Eingruppierung). Ein NLP-extrahierter Entlassbrief würde Hypertonie möglicherweise nur am Rande erwähnen, dafür aber differenziertere Befunde liefern (Killip-Klassifikation, EF, Door-to-Balloon-Zeit), die in der DRG-Codierung nicht erfasst sind.

### Welche Ressourcen das Bundle enthält

| # | Ressource | ID | Zweck |
|---|---|---|---|
| 1 | `Patient` | `pat-mi-001` | Pseudonymisierter Patient |
| 2 | `Encounter` | `enc-mi-001` | Aufenthalt 01.–15.03.2026 |
| 3 | `Condition` (HD) | `cond-mi-001-hd-i21` | I21.0 Vorderwandinfarkt |
| 4 | `Condition` (ND) | `cond-mi-001-nd-i10` | I10.90 Hypertonie |
| 5 | `Procedure` | `proc-mi-001-ptca` | 8-837.k0 PTCA mit DES |
| 6 | `Organization` | `org-ukb` | Datenlieferndes Krankenhaus (IKNR) |
| 7 | `Device` | `etl-p21-fhir-v142` | **ETL-Pipeline als Author** |
| 8 | `Device` | `src-ikarus-kis-ukb` | **Quellsystem** (fiktives „Ikarus-KIS" — klassifiziert als Sekundärsystem) |
| 9 | `DocumentReference` | `kis-drg-aufbereitung-2026-03-15` | KIS-DRG-Aufbereitungsstand als Quelle |
| 10 | `Provenance` | `prov-abrechnungskontext-mi-001` | Provenance über alle FHIR-Ressourcen |
| 11 | `Bundle` | `bundle-abrechnungskontext-mi-001` | Collection-Bundle |

**Eine** Provenance referenziert hier alle erzeugten FHIR-Ressourcen (`target[0..n]`). Soll später eine feinere Granularität dokumentiert werden — z. B. ein zusätzlicher Codierungs-Schritt durch eine Codierfachkraft oder eine separate DRG-Klassifikation —, kommt eine zweite Provenance hinzu.

Vollständige FSH: [`mii-exa-abrechnungskontext.fsh`](https://github.com/medizininformatik-initiative/kerndatensatzmodul-metadaten-provenance/blob/main/input/fsh/examples/mii-exa-abrechnungskontext.fsh).

### Provenance-Graph (W3C PROV-Stil)

Die folgende Darstellung zeigt die Beziehungen zwischen Quell-Entity, ETL-Aktivität, beteiligten Agenten und den erzeugten Ziel-Ressourcen:

<img src="Abrechnungskontext_Prov_Graph.png" alt="Provenance-Graph für den Abrechnungskontext-Beispielfall: KIS-DRG-Aufbereitung als Source-Entity, ETL-Pipeline als Activity, UKB als Performer-Agent, daraus erzeugt: Patient, Encounter, Conditions HD/ND, Procedure" width="100%"/>

Schwester-Outputs aus demselben KIS-DRG-Aufbereitungsstand (&#167;21-CSV an InEK, &#167;301-DTA an Krankenkasse) sind hier bewusst **nicht** dargestellt — sie sind nicht Vorfahren der FHIR-Ressourcen und gehören daher nicht in deren Provenance-Kette.

### Die Provenance im Detail

```fsh
Instance: prov-abrechnungskontext-mi-001
InstanceOf: Provenance
* target[0] = Reference(Patient/pat-mi-001)
* target[+] = Reference(Encounter/enc-mi-001)
* target[+] = Reference(Condition/cond-mi-001-hd-i21)
* target[+] = Reference(Condition/cond-mi-001-nd-i10)
* target[+] = Reference(Procedure/proc-mi-001-ptca)

* recorded = "2026-03-16T03:12:00+01:00"          // ETL-Lauf, 1 Tag nach Entlassung
* occurredPeriod                                   // Zeitraum, den die Daten beschreiben
  * start = "2026-03-01T08:42:00+01:00"
  * end   = "2026-03-15T14:30:00+01:00"

* policy[0] = "https://www.gesetze-im-internet.de/khentgg/__21.html"
* policy[+] = "https://www.gesetze-im-internet.de/sgb_5/__301.html"

* reason   = $v3-ActReason#HPAYMT "Payment"
* activity = $v3-ActReason#HPAYMT "Payment"

* agent[0]
  * type = $provenance-participant-type#author
  * who  = Reference(Device/etl-p21-fhir-v142)
* agent[+]
  * type = $provenance-participant-type#performer
  * who  = Reference(Organization/org-ukb)
* agent[+]
  * type = $provenance-participant-type#informant     // Quellsystem
  * who  = Reference(Device/src-ikarus-kis-ukb)

* entity[0]
  * role = #source
  * what = Reference(DocumentReference/kis-drg-aufbereitung-2026-03-15)
```

Jedes Feld trägt eine konkrete Aussage:

| Feld | Aussage |
|---|---|
| `target[*]` | Diese FHIR-Ressourcen sind alle aus demselben ETL-Lauf entstanden |
| `recorded` | Wann der ETL-Job gelaufen ist (zeitnah, einen Tag nach Entlassung) |
| `occurredPeriod` | Welchen Zeitraum die Daten beschreiben (= Aufenthalt) |
| `policy` | Nach welcher Inhaltsspec aufbereitet wurde (&#167;21 *und* &#167;301 — gemeinsame Charakteristik) |
| `reason = HPAYMT` | Abrechnungskontext — der **load-bearing** Marker für Sekundärnutzung |
| `agent[author]` | Der ETL-Job hat die FHIR-Ressourcen erzeugt |
| `agent[performer]` | Das Krankenhaus ist die Quell-Organisation |
| `agent[informant]` | Das **Quellsystem** (hier: Ikarus-KIS, klassifiziert als Sekundärsystem über das hierarchische [`mii-cs-datenquellsystem`](CodeSystem-mii-cs-datenquellsystem.html)) |
| `entity[source]` | Der konkrete KIS-Aufbereitungsstand, aus dem extrahiert wurde |

### Was Sekundärnutzer:innen damit tun können

Die Provenance ermöglicht automatisierte Filter und Inventarisierungen, ohne dass jede Ressource einzeln getaggt werden muss.

> **Hinweis zu SearchParameter:** Für `Provenance.reason` ist in FHIR R4 **kein Standard-Suchparameter** definiert. Damit die nachfolgenden Filter funktionieren, definiert dieses IG den eigenen SearchParameter [`provenance-reason`](SearchParameter-mii-sp-provenance-reason.html). Server, die diesen registrieren, unterstützen die `?reason=`-Queries; ohne den Parameter müssen Provenance-Ressourcen clientseitig nachgefiltert werden.

**Alle Ressourcen aus Abrechnungskontext finden** (benötigt `provenance-reason`):
```
GET [base]/Provenance?reason=http://terminology.hl7.org/CodeSystem/v3-ActReason|HPAYMT
```

**Conditions, deren Quelle *nicht* Abrechnungskontext ist** (z. B. für klinische Forschungsfragen, bei denen DRG-Codierungs-Bias problematisch wäre — benötigt `provenance-reason`):
```
GET [base]/Condition?_has:Provenance:target:reason:not=...|HPAYMT
```

**Welche Aufbereitungs-Stände haben das DIZ erreicht** (Inventar über Quell-Entities — Standard-Suchparameter):
```
GET [base]/Provenance?entity=DocumentReference/...
```

**Welche ETL-Job-Version hat eine Ressource erzeugt** (für Fehlerrückverfolgung bei Pipeline-Updates — Standard-Suchparameter):
```
GET [base]/Provenance?target=Patient/pat-mi-001
  → Provenance.agent[author].who → Device.version
```

#### Beispiel-Abfragen für Sekundärnutzung

##### Variante A: Alle Abrechnungsdaten (kohorten-übergreifend)

Einfacher Fall — eine Forschungsgruppe oder ein DQ-Prozess will **alle** Ressourcen aus DRG-aufbereiteter Routinedatenstrecke einsehen, ohne Krankheits-Filter:

```
GET [base]/Provenance
  ?reason=http://terminology.hl7.org/CodeSystem/v3-ActReason|HPAYMT
  &_include=Provenance:target
  &_count=200
```

→ liefert alle Provenance-Ressourcen mit Reason `HPAYMT` plus deren `target`-Ressourcen (Patient, Encounter, Condition, Procedure …) als FHIR Bundle. Über `_count` und Paginierung lässt sich der gesamte Bestand exportieren.

Ergänzend, falls man sich für die Quell-Seite interessiert (welche Aufbereitungsstände, welche ETL-Job-Versionen):

```
GET [base]/Provenance
  ?reason=http://terminology.hl7.org/CodeSystem/v3-ActReason|HPAYMT
  &_include=Provenance:entity
  &_include=Provenance:agent
```

→ liefert zusätzlich die referenzierten `DocumentReference`s (KIS-Aufbereitungsstände) und `Device`s (ETL-Pipelines) — gut für Inventar-Reports.

Die Funktion hängt am IG-eigenen [`provenance-reason`](SearchParameter-mii-sp-provenance-reason.html); ohne ihn liefert der Server keinen Match.

##### Variante B: Abrechnungsdaten zu Patient:innen mit Herzinfarkt

Forschungsgruppe will die DRG-codierte Versorgungsrealität von Myokardinfarkt-Patient:innen untersuchen — explizit **aus Abrechnungsdaten**, weil die DRG-Codierung dort vollständig ist (PCCL-Logik, vgl. den Bias-Hinweis [oben](#klinisches-beispiel-akuter-myokardinfarkt-mit-ptca)).

Die Frage zerfällt in zwei Schritte:

**(1) Kohorten-Definition** — Conditions mit I21.\* aus Abrechnungskontext, plus zugehörige Patient:innen:

```
GET [base]/Condition
  ?code:in=http://fhir.de/CodeSystem/bfarm/icd-10-gm|I21.0,
            http://fhir.de/CodeSystem/bfarm/icd-10-gm|I21.1,
            http://fhir.de/CodeSystem/bfarm/icd-10-gm|I21.2,
            http://fhir.de/CodeSystem/bfarm/icd-10-gm|I21.4,
            http://fhir.de/CodeSystem/bfarm/icd-10-gm|I21.9
  &category=http://terminology.hl7.org/CodeSystem/diagnosis-role|billing
  &_has:Provenance:target:reason=http://terminology.hl7.org/CodeSystem/v3-ActReason|HPAYMT
  &_include=Condition:subject
```

→ liefert alle Conditions mit ICD-10-GM I21.\* und deren Patient:innen, eingeschränkt auf solche mit Abrechnungs-Provenance.

**(2) Daten-Extraktion** — alle weiteren Ressourcen dieser Patient:innen aus Abrechnungskontext:

```
GET [base]/Provenance
  ?reason=http://terminology.hl7.org/CodeSystem/v3-ActReason|HPAYMT
  &patient=Patient/pat-mi-001,Patient/pat-mi-002,...
  &_include=Provenance:target
```

→ liefert Provenance + alle referenzierten Ressourcen (Encounter, Nebendiagnosen, Prozeduren). Über den Standard-Suchparameter `patient` bleibt die Kohorte eingeschränkt.

Ergebnis: ein FHIR Bundle pro Patient:in mit Patient, Encounter, Conditions (HD + ND), Procedure — alle nachweislich aus DRG-aufbereiteter Routinedatenstrecke (vgl. das hier modellierte Beispiel-Bundle [`bundle-abrechnungskontext-mi-001`](Bundle-bundle-abrechnungskontext-mi-001.html)).

##### Caveats für beide Varianten

- **Chained Reverse-Search** (`_has:Provenance:target:reason=...`) wird nicht von allen FHIR-Servern unterstützt. Fallback: erst Provenance-Liste über Variante A holen, dann clientseitig joinen.
- **Bias-Vermeidung**: Wenn die Forschungsfrage den DRG-Codierungs-Bias *vermeiden* will (z. B. tatsächliche Krankheits-Prävalenz ohne PCCL-Anreize), dieselbe Logik mit `reason:not=HPAYMT` und ggf. zusätzlich Filter auf NLP-/Versorgungs-Provenance.
- **Pseudonymisierung & Berechtigungen** laufen auf der DIZ-Seite vor der Auslieferung — die Queries hier sind die fachliche Vorlage, nicht die produktive 1:1-Implementierung.

#### Server-Support für `provenance-reason`

Da `Provenance.reason` in FHIR R4 keinen Standard-Suchparameter hat, muss der hier definierte [`provenance-reason`](SearchParameter-mii-sp-provenance-reason.html) auf dem Ziel-Server **registriert und indiziert** werden, bevor die obigen Queries funktionieren.

**Registrier-Workflow (servertyp-übergreifend):**

```
PUT [base]/SearchParameter/mii-sp-provenance-reason
Content-Type: application/fhir+json

{ ...generierte SearchParameter-Ressource aus diesem IG... }
```

Anschließend ein Reindex-Trigger, damit bestehende Provenance-Ressourcen den neuen Index aufbauen — Aufruf hängt vom Servertyp ab (siehe unten).

**Einschätzung für gängige FHIR-Server in MII-DIZen:**

| Server | Custom SearchParameter | `_has` Reverse Chain | Hinweise |
|---|---|---|---|
| **HAPI FHIR** | ✅ | ✅ | SearchParameter wird mit `status = active` ausgeliefert und ist nach `PUT` direkt indexierbar; anschließend `POST [base]/$reindex` aufrufen. Reverse Chain `_has` produktionsreif. |
| **SMILE CDR** | ✅ | ✅ | Wie HAPI, plus UI-gestützte SP-Verwaltung und automatisches Reindexing einstellbar. |
| **Blaze** | ✅ | ✅ | SearchParameter wird beim PUT indiziert (RocksDB). Verschachtelte Queries (`_has:Provenance:target:reason=...`) vor produktiver Nutzung explizit testen — falls problematisch, Variante A (Provenance-Liste mit `_include:target`) als Fallback nutzen, beides liefert dasselbe Ergebnis. |

**Empfehlung:** In jedem DIZ vor produktiver Nutzung einen kleinen Smoke-Test fahren:

```
# 1. SearchParameter registrieren (PUT s.o.)
# 2. Reindex auslösen (servertyp-abhängig)
# 3. Smoke-Test:
GET [base]/Provenance?reason=http://terminology.hl7.org/CodeSystem/v3-ActReason|HPAYMT&_count=1
```

Liefert die Suche die im DIZ vorhandenen Abrechnungs-Provenances, ist die Registrierung erfolgreich. Wenn das Ergebnis leer bleibt, obwohl Provenance-Ressourcen mit `reason=HPAYMT` existieren, ist meist der Reindex noch nicht durchgelaufen.

### Verhältnis zum Meta.tag-Ansatz

Die &#167;21-/&#167;301-Charakterisierung lässt sich auch über `Meta.tag` am Patienten/an den Conditions abbilden — das ist [Ansatz 1 (Taskforce Metadaten)](ansatz-metatag.html). Der Vergleich:

| Aspekt | Meta.tag | Provenance (dieser Ansatz) |
|---|---|---|
| **„Abrechnungskontext"** filterbar? | Ja, über `_tag` | Ja, über `Provenance?reason=HPAYMT` |
| **ETL-Job-Version dokumentiert?** | Nein | Ja, über `agent[author] → Device.version` |
| **Quell-Aufbereitungsstand referenziert?** | Nein | Ja, über `entity.what` |
| **Zeitpunkt des ETL-Laufs?** | Nur über `meta.lastUpdated` (überschreibbar) | Explizit über `recorded` |
| **Fall-Rückverfolgung** (z. B. „welche FHIR-Ressourcen aus diesem KIS-Stand?") | Nein | Ja, über `entity.what.identifier` |
| **Zusätzliche Ressourcen?** | Keine | 1 Provenance pro ETL-Lauf, 1 DocumentReference, 1 Device |

Provenance ist der reichhaltigere Ansatz — zum Preis einer zusätzlichen Ressource pro ETL-Lauf. Beide Ansätze schließen sich nicht aus.

### Offene Punkte

- **SearchParameter-Lücke in R4:** FHIR R4 definiert keinen Standard-Suchparameter für `Provenance.reason` oder `Provenance.policy`. Dieses IG schließt die `reason`-Lücke mit [`provenance-reason`](SearchParameter-mii-sp-provenance-reason.html). Ein analoger SearchParameter für `policy` ist denkbar, wenn die Filterung nach KHEntgG- vs. SGB-V-Aufbereitung relevant wird.
- **Quellsystem-Klassifikation:** Das CodeSystem [`mii-cs-datenquellsystem`](CodeSystem-mii-cs-datenquellsystem.html) ist hierarchisch (Top-Level: Primär-/Sekundärsystem, darunter konkrete Typen wie KIS, Abrechnungssystem, DRG-Grouper, DWH, ...). Im Beispiel wird bewusst nur das Top-Level (`#Sekundaersystem`) verwendet; die Children sind im CodeSystem vorgehalten. Stand 2026 existiert kein international etablierter CS für Datenquellsystem-Typen — das CodeSystem ist ein MII-Vorschlag und kandidiert zur Übernahme in MII-weite Terminologie.
- **Granularität der Provenance:** Ist die Provenance fall-basiert oder pipeline-lauf-basiert? Im Beispiel: **beides gleichzeitig** — `target[]` umfasst alle FHIR-Ressourcen *eines Falles*, `recorded` markiert *einen ETL-Lauf*. Bei wiederholten Pipeline-Läufen (Bug-Fix, Re-Codierung, Pipeline-Update) entstehen **zusätzliche Provenance-Ressourcen** (append-only) — die Historie bleibt damit nachvollziehbar.
- **Granularität:** Eine Provenance über alle Ressourcen (wie hier) vs. eine pro Ressource. Die hier gezeigte Variante ist pragmatisch; bei feinerer Differenzierung (z. B. Codierfachkraft vs. ETL-Job) lohnen sich getrennte Provenance-Instanzen.
- **CodeSystem für Quell-Aufbereitungsstände:** Der `DocumentReference.identifier.system` ist hier ein Platzhalter (`https://example.org/...`). Für produktiven Einsatz sollte ein MII-weites Namensschema diskutiert werden.
- **`policy` als Mehrfach-Verweis:** Die Beispiel-Provenance referenziert &#167;21 *und* &#167;301, weil beide aus demselben Aufbereitungsstand entstehen. Alternativ könnte eine eigene URL „DRG-Aufbereitung allgemein" als Ankerpunkt dienen.
- **`reason` HPAYMT vs. HLEGAL:** &#167;21 ist primär Pflicht-/Kalkulations-Datensatz, formal eher `HLEGAL`. Die DIZ-FHIR-Daten dienen aber Sekundärnutzung — die Abrechnungs-Charakteristik ist hier das relevante Signal, daher `HPAYMT`.
- **Verhältnis zur DRG-Klassifikation:** Der G-DRG-Grouper gehört nicht in die Patient-Provenance, sondern an die `Encounter.hospitalization` bzw. an eine eigene Klassifikations-Provenance. Diese Seite blendet das aus, um die Hauptaussage scharf zu halten.
- **OpenLineage / W3C PROV-O:** Wenn der ETL-Stack ohnehin OpenLineage-Events emittiert, kann `Provenance.entity.what` auf das Lineage-Event referenzieren, statt Inhalte parallel in FHIR nachzubauen.
