Class {
	#name : #RIntVector,
	#superclass : #RVector,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RIntVector class >> arrayType [
	^ NBExternalArray ofType: 'int'
]

{ #category : #'as yet unclassified' }
RIntVector class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RIntVector Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RIntVector class >> type [
	^ INTSXP
]

{ #category : #'as yet unclassified' }
RIntVector >> array [
	^ array ifNil: [ array := (NBExternalArray ofType: 'int') onAddress: (NBExternalAddress value: self int) size: self length ]
]
