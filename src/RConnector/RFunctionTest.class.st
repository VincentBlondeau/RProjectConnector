Class {
	#name : #RFunctionTest,
	#superclass : #RAbstractTest,
	#category : #'RConnector-Tests'
}

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
	
	
	
]

{ #category : #'as yet unclassified' }
RFunctionTest >> testRnormShouldGiveAnArrayOfFloats [
	| function res  |
	function := RFunction functionName: 'rnorm' parameters: { 10 }.
	res := function eval.
	self assert: (res isKindOf: RDoubleVector ).
	self assert: res length equals: 10
	
	
	
]

{ #category : #'as yet unclassified' }
RFunctionTest >> testSeqShouldGiveAnArrayOfInt [
	| function res  |
	function := RFunction functionName: 'seq' parameters: { 1 . 10 }.
	res := function eval.
	self assert: (res isKindOf: RIntVector ).
	self assert: res length equals: 10
	
	
	
]
