"
I stores metadata on true and false positive critics. These meta data are used by the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestRConnector,
	#superclass : #Object,
	#category : #RConnector
}

{ #category : #'meta data' }
ManifestRConnector class >> rejectClasses [
^ #()
]

{ #category : #'meta data' }
ManifestRConnector class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestRConnector class >> ruleClassNotReferencedRuleV1FalsePositive [
^ #()
]

{ #category : #'meta data' }
ManifestRConnector class >> ruleExcessiveVariablesRuleV1FalsePositive [
^ #(#(#(#RGClassDefinition #(#RLibTypes)) #'2014-12-05T15:32:37.504912+01:00') )
]

{ #category : #'meta data' }
ManifestRConnector class >> ruleInconsistentMethodClassificationRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#RNilValue #asRObject #false)) #'2014-12-05T15:32:37.534912+01:00') )
]

{ #category : #'meta data' }
ManifestRConnector class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#'RSession class' #initEmbeddedR: #true)) #'2014-12-05T15:32:37.567912+01:00') )
]
