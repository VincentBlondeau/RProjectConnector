Class {
	#name : #RFunction,
	#superclass : #RLangageElement,
	#instVars : [
		'parameters'
	],
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
RFunction >> argsSize [
	^ self parameters size + 1
]

{ #category : #'as yet unclassified' }
RFunction >> checkParameters [
	self functionName isNotNil
		ifFalse: [ CannotExecuteRemoteCall signal ].
	(self parameters isNotNil and: [ self parameters isNotEmpty ])
		ifFalse: [ CannotExecuteRemoteCall signal ].
	"a check that the arguments contains only RObject should be done"
]

{ #category : #'as yet unclassified' }
RFunction >> createLangageExpression [
	| expression |
	expression := RLangageExpression new: self argsSize.
	expression first: self functionName.	"Hack because we cannot access a list by the item number"
	self parameters size >= 1
		ifTrue: [ expression second: self parameters first asPureRObject ].
	self parameters size >= 2
		ifTrue: [ expression third: self parameters second asPureRObject ].
	self parameters size >= 3
		ifTrue: [ expression fourth: self parameters third asPureRObject ].
	^ expression 
]

{ #category : #'as yet unclassified' }
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

{ #category : #initialize }
RFunction >> functionName: aString parameters: aCollection [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
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