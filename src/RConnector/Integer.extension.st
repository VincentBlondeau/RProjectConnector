Extension { #name : #Integer }

{ #category : #'*RConnector' }
Integer >> asRScalarInt [
	^ RScalarInt newFrom: self
]
