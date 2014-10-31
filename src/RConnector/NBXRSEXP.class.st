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
NBXRSEXP class >> Rf_endEmbeddedR [
	^ self Rf_endEmbeddedR: 0
]

{ #category : #'as yet unclassified' }
NBXRSEXP class >> Rf_endEmbeddedR: arg [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int  Rf_endEmbeddedR( int arg ))
]

{ #category : #'as yet unclassified' }
NBXRSEXP class >> Rf_initEmbeddedR: params [
	| strings |
	^ [ 
	"This is 32bit... too bad..."
	strings := OrderedCollection new.
	par := NativeBoost allocate: 4 * params size.
	params
		keysAndValuesDo: [ :i :each | 
			| str |
			str := each asNBExternalString.
			strings add: str.
			par nbUInt32AtOffset: (i - 1) * 4 put: str value ].
	self Rf_initEmbeddedRargc: params size argv: par ]
		ensure: [ 
			"Free the memory we allocated"
			par ifNotNil: [ par free ].
			strings ifNotNil: [ strings do: [ :each | each free ] ] ]
]

{ #category : #'as yet unclassified' }
NBXRSEXP class >> Rf_initEmbeddedRargc: argc argv: argv [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_initEmbeddedR(int argc, char *argv))
]

{ #category : #'as yet unclassified' }
NBXRSEXP class >> Rf_install: aChar [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(const char * aChar))
]
