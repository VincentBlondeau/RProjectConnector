Extension { #name : #SequenceableCollection }

{ #category : #'*RConnector' }
SequenceableCollection >> asRObject [
	self first isInteger ifTrue: [ ^ RIntVector newFrom: self  ].
	self first isFloat ifTrue: [ ^ RDoubleVector newFrom: self ].
]
