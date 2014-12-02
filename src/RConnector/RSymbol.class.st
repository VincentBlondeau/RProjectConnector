"
A RSymbol is a representation of a symbol in R. The only way to create an instance is to use newFromSymbol:. There is no allocation or reallocation of this class. The instance cannot be modified.

For now is just a stub to create and recognize that is it a symbol.
"
Class {
	#name : #RSymbol,
	#superclass : #RObject,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RSymbol class >> newFromSymbol: aSymbol [
	^ (self prim_install: aSymbol)
]

{ #category : #'as yet unclassified' }
RSymbol class >> primNew: size type: type [
 	Error signal: 'Cant be allocated !'
]

{ #category : #'as yet unclassified' }
RSymbol class >> type [
	^ SYMSXP
]
