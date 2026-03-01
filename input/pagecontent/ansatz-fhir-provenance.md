### Konzept

Die BZKF-Implementierung [obds-to-fhir](https://github.com/bzkf/obds-to-fhir) (Christian Gulden, BZKF/Erlangen) nutzt die FHIR Provenance Ressource zur Dokumentation der ETL-Transformation von oBDS-XML-Meldungen zu MII-KDS-konformen FHIR-Ressourcen. Für jede erzeugte Ressource wird eine Provenance-Instanz generiert, die den Transformationsprozess nachvollziehbar macht.

### Implementierungsbeispiel

Das folgende Beispiel stammt aus dem [ProvenanceMapperTest](https://github.com/bzkf/obds-to-fhir/blob/8213b51f/mappings/src/test/java/snapshots/io/github/bzkf/obdstofhir/mapper/mii/ProvenanceMapperTest.map_withGivenResources_shouldCreateValidProvenanceResource.approved.fhir.json) der obds-to-fhir ETL-Strecke:

```json
{
  "resourceType": "Provenance",
  "id": "715fbde8...",
  "target": [
    { "reference": "Condition/any" }
  ],
  "occurredDateTime": "2000-01-01T11:11:11Z",
  "recorded": "2000-01-01T11:11:11Z",
  "activity": {
    "coding": [
      {
        "system": "http://terminology.hl7.org/CodeSystem/v3-DataOperation",
        "code": "CREATE",
        "display": "create"
      }
    ]
  },
  "agent": [
    {
      "type": {
        "coding": [
          {
            "system": "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
            "code": "assembler",
            "display": "Assembler"
          }
        ]
      },
      "role": [
        {
          "coding": [
            {
              "system": "http://terminology.hl7.org/CodeSystem/v3-ParticipationType",
              "code": "AUT",
              "display": "author"
            }
          ]
        }
      ],
      "who": {
        "identifier": {
          "system": "https://bzkf.github.io/obds-to-fhir/identifiers/obds-to-fhir-device-id",
          "value": "obds-to-fhir-0.0.0-test"
        }
      }
    }
  ],
  "entity": [
    {
      "role": "source",
      "what": {
        "identifier": {
          "system": "https://bzkf.github.io/obds-to-fhir/identifiers/obds-meldung-id",
          "value": "123"
        }
      }
    }
  ]
}
```

### Elemente im Detail

| Element | Wert | Bedeutung |
|---------|------|-----------|
| `target` | Referenz auf erzeugte Ressource | Die FHIR-Ressource, die durch die Transformation entstanden ist |
| `activity` | `v3-DataOperation#CREATE` | Art der Datenoperation (CREATE, UPDATE, etc.) |
| `agent.type` | `provenance-participant-type#assembler` | Das ETL-Tool hat die Ressource zusammengesetzt |
| `agent.role` | `v3-ParticipationType#AUT` | Das Tool ist Autor der FHIR-Repräsentation |
| `agent.who` | Identifier des ETL-Tools | Identifikation über Systemname und Version |
| `entity.role` | `source` | Quelldaten |
| `entity.what` | oBDS-Meldungs-ID | Die ursprüngliche oBDS-Meldung als Identifier (keine FHIR-Referenz) |

### Designentscheidungen

- **Standard-Terminologien**: Nutzung von HL7-Vokabularen (`v3-DataOperation`, `provenance-participant-type`, `v3-ParticipationType`) statt eigener CodeSystems
- **Identifier statt Referenzen**: `entity.what` und `agent.who` nutzen Identifier statt FHIR-Referenzen, da oBDS-Quellmeldungen und das ETL-Tool keine FHIR-Ressourcen auf dem Zielserver sind
- **1:1-Beziehung**: Pro erzeugter FHIR-Ressource wird eine Provenance-Instanz generiert
- **ETL-Fokus**: Die Provenance dokumentiert den Transformationsprozess, nicht die klinische Datenherkunft

### Vorteile

- Nutzung der dafür vorgesehenen FHIR-Ressource
- Internationale Interoperabilität durch W3C PROV-Kompatibilität
- Komplexe Aussagen mit mehreren Entitäten und Agenten möglich
- Vollständige Transformationskette dokumentierbar
- Standardisierte Terminologien für Aktivitäten und Rollen

### Limitierungen

- Erzeugt zusätzliche Ressourcen (Speicher, Performance)
- ETL-Strecke muss angepasst werden
- Abhängige Ressourcen bei Datenausleitung
- Best Practices noch nicht breit etabliert

*Quelle: [bzkf/obds-to-fhir](https://github.com/bzkf/obds-to-fhir), Christian Gulden (BZKF/Erlangen)*
