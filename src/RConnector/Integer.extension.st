Extension { #name : #Integer }

{ #category : #'*RConnector' }
Integer >> asRObject [
	^ RInt newFrom: self
]

{ #category : #'*RConnector' }
Integer >> indexKeyToRList: aRList [
	^ aRList atIndex: self 
]
