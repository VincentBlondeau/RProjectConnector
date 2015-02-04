"
A RNilValue class is the representation of nil in R. There is only one instance in the system and it is 
self class R_NilValue.
"
Class {
	#name : #RNilValue,
	#superclass : #RObject,
	#classVars : [
		'Instance'
	],
	#category : #'RConnector-Core'
}

{ #category : #'trait - instance creation' }
RNilValue class >> createNewObjectFrom: aRObject [
	^ Instance
]

{ #category : #'class initialization' }
RNilValue class >> initialize [
	Instance := super new.
]

{ #category : #'instance creation' }
RNilValue class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
RNilValue class >> new: aLength [
	"For upper compatibility"

	^ Instance
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
 	^ self class rNilValue
]
