Class {
	#name : #RObject,
	#superclass : #NBExternalObject,
	#traits : 'TRHelpers - {#SYMVALUE}',
	#classTraits : 'TRHelpers classTrait',
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #accessing }
RObject class >> creationType [
	^ self = RObject ifTrue: [ NILSXP ] ifFalse: [ self type ]
]

{ #category : #'instance creation' }
RObject class >> new [
	^ self new: 1
]

{ #category : #'instance creation' }
RObject class >> new: size [
	^ self primNew: size type: self creationType
]

{ #category : #'private - instance creation' }
RObject class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_allocVector (int type, int size))
]

{ #category : #accessing }
RObject class >> type [
	^ self shouldNotImplement 
]

{ #category : #'as yet unclassified' }
RObject >> prim_string_ptr [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong STRING_PTR(self))
]
