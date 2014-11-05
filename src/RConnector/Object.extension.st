Extension { #name : #Object }

{ #category : #'*RConnector' }
Object >> nbGetGlobalVariable: variableName [
	^ self nbGetGlobalVariable: variableName module: self nbLibraryNameOrHandle
]

{ #category : #'*RConnector' }
Object >> nbGetGlobalVariable: variableName module: aModule [
	| pointerOfTheSymbol pointerToTheValueOfTheSymbol |
	pointerOfTheSymbol := self nbGetSymbolAddress: variableName module: aModule.
	pointerToTheValueOfTheSymbol := NBExternalAddress null.
	pointerToTheValueOfTheSymbol value: pointerOfTheSymbol value.
	^ pointerToTheValueOfTheSymbol ulongAt: 0
]
