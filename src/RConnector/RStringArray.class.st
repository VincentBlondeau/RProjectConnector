"
A RStringArray class is representing a external array of RChar (this is strings for R). 
The TRHelper trait should not be used here because is just a transition type that should not be public.
"
Class {
	#name : #RStringArray,
	#superclass : #NBExternalArray,
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'trait - instance creation' }
RStringArray class >> asNBExternalType: gen [
	^ NBExternalObjectType objectClass: self
]

{ #category : #'class initialization' }
RStringArray class >> initialize [
	self initElementType: 'RChar'
]

{ #category : #'class initialization' }
RStringArray class >> type [
	^ CHARSXP
]

{ #category : #'trait - copying' }
RStringArray >> copyVectorFrom: anOldString [
	anOldString  size  halt.
    ^ self prim_copyVector: ''
]
