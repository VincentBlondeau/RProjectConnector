Extension { #name : #String }

{ #category : #'*RConnector' }
String >> asRChar [
	^ RChar primNew: self
]

{ #category : #'*RConnector' }
String >> asREval: aCollection [
	"Can be used to eval anything"
	^ self asRListEval: aCollection
]

{ #category : #'*RConnector' }
String >> asRFunctionEval: aCollection [
	^ RFunction eval: self asString withParameters: aCollection
]

{ #category : #'*RConnector' }
String >> asRListEval: aKindOfList [
	^ RFunction eval: self asString withListParameter: aKindOfList
]
