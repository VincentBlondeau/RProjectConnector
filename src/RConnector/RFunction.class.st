"
A RFunction is a function that is detached of the R external library. Only the 'eval' method do the creation of a RLangageExpression and execute it.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
NB: If the function doesn't exist in the R environment, the image will crash...
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Instance Variables
	parameters:		anOrderedCollection
	functionName: 	aString

parameters
	- the elements that will be in parameter of the function. For now, the function cannot use named arguments (list should be implemented).
	
functionName
	- the name of the function to evaluate

"
Class {
	#name : #RFunction,
	#superclass : #Object,
	#instVars : [
		'parameters',
		'parameterList',
		'functionName'
	],
	#category : #'RConnector-Core'
}

{ #category : #evaluating }
RFunction class >> eval: aString [
	^ self new
		functionName: aString;
		parameters: #();
		eval
]

{ #category : #evaluating }
RFunction class >> eval: aString withListParameter: anOrderedCollection [
	^ (self functionName: aString parameterList: anOrderedCollection) eval
]

{ #category : #evaluating }
RFunction class >> eval: aString withParameters: aCollection [
	^ (self functionName: aString parameters: aCollection) eval
]

{ #category : #initialize }
RFunction class >> examplePlot [
	'plot'
		asRListEval:
			{(0 to: 50).
			(50 to: 100).
			('type' -> 'l').
			('col' -> 'grey80').
			('xaxt' -> 'n').
			('lwd' -> '2').
			('xlab' -> '').
			('ylab' -> 'Temperature°C').
			('main' -> 'fig.5 - Trend component')}
]

{ #category : #initialize }
RFunction class >> functionName: aString parameterList: aCollection [
	^ self new
		functionName: aString;
		parameterList: aCollection;
		yourself
]

{ #category : #initialize }
RFunction class >> functionName: aString parameters: aCollection [
	^ self new
		functionName: aString;
		parameters: aCollection;
		yourself
]

{ #category : #private }
RFunction >> argsSize [
	^ self parameters size + 1
]

{ #category : #private }
RFunction >> checkParameters [
	(self parameters isNotNil and: [ self parameters isNotEmpty ])
		ifFalse: [ CannotExecuteRemoteCall signal ]	"a check that the arguments contains only RObject should be done"
]

{ #category : #private }
RFunction >> createLangageExpression [
	| expression |
	expression := RLangageExpression new: self argsSize.
	expression add: self functionName.	"Hack because we cannot access a list by the item number"
	1 to: self parameters size do: [ :index | expression add: (self parameters at: index) asPureRObject ].
	^ expression
]

{ #category : #private }
RFunction >> createList [
	| list |
	list := RList new: self parameterList size.
	self parameterList
		do: [ :item | 
			item isVariableBinding
				ifFalse: [ list add: item ]
				ifTrue: [ list addAt: item key value: item value ] ].
	^ list
]

{ #category : #evaluating }
RFunction >> eval [
	self functionName ifNil: [ CannotExecuteRemoteCall signal ].
	self parameters
		ifNotNil: [ 
			self parameters ifEmpty: [ CannotExecuteRemoteCall signal ].
			^ self createLangageExpression eval ].
	self parameterList ifNotNil: [ ^ self createList evalWithFunction: functionName ].
	CannotExecuteRemoteCall signal
]

{ #category : #accessing }
RFunction >> functionName [
	^ RObject findFun: functionName
]

{ #category : #accessing }
RFunction >> functionName: aString [
	functionName := aString
]

{ #category : #accessing }
RFunction >> parameterList [
	^ parameterList
]

{ #category : #accessing }
RFunction >> parameterList: anObject [
	parameterList := anObject
]

{ #category : #accessing }
RFunction >> parameters [
	^ parameters
]

{ #category : #accessing }
RFunction >> parameters: aCollection [
	parameters := aCollection
]
