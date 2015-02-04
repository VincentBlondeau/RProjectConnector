Class {
	#name : #RObjectArray,
	#superclass : #NBExternalArray,
	#pools : [
		'RLibTypes'
	],
	#category : #'Zinc-HTTP-Logging'
}

{ #category : #'trait - private primitives' }
RObjectArray class >> asNBExternalType: gen [
	^ NBExternalObjectType objectClass: self
]

{ #category : #'trait - private primitives' }
RObjectArray class >> initialize [
	self initElementType: 'RObject'
]
