"
A RListTest is a test of the RList.

"
Class {
	#name : #RListTest,
	#superclass : #RCollectionTest,
	#category : #'RConnector-Tests'
}

{ #category : #tests }
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
	self assert: attribs first value equals: 'coef'.
	self assert: attribs second value equals: 'sigma2'.
	self assert: (attribs at: 3) value equals: 'var.coef'.
	self assert: (attribs at: 4) value equals: 'mask'.
	self assert: (attribs at: 5) value equals: 'loglik'.
	self assert: (attribs at: 6) value equals: 'aic'.
	self assert: (attribs at: 7) value equals: 'arma'.
	self assert: (attribs at: 8) value equals: 'residuals'
]

{ #category : #tests }
RListTest >> testAccessAllElementsOfAList [
	| list |
	list := RList new: 1.
	self assert: list size equals: 0
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
RListTest >> testAccessItemFromEmptyListShouldNotBeAllowed [
	self should: [ RList new: 0 ] raise: Error
]

{ #category : #tests }
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
	self assert: attribs first value equals: 'Arima'
]

{ #category : #tests }
RListTest >> testCreateListWithOneElement [
	| list |
	list := (RList new: 1)
		add: 'tseries';
		yourself.
	self assert: (list first isKindOf: RStringVector).
	self assert: list first first value equals: 'tseries'
]

{ #category : #tests }
RListTest >> testCreateListWithOneNamedElement [
	| list |
	list := (RList new: 1)
		addAt: 'repo' value: 'http://cran.rstudio.com/';
		yourself.
	self assert: (list first isKindOf: RStringVector).
	self assert: list first first value equals: 'http://cran.rstudio.com/'.
	self assert: (list at: 'repo') first value equals: 'http://cran.rstudio.com/'
]

{ #category : #tests }
RListTest >> testCreateListWithOneNilNamedElement [
	| list |
	list := RList new.
	list add: 'http://cran.rstudio.com/'.
	self assert: (list first isKindOf: RStringVector).
	self assert: list first first value equals: 'http://cran.rstudio.com/'.
	self should: [ list at: nil ] raise: NotFound
]

{ #category : #tests }
RListTest >> testCreateListWithTwoElementsOneNamedOneNot [
	| list |
	list := (RList new: 2)
		add: 'tseries';
		addAt: 'repo' value: 'http://cran.rstudio.com/';
		yourself.
	self assert: (list first isKindOf: RStringVector).
	self assert: list first first value equals: 'tseries'.
	self assert: (list second isKindOf: RStringVector).
	self assert: list second first value equals: 'http://cran.rstudio.com/'.
	self assert: (list at: 'repo') first value equals: 'http://cran.rstudio.com/'
]

{ #category : #tests }
RListTest >> testEmptyListShouldAreForbidden [
	self should: [ RList new: 0 ] raise: AssertionFailure description: 'The initial size should not be zero!'
]
