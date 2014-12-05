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

{ #category : #'trait - instance creation' }
RNilValue class >> createNewObjectFrom: aRObject [
	^ instance
]

{ #category : #'class initialization' }
RNilValue class >> initialize [
	instance := super new.
]

{ #category : #'instance creation' }
RNilValue class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
RNilValue class >> new: aLength [
	"For upper compatibility"

	^ instance
]

{ #category : #accessing }
RNilValue class >> type [
	^ NILSXP
]

{ #category : #converting }
RNilValue >> asRObject [
 	^ self
]

{ #category : #evaluating }
RNilValue >> value [
 	^ self class R_NilValue
]
