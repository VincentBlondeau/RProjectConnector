Trait {
	#name : #TRConverters,
	#traits : 'TRLibrary',
	#classTraits : 'TRLibrary classTrait',
	#category : #'RConnector-Core'
}

{ #category : #'trait - converting' }
TRConverters >> asRList [
	^ RList newFromRObject: self
]
