Class {
	#name : #RObject,
	#superclass : #NBExternalObject,
	#traits : 'TRHelpers',
	#classTraits : 'TRHelpers classTrait - {#createNewObjectFrom:withClass:}',
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RObject class >> creationType [
	^ self = RObject ifTrue: [ NILSXP ] ifFalse: [ self type ]
]

{ #category : #'trait - function finding' }
RObject class >> findClassOf: aRObject [
	"to implement in an other way..."
	| type classes |
	self flag: #toreimplement.
	type := aRObject prim_typeOf.
	classes := (RObject allSubclasses union: RVector allSubclasses)
		select: [ :c | [ c type = type ] on: ShouldNotImplement do: [ false ] ].
	classes size = 1
		ifFalse: [ Error signal ].	"detect should be used"
	^ classes first
]

{ #category : #'trait - function finding' }
RObject class >> findFun: aStringOfFunctionName [
	^ self prim_findFun: (self Rf_install: aStringOfFunctionName) option: self R_GlobalEnv
]

{ #category : #'trait - function finding' }
RObject class >> findVar: aStringOfVarName [
	^ self prim_findVar: (self Rf_install: aStringOfVarName) option: self R_GlobalEnv
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

{ #category : #'as yet unclassified' }
RObject >> char [
	self isString ifFalse: [ CannotBeConvertedToType signal ].
	^ (self prim_string_elm: 0) prim_char
]
