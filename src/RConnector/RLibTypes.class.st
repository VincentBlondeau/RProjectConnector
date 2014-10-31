Class {
	#name : #RLibTypes,
	#superclass : #SharedPool,
	#classVars : [
		'SEXP'
	],
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
RLibTypes class >> initialize [
	SEXP := #NBXRSEXP
]
