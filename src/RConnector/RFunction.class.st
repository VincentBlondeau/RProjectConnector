Class {
	#name : #RFunction,
	#superclass : #Object,
	#instVars : [
		'functionName',
		'parameters'
	],
	#category : #'RConnector-Core'
}

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
RFunction >> createAndExecuteLangageExpression [
	| expression |
	expression := RLangageExpression new: self argsSize.
	expression first: self functionName.	"Hack because we cannot access a list by the item number"
	self parameters size >= 1
		ifTrue: [ expression second: self parameters first asPureRObject ].
	self parameters size >= 2
		ifTrue: [ expression third: self parameters second asPureRObject ].
	self parameters size >= 3
		ifTrue: [ expression fourth: self parameters third asPureRObject ].
	^ expression eval
]

{ #category : #'as yet unclassified' }
RFunction >> eval [
	self checkParameters.
	^ self createAndExecuteLangageExpression
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

{ #category : #accessing }
RFunction >> parameters [
	^ parameters
]

{ #category : #accessing }
RFunction >> parameters: aCollection [
	parameters := aCollection
]
