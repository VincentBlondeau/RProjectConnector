"
A RStringArray class is representing a external array of RChar (this is strings for R). 
The TRHelper trait should not be used here because is just a transition type that should not be public.
"
Class {
	#name : #RStringArray,
	#superclass : #NBExternalArray,
	#traits : 'TRHelpers + TRClassExtension',
	#classTraits : 'TRHelpers classTrait + TRClassExtension classTrait',
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'class initialization' }
RStringArray class >> initialize [
	self initElementType: 'RChar *'
]

{ #category : #'class initialization' }
RStringArray class >> type [
	^ CHARSXP
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
	"handle := NBExternalHandle new "


	
]
