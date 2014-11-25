Class {
	#name : #RCollectionTest,
	#superclass : #RAbstractTest,
	#category : #'RConnector-Tests'
}

{ #category : #'as yet unclassified' }
RCollectionTest >> testDoubleVectorSet [
	| vector |
	vector := RDoubleVector new: 1.
	vector add: 1.2.
	self assert: (vector at: 1) equals: 1.2
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testIntVectorSet [
	| vector |
	vector := RIntVector new: 1.
	vector add: 12.
	self assert: (vector at: 1) equals: 12
]
