"
A RIntVector is a RVector representing integers.
.
The array Type must be cached or a realsubclass for performance issues (Thx JB)
"
Class {
	#name : #RIntVector,
	#superclass : #RVector,
	#category : #'Zinc-HTTP-Logging'
}

{ #category : #'trait - function finding' }
RIntVector class >> arrayTypePrimitiveType [
	^ 'int'
]

{ #category : #accessing }
RIntVector class >> firstPointer [
	^ #int
]

{ #category : #'private - instance creation' }
RIntVector class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RIntVector Rf_allocVector (int type, int size))
]

{ #category : #accessing }
RIntVector class >> type [
	^ INTSXP
]

{ #category : #accessing }
RIntVector >> firstPointer [
	^ self int
]
