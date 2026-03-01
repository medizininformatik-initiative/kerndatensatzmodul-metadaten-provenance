CodeSystem: DQ_Rule_Successful
Id:         dq-rule-successful
* ^url =  "http://mii.de/CodeSystem/dq-rule-successful"
* ^property.code = #rule-type
* ^property.description = "Typ der Regel."
* ^property.type = #code
* ^property.code = #comperator
* ^property.description = "Wert von referenzierten Items bei konditionalen Regeln."
* ^property.type = #Coding
* ^property.code = #value
* ^property.description = "Wert von referenzierten Items bei konditionalen Regeln."
* ^property.type = #string
* ^property.code = #min
* ^property.description = "Minimalwert für Vergleichsoperationen."
* ^property.type = #decimal
* ^property.code = #max
* ^property.description = "Maximalwert für Vergleichsoperationen."
* ^property.type = #decimal
// Braucht man nicht wegen "display"
* ^property.code = #error-message
* ^property.description = "Fehlermeldung im Fall des Anschlagens der Regel."
* ^property.type = #string

* #OP-1 "Surgery has to be after admission."
* #OP-1 ^property[0].code = #rule-type
* #OP-1 ^property[=].valueCode = #after
* #OP-1 ^property[+].code = #comperator
* #OP-1 ^property[=].valueCoding = http://trial.info/dq#Admission

* #OP-2 "Surgery appointment is required."
* #OP-2 ^property[0].code = #rule-type
* #OP-2 ^property[=].valueCode = #required

* #Discharge-1 "Discharge has to be at least 2 days after surgery."
* #Discharge-1 ^property[0].code = #rule-type
* #Discharge-1 ^property[=].valueCode = #after
* #Discharge-1 ^property[+].code = #comperator
* #Discharge-1 ^property[=].valueCoding = http://trial.info/dq#OP
* #Discharge-1 ^property[+].code = #min
* #Discharge-1 ^property[=].valueDecimal = 2

* #DosisMedic-1 "Dosis of medication is a required item."
* #DosisMedic-1 ^property[0].code = #rule-type
* #DosisMedic-1 ^property[=].valueCode = #required
* #DosisMedic-1 ^property[+].code = #comperator
* #DosisMedic-1 ^property[=].valueCoding = http://trial.info/dq#Medication
* #DosisMedic-1 ^property[+].code = #value
* #DosisMedic-1 ^property[=].valueString = "eq 1"

* #DosisMedic-2 "Dosis of medication has to be between 50 and 250 mmol."
* #DosisMedic-2 ^property[0].code = #rule-type
* #DosisMedic-2 ^property[=].valueCode = #range
* #DosisMedic-2 ^property[+].code = #comperator
* #DosisMedic-2 ^property[=].valueCoding = http://trial.info/dq#UnitMedication
* #DosisMedic-2 ^property[+].code = #value
* #DosisMedic-2 ^property[=].valueString = "mmol"
* #DosisMedic-2 ^property[+].code = #min
* #DosisMedic-2 ^property[=].valueDecimal = 50
* #DosisMedic-2 ^property[+].code = #max
* #DosisMedic-2 ^property[=].valueDecimal = 250


// Sollte später auf ein ValueSet verweisen
Instance: dq-test-1
InstanceOf: Observation
* status = #final
* code.text = "Drug dose"
* code.coding = http://purl.bioontology.org/ontology/SNOMEDCT/#398232005
* valueQuantity.value = 90
* valueQuantity.unit = "mmol"
* subject = Reference(mighty-m)
* meta.tag[0] = DQ_Rule_Successful#DosisMedic-1
* meta.tag[+] = DQ_Rule_Successful#DosisMedic-2

Instance: mighty-m
InstanceOf: Patient
Description: "Example of Patient"
* name.family = "M"
* name.given[0] = "Mighty"
* gender = #male
* birthDate = "1982-02-05"
