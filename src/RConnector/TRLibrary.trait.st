"
A TRLibrary is a trait defining the name of the external library.

"
Trait {
	#name : #TRLibrary,
	#category : #'RConnector-Core'
}

{ #category : #'library path' }
TRLibrary classSide >> nbLibraryNameOrHandle [
 ^ #R
]

{ #category : #'library path' }
TRLibrary >> nbLibraryNameOrHandle [
 ^ self class nbLibraryNameOrHandle
]
