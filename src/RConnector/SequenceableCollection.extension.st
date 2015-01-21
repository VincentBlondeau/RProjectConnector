Extension { #name : #SequenceableCollection }

{ #category : #'*RConnector' }
SequenceableCollection >> asRObject [
	(self anySatisfy: #isFloat)
		ifTrue: [ ^ RDoubleVector newFrom: self ].
	(self anySatisfy: #isInteger)
		ifTrue: [ ^ RIntVector newFrom: self ].
	^ CannotBeConvertedToType signal
]
