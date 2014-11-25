Class {
	#name : #RDoubleVector,
	#superclass : #RVector,
	#instVars : [
		'array'
	],
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RDoubleVector class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RDoubleVector Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RDoubleVector class >> type [
	^ REALSXP
]

{ #category : #'as yet unclassified' }
RDoubleVector >> array [
	array := (NBExternalArray ofType: 'double') onAddress: (NBExternalAddress value: self real) size: self length
]
