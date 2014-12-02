Class {
	#name : #RObject,
	#superclass : #NBExternalObject,
	#traits : 'TRHelpers - {#SYMVALUE}',
	#classTraits : 'TRHelpers classTrait',
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'trait - instance creation' }
RObject class >> createNewObjectFrom: aRObject [ 
	| instance  |
	instance := self new: aRObject prim_length.
	instance handle: aRObject handle.
	^ instance
]

{ #category : #'as yet unclassified' }
RObject class >> creationType [
	^ self = RObject ifTrue: [ NILSXP ] ifFalse: [ self type ]
]

{ #category : #'trait - function finding' }
RObject class >> findClassOf: aRObject [
	"to implement in an other way..."

	| type |
	type := aRObject prim_typeOf.
	^ RLibTypes implementationClassRelatedTo: type
]

{ #category : #'trait - function finding' }
RObject class >> findFun: aStringOfFunctionName [
	^ self prim_findFun: (self prim_install: aStringOfFunctionName) option: self R_GlobalEnv
]

{ #category : #'trait - function finding' }
RObject class >> findVar: aStringOfVarName [
	^ self prim_findVar: (self prim_install: aStringOfVarName) option: self R_GlobalEnv
]

{ #category : #'as yet unclassified' }
RObject class >> new [
	^ self new: 1
]

{ #category : #'as yet unclassified' }
RObject class >> new: size [
	^ self primNew: size type: self creationType
]

{ #category : #'as yet unclassified' }
RObject class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RObject class >> type [
	^ self shouldNotImplement 
]
