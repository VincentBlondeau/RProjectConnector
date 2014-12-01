"
A RVector is is an abstract reprensentation of a vector in R. Its subclasses OrdreredCollection to use all the potential of the class. Some functions could be not working since the collection attached to the vector is a subclass of NBExternalArray instead of an Array.


Instance Variables
	handle:		a NBExternalHandle

handle
	- the handle represents (as in NBExternalObject) the pointer to the R external object. The array containing the data (is the vector elements) is included in the R external object and his pointer can be accessed by the firstPointer method (see subclasses for impl). This pointer should NOT be reallocated with the methods of NBExternalArray. A new RVector object  has to be created with the Rf_AllocVector primitive and the handles swapped (see growAtLast for impl).


"
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

{ #category : #converting }
RVector class >> asNBExternalType: gen [
	^ NBExternalObjectType objectClass: self
]

{ #category : #'instance creation' }
RVector class >> basicNew [
	^ super basicNew
		initializeHandle;
		yourself
]

{ #category : #'instance creation' }
RVector class >> createNewObjectFrom: aRObject [
	| instance |
	instance := self basicNew handle: aRObject handle.
	instance
		setCollection:
			(self arrayType onAddress: (NBExternalAddress value: (aRObject perform: self firstPointer)) size: aRObject length).
	instance resetSize.
	^ instance
]

{ #category : #'trait - function finding' }
RVector class >> findFun: aStringOfFunctionName [
	^ self prim_findFun: (self Rf_install: aStringOfFunctionName) option: self R_GlobalEnv
]

{ #category : #'instance creation' }
RVector class >> new [
	"If the array is not initialized at size 1 first. Then some synchronization problems with the external array can appears..."
	^ self new: 1
]

{ #category : #'instance creation' }
RVector class >> new: size [
	| instance |
	instance := self primNew: size.
	instance setCollection: (self arrayType onAddress: (NBExternalAddress value: instance firstPointer) size: size).
	^ instance
]

{ #category : #'private - instance creation' }
RVector class >> primNew: size [
	^ self primNew: size type: self type
]

{ #category : #'private - instance creation' }
RVector class >> primNew: size type: type [
	^ self shouldNotImplement 
]

{ #category : #accessing }
RVector class >> type [
	^self shouldNotImplement 
]

{ #category : #adding }
RVector >> addFirst: anElement [
	super addFirst: anElement.
	self setLength: self size
]

{ #category : #adding }
RVector >> addLast: anElement [
	super addLast: anElement.
	self setLength: self size."((self size) min: self capacity)"
]

{ #category : #converting }
RVector >> asPureRObject [
	^ RObject createNewObjectFrom: self 
]

{ #category : #converting }
RVector >> asRObject [
	^ self
]

{ #category : #'as yet unclassified' }
RVector >> defineAsVarNamed: aRName [
	self assert: (aRName isKindOf: Symbol). "Should be removed if the type is checked in the primitive"
   self defineAsVarNamed: aRName inEnv: self class R_GlobalEnv
]

{ #category : #accessing }
RVector >> firstPointer [
	^ self shouldNotImplement  
]

{ #category : #private }
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

{ #category : #'private - notused' }
RVector >> prim_at: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP VECTOR_ELT(self, int index))


]

{ #category : #'trait - private primitives' }
RVector >> prim_defineAsVarNamed: name inEnv: anEnvironment [ 
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void Rf_defineVar(SEXP name, self, SEXP anEnvironment))
]

{ #category : #'private - notused' }
RVector >> prim_sat: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP STRING_ELT(self, int index))


]

{ #category : #private }
RVector >> resetSize [
	firstIndex := 1.
	lastIndex := (self capacity)
]

{ #category : #private }
RVector >> setLength: length [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void SETLENGTH(self, int length))
]

{ #category : #'private - notused' }
RVector >> truelength [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int TRUELENGTH(self))
]
