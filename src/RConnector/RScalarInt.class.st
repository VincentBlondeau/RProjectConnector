Class {
	#name : #RScalarInt,
	#superclass : #RObject,
	#traits : 'TRLibrary',
	#classTraits : 'TRLibrary classTrait',
	#pools : [
		'RLibTypes'
	],
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
RScalarInt class >> newFrom: aInt [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP	 Rf_ScalarInteger(int aInt))
]
