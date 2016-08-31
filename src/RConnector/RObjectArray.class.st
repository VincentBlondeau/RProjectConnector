Class {
	#name : #RObjectArray,
	#superclass : #FFIExternalArray,
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'trait - private primitives' }
RObjectArray class >> externalNew: size [ 
	^ self externalNewType: RObject size: size
]

{ #category : #accessing }
RObjectArray >> at: index [
	^ (RObject new handle: (super at: index)) asRObject
]

{ #category : #accessing }
RObjectArray >> at: index put: anObject [
	^ super at: index put: anObject getHandle getHandle
]
