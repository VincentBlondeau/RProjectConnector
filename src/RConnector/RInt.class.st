"
A RInt class is the representation of a scalar int under R. This type is automaticaly used when Smalltalk Integer are passed in parameters of a function.

"
Class {
	#name : #RInt,
	#superclass : #RObject,
	#category : #'RConnector-Core'
}

{ #category : #'instance creation' }
RInt class >> newFrom: aInt [
	
	^ self ffiCall: #(SEXP	 Rf_ScalarInteger(int aInt))
]
