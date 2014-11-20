Class {
	#name : #RInt,
	#superclass : #RObject,
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
RInt class >> newFrom: aInt [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP	 Rf_ScalarInteger(int aInt))
]
