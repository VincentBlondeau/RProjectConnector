"
A RStringVector  is a RVector representing strings.

"
Class {
	#name : #RStringVector,
	#superclass : #RVector,
	#category : #'Zinc-HTTP-Logging'
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
RStringVector class >> newFromString: aString [
	| instance |
	instance := self primNewFromString: aString.
	instance setCollection: (self arrayType onAddress: (NBExternalAddress value: instance firstPointer) size: 1).
	instance resetToExternalCollection.
	^ instance
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

{ #category : #adding }
RStringVector >> addLast: anElement [
	super addLast: anElement asRChar.
	^ anElement
]

{ #category : #accessing }
RStringVector >> at: index [
	(index between: 0 and: self size)
		ifFalse: [ ^ self errorSubscriptBounds: index ].
	^ (array at: index) value
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
RStringVector >> value [
	^ (self prim_stringElementAt: 0) prim_char
]
