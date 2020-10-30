Class {
	#name : #RObjectList,
	#superclass : #SequenceableCollection,
	#instVars : [
		'originator'
	],
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RObjectList class >> from: aRObject new: anInteger [
	^ (self new)
		originator: aRObject;
		yourself
]

{ #category : #accessing }
RObjectList >> at: index [
	(index between: 1 and: originator prim_length)
		ifFalse: [ ^ SubscriptOutOfBounds
				signalFor: index
				lowerBound: 1
				upperBound: originator prim_length ].
	^ (originator prim_vectorElementAt: index - 1) asRObject
]

{ #category : #accessing }
RObjectList >> at: index put: anObject [

	(index between: 1 and: originator prim_length)
		ifFalse: [ ^ SubscriptOutOfBounds
				signalFor: index
				lowerBound: 1
				upperBound: originator prim_length].
	^ originator prim_setVectorElement: anObject asPureRObject at: index - 1
]

{ #category : #'as yet unclassified' }
RObjectList >> originator: aRObject [
	originator := aRObject
]

{ #category : #accessing }
RObjectList >> size [
	^ originator prim_length
]
