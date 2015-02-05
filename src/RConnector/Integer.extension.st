Extension { #name : #Integer }

{ #category : #'*RConnector' }
Integer >> of: aRList put: aValue [
	^ aRList atIndex: self put: aValue
]
