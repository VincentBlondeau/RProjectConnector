Class {
	#name : #RObject,
	#superclass : #NBExternalObject,
	#traits : 'TRLibrary + TRHelpers',
	#classTraits : 'TRLibrary classTrait + TRHelpers classTrait',
	#pools : [
		'RLibTypes'
	],
	#classInstVars : [
		'par'
	],
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
RObject class >> R_BaseEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_BaseEnv
]

{ #category : #'as yet unclassified' }
RObject class >> R_EmptyEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_EmptyEnv
]

{ #category : #'as yet unclassified' }
RObject class >> R_GlobalEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_GlobalEnv
]

{ #category : #'as yet unclassified' }
RObject class >> R_NilValue [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_NilValue
]

{ #category : #'as yet unclassified' }
RObject class >> Rf_findFun: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_findFun(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'as yet unclassified' }
RObject class >> Rf_install: aString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(const char * aString))
]

{ #category : #'as yet unclassified' }
RObject class >> findFun: aStringOfFunctionName [
	^ self Rf_findFun: (self Rf_install: aStringOfFunctionName) option: self R_GlobalEnv
]

{ #category : #'as yet unclassified' }
RObject class >> getRObjectFromGlobalVariable: varName [
	^ RObject new  handle: (self nbGetGlobalVariable: varName)
]

{ #category : #'as yet unclassified' }
RObject >> R_tryEval [
    ^ self primR_tryEval: self class R_GlobalEnv error: NBExternalAddress null
]

{ #category : #'as yet unclassified' }
RObject >> primR_tryEval: env error: errorOccurred [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP R_tryEval(SEXP self,SEXP env, int * errorOccurred))
]
