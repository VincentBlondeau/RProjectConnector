Extension { #name : #Integer }

{ #category : #'*RConnector' }
Integer >> asRInt [
	^ RInt newFrom: self
]
