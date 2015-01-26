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

{ #category : #initialize }
RFunction class >> eval: aString withParameters: aCollection [
	^ (self functionName: aString parameters: aCollection) eval
]

{ #category : #initialize }
RFunction class >> functionName: aString parameters: aCollection [
	^ self new functionName: aString; parameters: aCollection; yourself
]

{ #category : #private }
RFunction >> argsSize [
	^ self parameters size + 1
]

{ #category : #private }
RFunction >> checkParameters [
	self functionName isNotNil
		ifFalse: [ CannotExecuteRemoteCall signal ].
	(self parameters isNotNil and: [ self parameters isNotEmpty ])
		ifFalse: [ CannotExecuteRemoteCall signal ].
	"a check that the arguments contains only RObject should be done"
]

{ #category : #private }
RFunction >> createLangageExpression [
	| expression |
	expression := RLangageExpression new: self argsSize.
	expression add: self functionName.	"Hack because we cannot access a list by the item number"
	1 to: self parameters size do: [ :index | expression add: (self parameters at: index) asPureRObject ].
	^ expression
]

{ #category : #evaluating }
RFunction >> eval [
	^ self getLangageExpression eval

]

{ #category : #accessing }
RFunction >> functionName [
	^ RObject findFun: functionName
]

{ #category : #accessing }
RFunction >> functionName: aString [
	functionName := aString
]

{ #category : #private }
RFunction >> getLangageExpression [
	self checkParameters.
	^ self createLangageExpression

]

{ #category : #accessing }
RFunction >> parameters [
	^ parameters
]

{ #category : #accessing }
RFunction >> parameters: aCollection [
	parameters := aCollection
]
