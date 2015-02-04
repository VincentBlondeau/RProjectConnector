Class {
	#name : #RObjectArray,
	#superclass : #NBExternalArray,
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'trait - private primitives' }
RObjectArray class >> asNBExternalType: gen [
	^ NBExternalObjectType objectClass: self
]

{ #category : #'trait - private primitives' }
RObjectArray class >> initialize [
	self initElementType: 'RObject'
]
