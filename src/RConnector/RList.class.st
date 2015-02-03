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

{ #category : #private }
RList class >> arrayType [
	^ RStringVector
]

{ #category : #'instance creation' }
RList class >> createNewObjectFrom: aRObject [
	| instance |
	instance := self basicNew handle: aRObject handle.
	instance initialize.
	^ instance
]

{ #category : #'instance creation' }
RList class >> new: size [
	| instance |
	instance := self primNew: size.
	instance initialize.
	^ instance

]

{ #category : #'private - instance creation' }
RList class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RList Rf_allocVector (int type, int size))
]

{ #category : #accessing }
RList class >> type [
	^ VECSXP
]

{ #category : #accessing }
RList >> at: index [
	^ index indexKeyToRList: self
]

{ #category : #accessing }
RList >> at: key ifAbsent: aBlock [ 
	"Answer the value associated with the key or, if key isn't found,
	answer the result of evaluating aBlock."

	^((self atIndex: (self findElementOrNil: key)) 
			ifNil: [aBlock] 
			ifNotNil: [:assoc | assoc]) value.
]

{ #category : #accessing }
RList >> at: index put: anElement [
	| tmpIndex pos |
	tmpIndex := index.
	index isString
		ifTrue: [ 
			tmpIndex := self findIndexOfKey: index.
			tmpIndex isZero
				ifTrue: [ 
					pos := self findIndexOfKey: nil.
					pos isZero
						ifTrue: [ SubscriptOutOfBounds signal ].
					self halt.
					(self prim_attributeAt: self class rNamesSymbol)asRObject
					 prim_attributeAt: pos asRObject put: index asPureRObject.
					array := self attributes.
					self prim_setVectorElement: anElement asPureRObject at: pos - 1.
					^ anElement ] ].
	self ensureBoundsFrom: tmpIndex to: tmpIndex.
	self prim_setVectorElement: anElement asPureRObject at: tmpIndex - 1
]

{ #category : #adding }
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
	index isZero
		ifTrue: [ NotFound signalFor: aKey ].
	^ self at: index
]

{ #category : #accessing }
RList >> attributes [
	^ (self prim_attributeAt: self class rNamesSymbol) asRObject ifNil: [ 
		self initializeAttributeField.
		
		]	"self prim_attributes asRObject "
]

{ #category : #private }
RList >> findIndexOfKey: anObject [
	^ array indexOf: anObject.
]

{ #category : #accessing }
RList >> first: anElement [
	
	^ self at: 1 put: anElement

]

{ #category : #accessing }
RList >> firstPointer [
	^ self attributes.
]

{ #category : #private }
RList >> initialize [
	array := self attributes.
	super initialize.
]

{ #category : #accessing }
RList >> initializeAttributeField [
	| length |
	length := self prim_length.
	^ length isZero
		ifTrue: [ {} ]
		ifFalse: [ (self prim_attributeAt: self class rNamesSymbol put: (RStringVector new: length) asPureRObject) asRObject ]
]

{ #category : #accessing }
RList >> keys [
	^ self attributes
]

{ #category : #'private - primitive' }
RList >> prim_attributeAt: attributeName [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_getAttrib(self, SEXP attributeName))
]

{ #category : #'private - primitive' }
RList >> prim_attributeAt: attributeName put: attributeValue [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>

	^ self nbCall: #(SEXP Rf_setAttrib(self, SEXP attributeName, SEXP attributeValue))
]

{ #category : #'private - primitive' }
RList >> prim_attributes [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP ATTRIB(self))
]

{ #category : #'private - primitive' }
RList >> prim_getAttribute: attributeName [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_getAttrib(self, SEXP attributeName))
]

{ #category : #'private - primitive' }
RList >> prim_installlAttributeAt: attributeName put: attributeValue [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>

	^ self nbCall: #(SEXP Rf_installAttrib(self, SEXP attributeName, SEXP attributeValue))
]

{ #category : #accessing }
RList >> rClass [
	^ (self prim_attributeAt: self class rClassSymbol) asRObject
]

{ #category : #accessing }
RList >> second: anElement [
    ^ self at: 2 put: anElement

]

{ #category : #accessing }
RList >> size [
	handle isNull ifTrue: [ ^ 0 ].
	^ array size.
"	^ self prim_length"
]
