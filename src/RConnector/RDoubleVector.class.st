"
A RDoubleVector is a RVector representing doubles (not floats).

"
Class {
	#name : #RDoubleVector,
	#superclass : #RVector,
	#category : #'RConnector-Core'
}

{ #category : #private }
RDoubleVector class >> arrayType [
	^ NBExternalArray ofType: 'double'
]

{ #category : #accessing }
RDoubleVector class >> firstPointer [
	^ #real
]

{ #category : #'private - instance creation' }
RDoubleVector class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RDoubleVector Rf_allocVector (int type, int size))
]

{ #category : #accessing }
RDoubleVector class >> type [
	^ REALSXP
]

{ #category : #accessing }
RDoubleVector >> firstPointer [
	^ self real
]
