### Gegenüberstellung der Ansätze

| Kriterium | Meta.tag (Taskforce) | FHIR Provenance (BZKF) |
|-----------|---------------------|----------------------|
| **FHIR-Mechanismus** | `Resource.meta.tag` | Eigene `Provenance`-Ressource |
| **Komplexität** | Minimal (1 Zeile pro Aussage) | Mittel (eigene Ressource mit Referenzen) |
| **Implementierungsaufwand** | Gering (bestehende ETL ergänzbar) | Mittel (Mapper-Anpassung) |
| **Ressourcen-Overhead** | Kein (inline in bestehenden Ressourcen) | Ja (zusätzliche Ressourcen) |
| **Aussagekraft** | Einfache Annotationen | Komplexe Beziehungen (Agent, Entity, Target) |
| **Mehrere Entitäten** | Nicht möglich | Ja |
| **Internationale Interoperabilität** | Eingeschränkt | W3C PROV-kompatibel |
| **Standard-Terminologien** | Eigene MII-Vokabulare | HL7-Vokabulare (v3-DataOperation, etc.) |
| **Pflichtfelder** | Keine (v1.0) | Strukturell durch Profil definierbar |
| **Bestehende IGs** | Bleiben unverändert gültig | Keine Auswirkung (additiv) |
| **Datenausleitung** | Keine zusätzlichen Abhängigkeiten | Abhängige Ressourcen müssen beachtet werden |

### Anwendungsbereiche

Die beiden Ansätze sind **nicht gegensätzlich, sondern komplementär**:

#### Meta.tag eignet sich besonders für:

- Einfache, kategorische Aussagen (Datenerhebungskontext, Qualitätsstufe, Validierungsergebnis)
- Breite Anwendung über alle Ressourcentypen hinweg
- Schnelle Implementierung ohne Änderung der Datenmodelle
- Situationen, in denen kein Agent oder keine Aktivität dokumentiert werden muss

#### FHIR Provenance eignet sich besonders für:

- Dokumentation von Transformationsprozessen (ETL)
- Nachvollziehbarkeit der Datenherkunft mit konkreten Quellverweisen
- Deduplizierungsszenarien (welche Quellressourcen wurden zusammengeführt?)
- Situationen, in denen Agent, Aktivität und Quellentität dokumentiert werden müssen

### Empfehlung

Die Taskforce Metadaten empfiehlt den Meta.tag-Ansatz als pragmatischen Einstieg und benennt FHIR Provenance explizit als möglichen Erweiterungspfad. Eine kombinierte Nutzung beider Ansätze ist technisch möglich und kann je nach Anwendungsfall sinnvoll sein.

### Offene Fragen

- Welche Pflichtauszeichnungen sollen in v2.0 des Taskforce-Konzepts gelten?
- Wie wird mit der Deduplizierungsproblematik (insbesondere beim oBDS-Reimport) umgegangen?
- Soll eine MII-weite Profilierung der FHIR Provenance Ressource erfolgen?
- Wie verhalten sich die Ansätze bei der Datenausleitung über das FDPG?

### Nächste Schritte

- Auswertung von Pilotimplementierungen
- Erarbeitung konkreter Anwendungsbeispiele (z.B. Onkologie-Prozeduren)
- Abstimmung innerhalb der MII-Gremien
