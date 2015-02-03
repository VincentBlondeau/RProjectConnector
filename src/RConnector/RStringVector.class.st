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

{ #category : #enumerating }
RStringVector >> do: aBlock [ 
	| index |
	index := firstIndex.
	[index <= lastIndex]
		whileTrue: 
			[aBlock value: (self at: index).
			index := index + 1]
]

{ #category : #accessing }
RStringVector >> firstPointer [
	^ self string
]

{ #category : #evaluating }
RStringVector >> growAtLast [
	"overridden to create external objects"

	"We should recreate a new instance because there is no reallocation in the RAPI. So we swap the handles"

	"Protect and unprotect methods should be added too"

	| newArray size |
	size := array size * 2 max: 1.	"newInstance := self class primNew: size.
	self handle: newInstance handle."
	newArray := self class arrayType new: size.
	newArray
		replaceFrom: firstIndex
		to: lastIndex
		with: array
		startingAt: firstIndex.
		self halt.
	array := newArray
]

{ #category : #evaluating }
RStringVector >> value [
	^ (self prim_stringElementAt: 0) prim_char
]
