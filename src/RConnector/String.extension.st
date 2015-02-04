Extension { #name : #String }

{ #category : #'*RConnector' }
String >> asRChar [
	^ RChar primNew: self
]

{ #category : #'*RConnector' }
String >> asRFunctionEval: aCollection [
	^ RFunction eval: self asString withParameters: aCollection
]

{ #category : #'*RConnector' }
String >> asRFunctionWith: aCollection [ 
	^ RFunction functionName: self asString parameters: aCollection.
]

{ #category : #'*RConnector' }
String >> asRListEval: aKindOfList [
	^ RFunction eval: self asString withListParameter: aKindOfList
]

{ #category : #'*RConnector' }
String >> asRObject [
	^ RStringVector newFromString: self
]

{ #category : #'*RConnector' }
String >> indexKeyToRList: aRList [
	^ aRList atKey: self 
]
