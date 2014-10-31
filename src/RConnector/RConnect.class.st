Class {
	#name : #RConnect,
	#superclass : #Object,
	#classVars : [
		'RSession'
	],
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
RConnect class >> R_GlobalEnv [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbGetSymbolAddress: #R_GlobalEnv
        module: #R
]

{ #category : #'R session' }
RConnect class >> Rf_endEmbeddedR [
	^ self Rf_endEmbeddedR: 0
]

{ #category : #private }
RConnect class >> Rf_endEmbeddedR: arg [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int  Rf_endEmbeddedR( int arg ))
]

{ #category : #'R session' }
RConnect class >> Rf_initEmbeddedR: params [
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

{ #category : #private }
RConnect class >> Rf_initEmbeddedRargc: argc argv: argv [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_initEmbeddedR(int argc, char *argv))
]

{ #category : #'stats functions' }
RConnect class >> initialize [
	Smalltalk session ~= RSession
		ifTrue: [ 
			RSession := Smalltalk session.
			RLibTypes initialize.
			self Rf_initEmbeddedR: #(#R '--no-save' 'silent').
			]
]

{ #category : #testing }
RConnect class >> isExistsRf_initEmbeddedR [
	^ (self nbGetSymbolAddress: 'Rf_initEmbeddedR' module: #R) isNotNil
]

{ #category : #'stats functions' }
RConnect class >> unif_rand [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #( double unif_rand(void) )
        module: #R
]