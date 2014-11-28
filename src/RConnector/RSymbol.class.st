Class {
	#name : #RSymbol,
	#superclass : #RObject,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RSymbol class >> primNew: size type: type [
 	Error signal: 'Cant be allocated !'
]

{ #category : #'as yet unclassified' }
RSymbol class >> type [
	^ SYMSXP
]
