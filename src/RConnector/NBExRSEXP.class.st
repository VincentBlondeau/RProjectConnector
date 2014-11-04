Class {
	#name : #NBExRSEXP,
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
NBExRSEXP class >> R_GlobalEnv [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbGetSymbolAddress: #R_GlobalEnv
        module: #R
]

{ #category : #'as yet unclassified' }
NBExRSEXP class >> Rf_findFun: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_findFun(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'as yet unclassified' }
NBExRSEXP class >> Rf_install: aString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(const char * aString))
]

{ #category : #'as yet unclassified' }
NBExRSEXP class >> findFun: aStringOfFunctionName [
	| functionNBPointer |
	functionNBPointer := self Rf_install:  aStringOfFunctionName .
	^ self Rf_findFun: functionNBPointer  option: self R_GlobalEnv 
]
