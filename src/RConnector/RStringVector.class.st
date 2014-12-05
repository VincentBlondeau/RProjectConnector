"
A RStringVector  is a RVector representing strings.

"
Class {
	#name : #RStringVector,
	#superclass : #RVector,
	#category : #'RConnector-Core'
}

{ #category : #private }
RStringVector class >> arrayType [
	^ RStringArray 
]

{ #category : #accessing }
RStringVector class >> firstPointer [
	^ #string
]

{ #category : #'private - instance creation' }
RStringVector class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RStringVector Rf_allocVector (int type, int size))
]

{ #category : #'private - instance creation' }
RStringVector class >> primNewFromString: aString [ 
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RStringVector Rf_mkString(String aString))
]

{ #category : #accessing }
RStringVector class >> type [
	^ STRSXP
]

{ #category : #accessing }
RStringVector >> at: index [
	(index between: 0 and: self size)
		ifFalse: [ ^ self errorSubscriptBounds: index ].
	^ (self prim_stringElementAt: index - 1) prim_char
]

{ #category : #evaluating }
RStringVector >> do: aBlock [ 
	| index |
	index := firstIndex.
	[index <= lastIndex]
		whileTrue: 
			[aBlock value: (self at: index).
			index := index + 1]
]

{ #category : #accessing }
RStringVector >> first [ 
	^ self at: 1
]

{ #category : #private }
RStringVector >> firstPointer [
	^ self string
]

{ #category : #accessing }
RStringVector >> second [
	^ self at: 2
]

{ #category : #accessing }
RStringVector >> size [
	^ super size
	"^ self prim_length"
]

{ #category : #evaluating }
RStringVector >> value [
	^ (self prim_stringElementAt: 0) prim_char
]
