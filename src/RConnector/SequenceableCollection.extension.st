Extension { #name : #SequenceableCollection }

{ #category : #'*RConnector' }
SequenceableCollection >> asRIntVector [
	^ RIntVector newFrom: self 
]
