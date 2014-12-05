"
A RStringArray class is representing a external array of RChar (this is strings for R). 
The TRHelper trait should not be used here because is just a transition type that should not be public.
"
Class {
	#name : #RStringArray,
	#superclass : #NBExternalArray,
	#traits : 'TRHelpers + TRClassExtension',
	#classTraits : 'TRHelpers classTrait + TRClassExtension classTrait',
	#instVars : [
		'handle'
	],
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'trait - function finding' }
RStringArray class >> findFun: aStringOfFunctionName [
	^ self prim_findFun: (self prim_install: aStringOfFunctionName) option: self rGlobalEnv
]

{ #category : #'trait - function finding' }
RStringArray class >> findVar: aStringOfFunctionName [
	^ self prim_findVar: (self prim_install: aStringOfFunctionName) option: self rGlobalEnv
]

{ #category : #'class initialization' }
RStringArray class >> initialize [
	self initElementType: 'RChar *'
]

{ #category : #'trait - global variables' }
RStringArray class >> nilValue [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #rNilValue
]

{ #category : #'trait - variable definition' }
RStringArray >> defineAsVarNamed: aRName [
	self assert: (aRName isKindOf: Symbol).	"Should be removed if the type is checked in the primitive"
	^ self defineAsVarNamed: aRName inEnv: self class rGlobalEnv
]

{ #category : #accessing }
RStringArray >> handle [
	^ handle value
]

{ #category : #accessing }
RStringArray >> handle: aUint [
	handle value: aUint

]

{ #category : #initialization }
RStringArray >> initializeHandle [
	handle := NBExternalHandle new 


	
]
