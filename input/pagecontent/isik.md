ISiK (Informationstechnische Systeme im Krankenhaus) ist ein von der gematik entwickelter, verbindlicher Standard für den Datenaustausch innerhalb von Krankenhäusern auf Basis von HL7 FHIR R4. Die aktuelle Stufe 5 enthält Festlegungen zur Kennzeichnung der Datenherkunft, die konzeptionell mit dem Meta.tag-Ansatz der Taskforce Metadaten übereinstimmen.

### Kennzeichnung von Fremdübernahmen in ISiK

Das ISiK-Basismodul definiert Anforderungen zur Kennzeichnung von Ressourcen, die nicht vom bestätigungsrelevanten System selbst erzeugt wurden. Die Festlegungen finden sich in den übergreifenden Festlegungen zur REST-API.

#### Anforderungen

| Anforderung | Verbindlichkeit |
|-------------|-----------------|
| Eine nicht vom bestätigungsrelevanten System angelegte Ressource KANN in `Resource.meta.tag` angeben, dass sie durch ein Fremdsystem erzeugt wurde | KANN |
| Die Auszeichnung von Fremdübernahmen SOLL über den Code `external` aus dem Kodiersystem `https://fhir.de/CodeSystem/common-meta-tag-de` erfolgen | SOLL |
| Der Server KANN den Tag hinzufügen, wenn der Client diese Angabe nicht selbst übermittelt | KANN |
| Bei dauerhafter Übernahme KANN der Tag entfernt werden; die Ressourcen-ID MUSS stabil bleiben | KANN / MUSS |

#### Beispiel

```json
{
  "resourceType": "Patient",
  "meta": {
    "tag": [
      {
        "system": "https://fhir.de/CodeSystem/common-meta-tag-de",
        "code": "external"
      }
    ]
  }
}
```

#### Weitere Differenzierung über Meta.security

ISiK sieht eine optionale Differenzierung der Herkunft über `Resource.meta.security` vor. Hierzu KÖNNEN Codes aus dem ValueSet [SecurityIntegrityObservationValue](https://terminology.hl7.org/ValueSet/v3-SecurityIntegrityObservationValue) verwendet werden. Dieses HL7-v3-ValueSet enthält u.a. Codes zur Beschreibung der Integrität und Vertrauenswürdigkeit von Daten.

### Einordnung im Kontext dieses Leitfadens

ISiK und die MII Taskforce Metadaten nutzen denselben technischen Mechanismus (`Resource.meta.tag`), adressieren aber unterschiedliche Granularitätsstufen:

| Aspekt | ISiK | Taskforce Metadaten |
|--------|------|---------------------|
| **Scope** | Binäre Aussage: eigenes System vs. Fremdsystem | Differenzierte Aussagen über Erhebungskontext, Qualität, Quellsystem u.v.m. |
| **Vokabular** | 1 Code (`external`) aus `common-meta-tag-de` | Mehrere Vokabulare mit jeweils mehreren Codes |
| **Verbindlichkeit** | SOLL (bei Kennzeichnung) | Keine Pflichtfelder in v1.0 |
| **Zielgruppe** | Krankenhausinterne Systeme | Forschungsdateninfrastruktur (DIZ, FDPG) |

Die Ansätze sind **komplementär**: ISiK markiert, *ob* eine Ressource extern stammt; die Taskforce-Vokabulare beschreiben *woher*, *wie* und *in welcher Qualität*.

### Implikation für DIZ-Implementierungen

Da viele DIZ sowohl ISiK-konforme Schnittstellen als auch MII-KDS-Exporte bedienen, ergibt sich eine natürliche Brücke: Eine Ressource, die über eine ISiK-Schnittstelle mit dem Tag `external` übernommen wird, kann im DIZ um weitere Taskforce-Tags (Datenerhebungskontext, Datenquellsystem, etc.) angereichert und anschließend über das FDPG bereitgestellt werden.

*Quelle: [ISiK Basismodul Stufe 5 -- Übergreifende Festlegungen REST-API](https://simplifier.net/guide/isik-basis-stufe-5/Einfuehrung/Festlegungen/UebergreifendeFestlegungen_Rest?version=5.1.1)*
