Extension { #name : #String }

{ #category : #'*RConnector' }
String >> asRFunctionWith: aCollection [ 
	^ RFunction functionName: self asString parameters: aCollection.
]

{ #category : #'*RConnector' }
String >> asRObject [
	^ RChar primNew: self
]
