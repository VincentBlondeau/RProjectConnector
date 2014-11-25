Class {
	#name : #RDoubleVector,
	#superclass : #RVector,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RDoubleVector class >> arrayType [
	^ NBExternalArray ofType: 'double'
]

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
RDoubleVector >> firstPointer [
	^ self real
]
