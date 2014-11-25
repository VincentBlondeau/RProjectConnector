Class {
	#name : #RVector,
	#superclass : #OrderedCollection,
	#traits : 'TRHelpers',
	#classTraits : 'TRHelpers classTrait',
	#instVars : [
		'handle'
	],
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'library path' }
RVector class >> asNBExternalType: gen [
	^ NBExternalObjectType objectClass: self
]

{ #category : #'as yet unclassified' }
RVector class >> createNewObjectFrom: aRObject withClass: class [
	| instance |
	instance := class new: aRObject length.
	instance handle: aRObject handle.
	^ instance
]

{ #category : #'library path' }
RVector class >> new: size [
	| instance |
	instance := self primNew: size type: self type.
	instance setCollection: (self arrayType onAddress: (NBExternalAddress value: instance firstPointer) size: size).
	^ instance
]

{ #category : #'as yet unclassified' }
RVector class >> type [
	^self shouldNotImplement 
]

{ #category : #testing }
RVector >> addFirst: anElement [
	super addFirst: anElement.
	self setLength: (self capacity)
]

{ #category : #testing }
RVector >> addLast: anElement [
	super addLast: anElement.
	self setLength: (self capacity)
]

{ #category : #testing }
RVector >> asRObject [
	^ self
]

{ #category : #'library path' }
RVector >> firstPointer [
	^ self shouldNotImplement  
]

{ #category : #accessing }
RVector >> handle [
	^ handle value
]

{ #category : #accessing }
RVector >> handle: aUint [
	handle value: aUint
]

{ #category : #'as yet unclassified' }
RVector >> prim_at: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP VECTOR_ELT(self, int index))


]

{ #category : #'as yet unclassified' }
RVector >> prim_sat: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP STRING_ELT(self, int index))


]

{ #category : #testing }
RVector >> setLength: length [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void SETLENGTH(self, int length))
]

{ #category : #'as yet unclassified' }
RVector >> truelength [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int TRUELENGTH(self))
]
