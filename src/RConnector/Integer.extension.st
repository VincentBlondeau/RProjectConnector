Extension { #name : #Integer }

{ #category : #'*RConnector' }
Integer >> asPureRObject [
	^ self asRObject asPureRObject
]

{ #category : #'*RConnector' }
Integer >> asRObject [
	^ RInt newFrom: self
]
