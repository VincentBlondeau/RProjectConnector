Class {
	#name : #RObject,
	#superclass : #NBExternalObject,
	#traits : 'TRHelpers + TRGlobals',
	#classTraits : 'TRHelpers classTrait + TRGlobals classTrait',
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RObject class >> createNewObjectFrom: aRObject [
	| instance |
	instance := self new: aRObject length.
	instance handle: aRObject handle.
	^ instance
]

{ #category : #'as yet unclassified' }
RObject class >> new: size [
	^ self primNew: size type: self type
]

{ #category : #'as yet unclassified' }
RObject class >> newFromRObject: aRObject [
	| class |
	class := self findClassOf: aRObject.
	^ class createNewObjectFrom: aRObject
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
