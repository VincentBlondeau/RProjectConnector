"
A RList class is a representation of a list of type LANGSXP under R.
It is a kind of PairList
"
Class {
	#name : #RList,
	#superclass : #Dictionary,
	#traits : 'TRHelpers + TRClassExtension',
	#classTraits : 'TRHelpers classTrait + TRClassExtension classTrait',
	#instVars : [
		'handle',
		'keys'
	],
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RList class >> arrayType [
	^ NBExternalArray ofType: 'bool'
]

{ #category : #'trait - instance creation' }
RList class >> createNewObjectFrom: aRObject [
	| instance |
	instance := self basicNew handle: aRObject handle.
	instance
		setCollection:
			(self arrayType onAddress: (NBExternalAddress value: (aRObject perform: self firstPointer)) size: aRObject prim_length).
	instance resetSize.
	^ instance
]

{ #category : #'as yet unclassified' }
RList class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RList Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RList class >> type [
	^ VECSXP
]

{ #category : #accessing }
RList >> at: index [
	(index between: 0 and: self size)
		ifFalse: [ ^ self errorSubscriptBounds: index ].
	^ (self prim_vectorElementAt: index - 1) asRObject
]

{ #category : #'as yet unclassified' }
RList >> at: index put: anElement [
	(index between: 0 and: self size)
		ifFalse: [ ^ self errorSubscriptBounds: index ].
	self prim_setVectorElement: anElement asPureRObject at: index - 1
]

{ #category : #'as yet unclassified' }
RList >> attributes [
	^ (self prim_getAttribute: self class R_NamesSymbol) asRObject "self prim_attributes asRObject "
]

{ #category : #accessing }
RList >> first [
	^ self at: 1
]

{ #category : #accessing }
RList >> first: anElement [
	
	^ self prim_setVectorElement: anElement at: 0

]

{ #category : #accessing }
RList >> handle [
	^ handle value
]

{ #category : #accessing }
RList >> handle: aUint [
	handle value: aUint
]

{ #category : #initialization }
RList >> initializeHandle [
	handle := NBExternalHandle new
]

{ #category : #'as yet unclassified' }
RList >> prim_attributes [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP ATTRIB(self))
]

{ #category : #'as yet unclassified' }
RList >> prim_getAttribute: attributeName [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_getAttrib(self, SEXP attributeName))
]

{ #category : #'as yet unclassified' }
RList >> rClass [
	^ (self prim_getAttribute: self class R_ClassSymbol) asRObject
]

{ #category : #'as yet unclassified' }
RList >> scanFor: anObject [
]

{ #category : #'as yet unclassified' }
RList >> second [
	^ self at: 2
]

{ #category : #'as yet unclassified' }
RList >> second: anElement [
    ^ self at: 2 put: anElement

]

{ #category : #'as yet unclassified' }
RList >> size [
	handle isNull ifTrue: [ ^ 0 ].
	^ self prim_length
]
