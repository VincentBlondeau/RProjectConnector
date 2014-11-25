Extension { #name : #Integer }

{ #category : #'*RConnector' }
Integer >> asRObject [
	^ RInt newFrom: self
]
