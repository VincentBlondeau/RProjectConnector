Class {
	#name : #RStringArray,
	#superclass : #NBExternalArray,
	#traits : 'TRHelpers + TRClassExtension',
	#classTraits : 'TRHelpers classTrait + TRClassExtension classTrait',
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RStringArray class >> initialize [
	self initElementType: 'RChar *'
]

{ #category : #initialization }
RStringArray >> initializeHandle [
	| handle |
	handle := NBExternalHandle new


	
]
