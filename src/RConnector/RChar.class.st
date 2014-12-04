Class {
	#name : #RChar,
	#superclass : #RObject,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RChar class >> createNewObjectFrom: aRObject [ 
	| instance  |
	instance := self new: aRObject char.
	instance handle: aRObject handle.
	^ instance
]

{ #category : #'as yet unclassified' }
RChar class >> primNew: aString [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RChar Rf_mkChar(String aString))
]

{ #category : #'as yet unclassified' }
RChar class >> primNew: size type: type [
	^ self primNew: size
]

{ #category : #'as yet unclassified' }
RChar class >> type [
	^ CHARSXP
]

{ #category : #'as yet unclassified' }
RChar >> printOn: aStream [
	super printOn: aStream.
	aStream << $'.
	aStream << self value.
	aStream << $'
]

{ #category : #'as yet unclassified' }
RChar >> value [
	^ self char
]
