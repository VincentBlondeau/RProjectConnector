Class {
	#name : #RVector,
	#superclass : #OrderedCollection,
	#traits : 'TRHelpers',
	#classTraits : 'TRHelpers classTrait',
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'library path' }
RVector class >> asNBExternalType: gen [
	^ NBExternalObjectType objectClass: self
]

{ #category : #'library path' }
RVector class >> new: size [
	| instance |
	instance := self primNew: size type: self type.
	instance setCollection: (self arrayType onAddress: (NBExternalAddress value: instance real) size: size).
	^ instance
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

{ #category : #'as yet unclassified' }
RVector >> truelength [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int TRUELENGTH(self))
]
