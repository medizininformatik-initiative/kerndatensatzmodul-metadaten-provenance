# Greifswald OBC DQ-Framework - MII IG Kerndatensatz-Modul Metadaten Provenance v0.2.0-rc.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Greifswald OBC DQ-Framework**

## CodeSystem: Greifswald OBC DQ-Framework 

| | |
| :--- | :--- |
| *Official URL*:https://www.medizininformatik-initiative.de/fhir/core/modul-meta/CodeSystem/greifswald-obc-dq-framework | *Version*:0.2.0-rc.1 |
| Active as of 2026-07-23 | *Computable Name*:Greifswald_OBC_DQ_Framework |

 
Data Quality Framework by COS. 

 This Code system is referenced in the content logical definition of the following value sets: 

* [Alle_DQ_Indikatoren_VS](ValueSet-primary.md)



## Resource Content

```json
{
  "resourceType" : "CodeSystem",
  "id" : "Greifswald-OBC-DQ-Framework",
  "url" : "https://www.medizininformatik-initiative.de/fhir/core/modul-meta/CodeSystem/greifswald-obc-dq-framework",
  "version" : "0.2.0-rc.1",
  "name" : "Greifswald_OBC_DQ_Framework",
  "title" : "Greifswald OBC DQ-Framework",
  "status" : "active",
  "date" : "2026-07-23T11:57:36+00:00",
  "publisher" : "Medizininformatik Initiative",
  "contact" : [{
    "name" : "Medizininformatik Initiative",
    "telecom" : [{
      "system" : "url",
      "value" : "https://www.medizininformatik-initiative.de/"
    }]
  }],
  "description" : "Data Quality Framework by COS.",
  "caseSensitive" : false,
  "compositional" : false,
  "content" : "complete",
  "count" : 34,
  "concept" : [{
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-1001",
    "display" : "Unexpected data elements",
    "definition" : "The observed set of available data elements does not match the expected set."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-1002",
    "display" : "Unexpected data records",
    "definition" : "The observed set of available data records does not match the expected set."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-1003",
    "display" : "Duplicates",
    "definition" : "The same data elements or data records appear multiple times."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-1004",
    "display" : "Data record mismatch",
    "definition" : "Data records from different data sets do not match as expected."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-1005",
    "display" : "Data element mismatch",
    "definition" : "Data elements from different data sets do not match as expected."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-1006",
    "display" : "Data type mismatch",
    "definition" : "The observed data type does not match the expected data type."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-1007",
    "display" : "Inhomogeneous value formats",
    "definition" : "The observed data values have inhomogeneous format across different data fields."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-1008",
    "display" : "Uncertain missingness status",
    "definition" : "System indicated missing values (e.g. NA/./Null …) appear where a qualified missing code is expected."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-2001",
    "display" : "Missing values",
    "definition" : "Data fields without a measurement value."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-2002",
    "display" : "Non-response rate",
    "definition" : "The proportion of eligible observational units for which no information could be obtained."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-2003",
    "display" : "Refusal rate",
    "definition" : "The proportion of eligible individuals who refuse to give the information sought."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-2004",
    "display" : "Drop-out rate",
    "definition" : "The proportion of all participants who only partially complete the study and prematurely abandon it."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-2005",
    "display" : "Missing due to specified reason",
    "definition" : "Information in a data collection that is missing due to a specified reason."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-3001",
    "display" : "Inadmissible numerical values",
    "definition" : "Observed numerical data values are not admissible according to the allowed ranges."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-3002",
    "display" : "Inadmissible time-date values",
    "definition" : "Observed time-date values are not admissible according to the allowed time and date ranges."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-3003",
    "display" : "Inadmissible categorical values",
    "definition" : "Observed categorical data values are not admissible according to the allowed categories."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-3004",
    "display" : "Inadmissible standardized vocabulary",
    "definition" : "Data values are not admissible according to the reference vocabulary."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-3005",
    "display" : "Inadmissible precision",
    "definition" : "The precision of observed numerical data values does not match the expected precision."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-3006",
    "display" : "Uncertain numerical values",
    "definition" : "Observed numerical values are uncertain or improbable because they are outside the expected ranges."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-3007",
    "display" : "Uncertain time-date values",
    "definition" : "Observed time-date values are uncertain or improbable because they are outside the expected ranges."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-3008",
    "display" : "Logical contradictions",
    "definition" : "Different data values appear in logically impossible combinations."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-3009",
    "display" : "Empirical contradictions",
    "definition" : "Different data values appear in combinations deemed impossible based on empirical reasoning."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4001",
    "display" : "Univariate outliers",
    "definition" : "Numerical data values deviate markedly from others in a univariate analysis."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4002",
    "display" : "Multivariate outliers",
    "definition" : "Numerical data values deviate markedly from others in a multivariate analysis."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4003",
    "display" : "Unexpected locations",
    "definition" : "Observed location parameters differ from expected location parameters."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4004",
    "display" : "Unexpected shape",
    "definition" : "The observed shape of a distribution differs from the expected shape."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4005",
    "display" : "Unexpected scale",
    "definition" : "Observed scale parameters differ from expected scale parameters."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4006",
    "display" : "Unexpected proportions",
    "definition" : "Observed proportions differ from expected proportions."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4007",
    "display" : "Unexpected association strength",
    "definition" : "The observed strength of an association deviates from the expected strength of the association."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4008",
    "display" : "Unexpected association direction",
    "definition" : "The observed direction of an association (e.g. negative, positive) deviates from the expected direction."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4009",
    "display" : "Unexpected association form",
    "definition" : "The observed form of an association (e.g. linear, quadratic, exponential...) deviates from the expected form."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4010",
    "display" : "Inter-Class reliability",
    "definition" : "Differences between classes (e.g. examiners) when measuring the same or similar objects under specified conditions."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4011",
    "display" : "Intra-Class reliability",
    "definition" : "Differences within classes (e.g. examiners) when measuring the same or similar objects under specified conditions."
  },
  {
    "code" : "https://dataquality.qihs.uni-greifswald.de/#DQI-4012",
    "display" : "Disagreement with gold standard",
    "definition" : "Differences with a gold standard when measuring the same or similar objects under specified conditions."
  }]
}

```
