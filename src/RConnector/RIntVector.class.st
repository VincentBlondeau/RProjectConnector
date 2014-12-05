"
A RIntVector is a RVector representing integers.
.

"
Class {
	#name : #RIntVector,
	#superclass : #RVector,
	#category : #'RConnector-Core'
}

{ #category : #private }
RIntVector class >> arrayType [
	^ NBExternalArray ofType: 'int'
]

{ #category : #accessing }
RIntVector class >> firstPointer [
	^ #int
]

{ #category : #'private - instance creation' }
RIntVector class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RIntVector Rf_allocVector (int type, int size))
]

{ #category : #accessing }
RIntVector class >> type [
	^ INTSXP
]

{ #category : #accessing }
RIntVector >> firstPointer [
	^ self int
]
