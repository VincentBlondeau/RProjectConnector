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
RCollectionTest >> testIntVectorAddFirst [
	| vector |
	vector := RIntVector new: 1.
	vector add: 22.
	vector addFirst: 12.
	self assert: (vector at: 1) equals: 12.
	self assert: (vector at: 2) equals: 22.
	self assert: vector length equals: 2."the true length for R"
	
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testIntVectorSet [
	| vector |
	vector := RIntVector new: 1.
	vector add: 12.
	self assert: (vector at: 1) equals: 12
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testIntVectorSetOverFlowCapacity [
	| vector |
	vector := RIntVector new: 1.
	vector add: 12.
	vector add: 22.
	self assert: (vector at: 1) equals: 12.
	self assert: (vector at: 2) equals: 22.
	self assert: vector length equals: 2."the true length for R"
	
]
