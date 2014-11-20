Trait {
	#name : #TRConverters,
	#traits : 'TRLibrary',
	#classTraits : 'TRLibrary classTrait',
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
TRConverters classSide >> nbLibraryNameOrHandle [
 ^ #R
]

{ #category : #'as yet unclassified' }
TRConverters >> asRList [
	^ RList newFromRObject: self
]

{ #category : #'as yet unclassified' }
TRConverters >> nbLibraryNameOrHandle [
 ^ self class nbLibraryNameOrHandle
]
