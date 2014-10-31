Trait {
	#name : #TRLibrary,
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
TRLibrary classSide >> nbLibraryNameOrHandle [
 ^ #R
]

{ #category : #'as yet unclassified' }
TRLibrary >> nbLibraryNameOrHandle [
 ^ self class nbLibraryNameOrHandle
]
