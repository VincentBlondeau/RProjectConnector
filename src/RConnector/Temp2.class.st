"
A RList class is a representation of a list of type VECEXP under R.
It is a kind of PairList. You can access it by key or by index, that is why it is a subclass of OrderedDictionary


"
Class {
	#name : #Temp2,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'handle'
	],
	#category : #'RConnector-Core'
}

{ #category : #'instance creation' }
Temp2 class >> createNewObjectFrom: aRObject [
	| instance |
	instance := self basicNew handle: aRObject handle.
	instance initialize.
	^ instance
]

{ #category : #'instance creation' }
Temp2 class >> new: size [
	| instance |
	instance := self primNew: size.
	instance initialize.
	^ instance

]
