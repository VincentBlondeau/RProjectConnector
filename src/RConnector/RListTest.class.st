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
	 [1] ""coef""      ""sigma2""    ""var.coef""  ""mask""      ""loglik""    ""aic""       ""arma""     
	 [8] ""residuals"" ""call""      ""series""    ""code""      ""n.cond""    ""model""   

	$class
	[1] ""Arima""
"
	| arima attribs |
	arima := RFunction eval: 'arima' withParameters: { RIntVector new addAll: { 1 . 2 . 3 }; yourself }.
	self assert: (arima isKindOf: RList).
	self assert: (arima isObject).
	attribs := arima attributes.
	self assert: (attribs isKindOf: RRealList).
	self assert: attribs first name equals: 'names'.
	self assert: attribs second name equals: 'class'.
	self halt.
	self fail.
	
]

{ #category : #'as yet unclassified' }
RListTest >> testAccessAllElementsOfAList [
	| list |
	list := RList new: 0.
	self assert: list length equals:0
	
	
]

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
