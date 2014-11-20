Class {
	#name : #RVector,
	#superclass : #RCollection,
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
RVector class >> checkIsVector: aRObject [
	aRObject isVectorList
		ifFalse: [ CannotBeConvertedToType signal ]
]

{ #category : #'as yet unclassified' }
RVector class >> new: size [
	^ self primNew: size type: self type
]

{ #category : #'as yet unclassified' }
RVector class >> newFromRObject: aRObject [
	| vect |
	"self checkIsVector: aRObject."
	vect := self new.
	vect handle: aRObject handle.
	^ vect
]

{ #category : #'as yet unclassified' }
RVector class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RVector Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RVector class >> type [
	^ VECSXP 
]

{ #category : #'as yet unclassified' }
RVector >> at: index [
	(index between: 1 and: self length) ifTrue: [^ self prim_at: index].
	^ self errorSubscriptBounds: index
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
