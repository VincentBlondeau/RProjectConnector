"
A RList class is a representation of a list of type VECEXP under R.
It is a kind of PairList.

It is read only for now
"
Class {
	#name : #RList,
	#superclass : #RVector,
	#type : #variable,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RList class >> arrayType [
	^ RStringVector
]

{ #category : #'trait - instance creation' }
RList class >> createNewObjectFrom: aRObject [
	| instance |
	instance := self basicNew handle: aRObject handle.
	instance initialize.
	^ instance
]

{ #category : #'as yet unclassified' }
RList class >> new [
	^ self new: 1
]

{ #category : #'as yet unclassified' }
RList class >> new: size [
	| instance |
	instance := self primNew: size.
	instance initialize.
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
	^ index indexKeyToRList: self
]

{ #category : #'as yet unclassified' }
RList >> at: key ifAbsent: aBlock [ 
	"Answer the value associated with the key or, if key isn't found,
	answer the result of evaluating aBlock."

	^((self atIndex: (self findElementOrNil: key)) 
			ifNil: [aBlock] 
			ifNotNil: [:assoc | assoc]) value.
]

{ #category : #'as yet unclassified' }
RList >> at: index put: anElement [
	self ensureBoundsFrom: index to: index.
	self prim_setVectorElement: anElement asPureRObject at: index - 1
]

{ #category : #'as yet unclassified' }
RList >> at: index putValue: anElement [
	(index between: 0 and: self size)
		ifFalse: [ ^ self errorSubscriptBounds: index ].
	self prim_setVectorElement: anElement asPureRObject at: index - 1
]

{ #category : #accessing }
RList >> atIndex: index [
	self ensureBoundsFrom: index to: index.
	^ (self prim_vectorElementAt: index - 1) asRObject
]

{ #category : #accessing }
RList >> atKey: aKey [
	| index |
	index := self findIndexOfKey: aKey.
	^ self at: index
]

{ #category : #'as yet unclassified' }
RList >> attributes [
	^ (self prim_getAttribute: self class R_NamesSymbol) asRObject ifNil: [ RStringVector new ]"self prim_attributes asRObject "
]

{ #category : #'as yet unclassified' }
RList >> findIndexOfKey: anObject [
	^ array indexOf: anObject.
]

{ #category : #accessing }
RList >> first [
	^ self atIndex: 1
]

{ #category : #accessing }
RList >> first: anElement [
	
	^ self prim_setVectorElement: anElement at: 0

]

{ #category : #accessing }
RList >> firstPointer [
	^ self attributes.
]

{ #category : #'as yet unclassified' }
RList >> initialize [
	array := self attributes.
	super initialize.
]

{ #category : #'as yet unclassified' }
RList >> keys [
	^ self attributes
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
	^ array size.
"	^ self prim_length"
]
