Extension { #name : #String }

{ #category : #'*RConnector' }
String >> asRChar [
	^ RChar primNew: self
]

{ #category : #'*RConnector' }
String >> asRFunctionWith: aCollection [ 
	^ RFunction functionName: self asString parameters: aCollection.
]

{ #category : #'*RConnector' }
String >> asRObject [
	^ RStringVector primNewFromString: self
]

{ #category : #'*RConnector' }
String >> indexKeyToRList: aRList [
	^ aRList atKey: self 
]
