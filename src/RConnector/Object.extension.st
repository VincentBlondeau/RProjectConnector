Extension { #name : #Object }

{ #category : #'*RConnector' }
Object >> asDereferencedPointer [
	|  pointerToTheValueOfThePointer handle |
	pointerToTheValueOfThePointer := NBExternalAddress null.
	handle := [self handle] onDNU: #handle do: [ self value ].
	pointerToTheValueOfThePointer value: handle.
	^ pointerToTheValueOfThePointer ulongAt: 0
]

{ #category : #'*RConnector' }
Object >> asPureRObject [
	^ self asRObject asPureRObject
]

{ #category : #'*RConnector' }
Object >> dereferencePointer: aNbPointer [
	|  pointerToTheValueOfThePointer handle |
	pointerToTheValueOfThePointer := NBExternalAddress null.
	handle := [aNbPointer handle] onDNU: #handle do: [ aNbPointer value ].
	pointerToTheValueOfThePointer value: handle.
	^ pointerToTheValueOfThePointer ulongAt: 0
]

{ #category : #'*RConnector' }
Object >> ffiGetGlobalVariable: variableName [
	^ self ffiGetGlobalVariable: variableName module: self nbLibraryNameOrHandle
]

{ #category : #'*RConnector' }
Object >> ffiGetGlobalVariable: variableName module: aModule [
	^ (ExternalAddress loadSymbol: variableName module: aModule)
		unpackFromArity: 2
]
