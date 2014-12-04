Class {
	#name : #RListTest,
	#superclass : #RAbstractTest,
	#category : #'RConnector-Tests'
}

{ #category : #'as yet unclassified' }
RListTest >> testAccessAllAttributesOfAList [
	"
	x = c(1,  2,  3 )
	attributes(arima(x))
	$names
	 [1] coef sigma2 var.coef mask loglik aic arma
	 [8] residuals call series code n.cond model
	$class
	[1] Arima"

	| arima attribs |
	arima := RFunction
		eval: 'arima'
		withParameters:
			{(RIntVector new
				addAll:
						{1.
							2.
							3};
				yourself)}.
	self assert: (arima isKindOf: RList).
	self assert: arima isObject.
	attribs := arima attributes.
	self assert: (attribs isKindOf: RStringVector).
	self assert: attribs first equals: 'coef'.
	self assert: attribs second equals: 'sigma2'.
	self assert: (attribs at: 3) equals: 'var.coef'.
	self assert: (attribs at: 4) equals: 'mask'.
	self assert: (attribs at: 5) equals: 'loglik'.
	self assert: (attribs at: 6) equals: 'aic'.
	self assert: (attribs at: 7) equals: 'arma'.
	self assert: (attribs at: 8) equals: 'residuals'
]

{ #category : #'as yet unclassified' }
RListTest >> testAccessAllElementsOfAList [
	| list |
	list := RList new: 0.
	self assert: list size equals:0
	
	
]

{ #category : #'as yet unclassified' }
RListTest >> testAccessAnExistingKeyOfAList [
	"
	x = c(1,  2,  3 )
	arima(x)$coef"

	| arima |
	arima := RFunction
		eval: 'arima'
		withParameters:
			{(RIntVector new
				addAll:
						{1.
							2.
							3};
				yourself)}.
	self assert: (arima isKindOf: RList).
	self assert: arima isObject.
	self assert: ((arima at: 'coef') isKindOf: RDoubleVector).
	self assert: ((arima at: 'coef') first closeTo: 2.0)
]

{ #category : #'as yet unclassified' }
RListTest >> testAccessFirstOfAList [
	"
	x = c(1,  2,  3 )
	arima(x)$coef"

	| arima |
	arima := RFunction
		eval: 'arima'
		withParameters:
			{(RIntVector new
				addAll:
						{1.
							2.
							3};
				yourself)}.
	self assert: (arima isKindOf: RList).
	self assert: arima isObject.
	self assert: (arima first isKindOf: RDoubleVector).
	self assert: (arima first first closeTo: 2.0)
]

{ #category : #'as yet unclassified' }
RListTest >> testAccessItemFromEmptyListShouldNotBeAllowed [
	| list |
	list := RList new: 0.
	self should: [ list at: 1 ] raise: Error
]

{ #category : #'as yet unclassified' }
RListTest >> testAccessTheClassNameOfAList [
	"
	x = c(1,  2,  3 )
	attributes(arima(x))
	$names
	 [1] coef sigma2 var.coef mask loglik aic arma
	 [8] residuals call series code n.cond model
	$class
	[1] Arima"

	| arima attribs |
	arima := RFunction
		eval: 'arima'
		withParameters:
			{(RIntVector new
				addAll:
						{1.
							2.
							3};
				yourself)}.
	self assert: (arima isKindOf: RList).
	self assert: arima isObject.
	attribs := arima rClass.
	self assert: (attribs isKindOf: RStringVector).
	self assert: attribs first equals: 'Arima'
]

{ #category : #'as yet unclassified' }
RListTest >> testEmptyListShouldBeEmpty [
	| list |
	list := RList new: 0.
	self assert: list size equals:0
	
	
]
