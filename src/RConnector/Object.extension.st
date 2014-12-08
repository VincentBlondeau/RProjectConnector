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
Object >> nbGetGlobalVariable: variableName [
	^ self nbGetGlobalVariable: variableName module: self nbLibraryNameOrHandle
]

{ #category : #'*RConnector' }
Object >> nbGetGlobalVariable: variableName module: aModule [
	| pointerOfTheSymbol |
	pointerOfTheSymbol := self nbGetSymbolAddress: variableName module: aModule.
	^ self dereferencePointer: pointerOfTheSymbol
]
