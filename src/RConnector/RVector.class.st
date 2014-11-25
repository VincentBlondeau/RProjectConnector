Class {
	#name : #RVector,
	#superclass : #OrderedCollection,
	#traits : 'TRHelpers',
	#classTraits : 'TRHelpers classTrait - {#createNewObjectFrom:withClass:}',
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
RVector class >> basicNew [
	^ super basicNew
		initializeHandle;
		yourself
]

{ #category : #'as yet unclassified' }
RVector class >> createNewObjectFrom: aRObject [
	| instance |
	instance := self basicNew handle: aRObject handle.
	instance
		setCollection:
			(self arrayType onAddress: (NBExternalAddress value: (aRObject perform: self firstPointer)) size: aRObject length).
	instance resetSize.
	^ instance
]

{ #category : #'library path' }
RVector class >> new [
	"If the array is not initialized at size 1 first. Then some synchronization problems with the external array can appears..."
	^ self new: 1
]

{ #category : #'library path' }
RVector class >> new: size [
	| instance |
	instance := self primNew: size.
	instance setCollection: (self arrayType onAddress: (NBExternalAddress value: instance firstPointer) size: size).
	^ instance
]

{ #category : #'library path' }
RVector class >> primNew: size [
	^ self primNew: size type: self type
]

{ #category : #'as yet unclassified' }
RVector class >> primNew: size type: type [
	^ self shouldNotImplement 
]

{ #category : #'as yet unclassified' }
RVector class >> type [
	^self shouldNotImplement 
]

{ #category : #testing }
RVector >> addFirst: anElement [
	super addFirst: anElement.
	self setLength: self size
]

{ #category : #testing }
RVector >> addLast: anElement [
	super addLast: anElement.
	self setLength: self size."((self size) min: self capacity)"
]

{ #category : #testing }
RVector >> asPureRObject [
	^ RObject createNewObjectFrom: self 
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
RVector >> growAtLast [
	"overridden to create external objects"
	"We should recreate a new instance because there is no reallocation in the RAPI. So we swap the handles"
	"Protect and unprotect methods should be added too"
	| newArray newInstance size |
	size := (array size * 2 max: 1).
	newInstance := self class primNew: size.
	self handle: newInstance handle.
	newArray := (self class arrayType onAddress: (NBExternalAddress value: newInstance firstPointer) size: size).
	newArray 
		replaceFrom: firstIndex
		to: lastIndex
		with: array
		startingAt: firstIndex.
	array := newArray
]

{ #category : #accessing }
RVector >> handle [
	^ handle value
]

{ #category : #accessing }
RVector >> handle: aUint [
	handle value: aUint
]

{ #category : #initialization }
RVector >> initializeHandle [
	handle := NBExternalHandle new
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

{ #category : #accessing }
RVector >> resetSize [
	firstIndex := 1.
	lastIndex := (self capacity)
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
