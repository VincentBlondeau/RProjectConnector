Class {
	#name : #RSession,
	#superclass : #Object,
	#traits : 'TRLibrary',
	#classTraits : 'TRLibrary classTrait',
	#classVars : [
		'RSession'
	],
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #private }
RSession class >> Rf_endEmbeddedR [
	^ self Rf_endEmbeddedR: 0
]

{ #category : #private }
RSession class >> Rf_endEmbeddedR: arg [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int  Rf_endEmbeddedR( int arg ))
]

{ #category : #private }
RSession class >> Rf_initEmbeddedR: params [
	| strings par |
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
RSession class >> Rf_initEmbeddedRargc: argc argv: argv [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_initEmbeddedR(int argc, char *argv))
]

{ #category : #private }
RSession class >> Rf_install: aLibName [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(String aLibName))
]

{ #category : #'stats functions' }
RSession class >> checkLibs [
	 self isExistsRf_initEmbeddedR ifFalse: [ Error signal: 'The R lib cannot be used. Please install the libraries in the Pharo.exe folder' ]
]

{ #category : #'R session' }
RSession class >> checkSession [
	(NativeBoost sessionChanged: RSession)
		ifTrue: [ 
			RSession := NativeBoost uniqueSessionObject.
			RLibTypes initialize.
			self Rf_initEmbeddedR: #(#R '--no-save' 'silent') ]
]

{ #category : #'stats functions' }
RSession class >> checkWorking [
	(self unif_rand between: 0 and: 1)
		ifFalse: [ Error signal: 'Should not be false' ]
]

{ #category : #'stats functions' }
RSession class >> initialize [
	Smalltalk addToStartUpList: self.
	
]

{ #category : #'stats functions' }
RSession class >> invalidateOldHandles [
	self flag: 'To implement after'.
]

{ #category : #testing }
RSession class >> isExistsRf_initEmbeddedR [
	^ (self nbGetSymbolAddress: 'Rf_initEmbeddedR' module: #R) isNotNil
]

{ #category : #'library path' }
RSession class >> nbLibraryNameOrHandle [
 ^ #R
]

{ #category : #'stats functions' }
RSession class >> startUp [
	self checkLibs.
	self checkSession.
	self checkWorking.
	self invalidateOldHandles.
]

{ #category : #'stats functions' }
RSession class >> unif_rand [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #( double unif_rand(void) )
        module: #R
]

{ #category : #'library path' }
RSession >> nbLibraryNameOrHandle [
 ^ self class nbLibraryNameOrHandle
]
