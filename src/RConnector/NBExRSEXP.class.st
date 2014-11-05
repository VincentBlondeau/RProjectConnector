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
NBExRSEXP class >> R_BaseEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbGetGlobalVariable: #R_BaseEnv
]

{ #category : #'as yet unclassified' }
NBExRSEXP class >> R_EmptyEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbGetGlobalVariable: #R_EmptyEnv
]

{ #category : #'as yet unclassified' }
NBExRSEXP class >> R_GlobalEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbGetGlobalVariable: #R_GlobalEnv
]

{ #category : #'as yet unclassified' }
NBExRSEXP class >> R_NilValue [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbGetGlobalVariable: #R_NilValue
]

{ #category : #'as yet unclassified' }
NBExRSEXP class >> Rf_findFun: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong Rf_findFun(ulong aNBSEXPfunction, ulong aNbSEXPoption))
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
