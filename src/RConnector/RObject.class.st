Class {
	#name : #RObject,
	#superclass : #NBExternalObject,
	#traits : 'TRLibrary + TRHelpers',
	#classTraits : 'TRLibrary classTrait + TRHelpers classTrait',
	#pools : [
		'RLibTypes'
	],
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
RObject class >> createNewObjectFrom: aRObject withClass: class [
	| instance |
	instance := class new: aRObject length.
	instance handle: aRObject handle.
	^ instance
]

{ #category : #'as yet unclassified' }
RObject class >> findClassOf: aRObject [
	| type classes |
	type := aRObject prim_typeOf.
	classes := RObject allSubclasses select: [ :c | [c type = type] onDNU: #type do: [ false ] ].
	classes size = 1 ifFalse: [ Error signal ]."detect should be used"
	^ classes first 
]

{ #category : #'library path' }
RObject class >> nbLibraryNameOrHandle [
 ^ #R
]

{ #category : #'as yet unclassified' }
RObject class >> new: size [
	^ self primNew: size type: self type
]

{ #category : #'as yet unclassified' }
RObject class >> newFromRObject: aRObject [
	| class |
	class := self findClassOf: aRObject.
	^ self createNewObjectFrom: aRObject withClass: class
]

{ #category : #'as yet unclassified' }
RObject class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RObject class >> type [
	^ NILSXP
]

{ #category : #testing }
RObject >> asPureRObject [
	^ self class createNewObjectFrom: self withClass: RObject
]

{ #category : #testing }
RObject >> asRObject [
	^ self class newFromRObject: self 
]

{ #category : #private }
RObject >> prim_int [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ (self
        nbCall: #(ulong INTEGER(self))) 
]

{ #category : #private }
RObject >> prim_typeOf [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int TYPEOF(self))
]
