Class {
	#name : #RFunctionTest,
	#superclass : #RAbstractTest,
	#category : #'RConnector-Tests'
}

{ #category : #'as yet unclassified' }
RFunctionTest >> testCorrelationXXShouldGiveOne [
	| rnorm  abs  res  |
	rnorm := RFunction eval:  'rnorm' withParameters: { 500 . 0 . 1 }.
	abs := RFunction eval: 'abs' withParameters: { rnorm }.
	res := RFunction eval: 'cor' withParameters: { abs . abs }.
	self assert: (res isKindOf: RDoubleVector ).
	self assert: res length equals: 1.
	self assert: res size equals: 1.
	self assert: res first equals: 1
	
	
	
]

{ #category : #'as yet unclassified' }
RFunctionTest >> testFunctionAbsFromSmalltalkCollectionShouldGiveAnAbsoluteArrayOfFloats [
	| res abs data |
	data := RIntVector new.
	data addAll: {-1. 1. 0. 51.-42}.
	abs := RFunction functionName: 'abs' parameters: {data}.
	res := abs eval.
	self assert: (res isKindOf: RIntVector).
	self assert: res length equals: 5.
	self assert: res size equals: 5.
	self assert: res asOrderedCollection equals: {-1. 1. 0. 51.-42} abs asOrderedCollection.
]

{ #category : #'as yet unclassified' }
RFunctionTest >> testFunctionCombinaisonAbsRnormShouldGiveAnArrayOfFloats [
"What we want in R: x <- abs(rnorm(500, 50, 30))"
	|  res res2 rnorm abs |
	rnorm := RFunction functionName: 'rnorm' parameters: { 500 . 50 . 30 }.
	res := rnorm eval.
	abs := RFunction functionName: 'abs' parameters: { res }.
	res2 := abs eval.
	self assert: (res2 isKindOf: RDoubleVector ).
	self assert: res2 length equals: 500.
	self deny: (res2 first = 0)	
	
	
]

{ #category : #'as yet unclassified' }
RFunctionTest >> testRnormShouldGiveAnArrayOfFloats [
	| function res  |
	function := RFunction functionName: 'rnorm' parameters: { 10 }.
	res := function eval.
	self assert: (res isKindOf: RDoubleVector ).
	self assert: res length equals: 10.
	self assert: res size equals: 10.
	
	
	
]

{ #category : #'as yet unclassified' }
RFunctionTest >> testSeqShouldGiveAnArrayOfInt [
	| function res  |
	function := RFunction functionName: 'seq' parameters: { 1 . 10 }.
	res := function eval.
	self assert: (res isKindOf: RIntVector ).
	self assert: res length equals: 10.
	self assert: res asOrderedCollection equals: (1 to: 10 ) asOrderedCollection.
	
	
	
]
