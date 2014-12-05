"
A RBoolVector is a RVector representing booleans


"
Class {
	#name : #RBoolVector,
	#superclass : #RVector,
	#category : #'RConnector-Core'
}

{ #category : #accessing }
RBoolVector class >> arrayType [
	^ NBExternalArray ofType: 'bool'
]

{ #category : #accessing }
RBoolVector class >> firstPointer [
	^ #logical
]

{ #category : #'private - instance creation' }
RBoolVector class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RBoolVector Rf_allocVector (int type, int size))
]

{ #category : #accessing }
RBoolVector class >> type [
	^ LGLSXP
]

{ #category : #accessing }
RBoolVector >> firstPointer [
	^ self logical
]
