Class {
	#name : #RString,
	#superclass : #RCollection,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RString class >> arrayType [
	^ NBExternalArray ofType: 'char'
]

{ #category : #'as yet unclassified' }
RString class >> firstPointer [
	^ #char
]

{ #category : #'as yet unclassified' }
RString class >> primNew: aString [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RString Rf_mkString(String aString))
]

{ #category : #'as yet unclassified' }
RString class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RString Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RString class >> type [
	^ STRSXP
]

{ #category : #'as yet unclassified' }
RString >> firstPointer [
	^ self char
]

{ #category : #'as yet unclassified' }
RString >> prim_string_ptr [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP * STRING_PTR(self))
]

{ #category : #'as yet unclassified' }
RString >> printOn: aStream [
	super printOn: aStream.
	aStream << $ .
	aStream << self value
]

{ #category : #'as yet unclassified' }
RString >> value [
	^ (self prim_string_elm: 0) prim_char
]
