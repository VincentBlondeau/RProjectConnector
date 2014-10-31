Class {
	#name : #NBXRSEXP,
	#superclass : #NBExternalObject,
	#traits : 'TRLibrary',
	#classTraits : 'TRLibrary classTrait',
	#pools : [
		'RLibTypes'
	],
	#classInstVars : [
		'par'
	],
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
NBXRSEXP class >> Rf_install: aChar [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(const char * aChar))
]
