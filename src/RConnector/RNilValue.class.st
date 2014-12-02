"
A RNilValue class is the representation of nil in R. There is only one instance in the system and it is 
self class R_NilValue.
"
Class {
	#name : #RNilValue,
	#superclass : #RObject,
	#classVars : [
		'instance'
	],
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RNilValue class >> createNewObjectFrom: aRObject [
	^ instance
]

{ #category : #'as yet unclassified' }
RNilValue class >> initialize [
	instance := super new.
]

{ #category : #'as yet unclassified' }
RNilValue class >> new [
	self shouldNotImplement 
]

{ #category : #'as yet unclassified' }
RNilValue class >> new: aLength [
	"For upper compatibility"

	^ instance
]

{ #category : #'as yet unclassified' }
RNilValue class >> type [
	^ NILSXP
]

{ #category : #'as yet unclassified' }
RNilValue >> asRObject [
 	^ self
]

{ #category : #'as yet unclassified' }
RNilValue >> value [
 	^ self class R_NilValue
]
