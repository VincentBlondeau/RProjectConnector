Class {
	#name : #RListTest,
	#superclass : #RAbstractTest,
	#category : #'RConnector-Tests'
}

{ #category : #'as yet unclassified' }
RListTest >> testAccessItemFromEmptyListShouldNotBeAllowed [
	| list |
	list := RList new: 0.
	self fail.
	
	
]

{ #category : #'as yet unclassified' }
RListTest >> testEmptyListShouldBeEmpty [
	| list |
	list := RList new: 0.
	self assert: list length equals:0
	
	
]
