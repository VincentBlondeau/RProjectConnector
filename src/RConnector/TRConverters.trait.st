Trait {
	#name : #TRConverters,
	#traits : 'TRLibrary',
	#classTraits : 'TRLibrary classTrait',
	#category : #'RConnector-Core'
}

{ #category : #'library path' }
TRConverters classSide >> nbLibraryNameOrHandle [
 ^ #R
]

{ #category : #'as yet unclassified' }
TRConverters >> asRList [
	^ RList newFromRObject: self
]

{ #category : #'library path' }
TRConverters >> nbLibraryNameOrHandle [
 ^ self class nbLibraryNameOrHandle
]
