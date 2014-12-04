"
A RLangageExpression is a language based list.  It is like a linked chain and the results can be evaluated.
His type is LANGSXP under R.
A RLangageExpression as almost the same behaviour than a chained list under smallatalk.

Maybe it should extend the LinkedList class but it seems complicated to represents the cells of the list.


"
Class {
	#name : #RLangageExpression,
	#superclass : #RObject,
	#instVars : [
		'size'
	],
	#category : #'RConnector-Core'
}

{ #category : #'instance creation' }
RLangageExpression class >> newEmptyChainedList [
	^ self new
		reset;
		yourself
]

{ #category : #'private - instance creation' }
RLangageExpression class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RLangageExpression Rf_allocVector (int type, int size))
]

{ #category : #accessing }
RLangageExpression class >> type [ 
	^ LANGSXP 
]

{ #category : #adding }
RLangageExpression >> add: anElement [
	size = 0
		ifTrue: [ self transfertHandleFrom: (self prim_addFirst: anElement asPureRObject) ]
		ifFalse: [ 
			self transfertHandleFrom: (self prim_add: anElement asPureRObject).
			size := size + 1 ].
	^ anElement
]

{ #category : #adding }
RLangageExpression >> addAll: aCollection [
	aCollection do: [ :item | self add: item asRObject ]

]

{ #category : #evaluating }
RLangageExpression >> eval [
	| res error |
	error := NBExternalHandle new.
	self prim_length < 1
		ifTrue: [ CannotExecuteRemoteCall signal ].
	res := self prim_tryEval: self class R_GlobalEnv error: error.
	res ifNil: [ REvaluationError signal: self curErrorBuf ].
		res protect.
	^ res asRObject
	

]

{ #category : #accessing }
RLangageExpression >> first [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP CAR (self))
]

{ #category : #accessing }
RLangageExpression >> first: element [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SETCAR(self, SEXP element))

]

{ #category : #accessing }
RLangageExpression >> fourth [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP CADDDR(self))

]

{ #category : #accessing }
RLangageExpression >> fourth: anElement [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SETCADDDR(self, SEXP anElement))

]

{ #category : #'private - primitive' }
RLangageExpression >> prim_add: anElement [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_lcons(SEXP anElement, self))

	
]

{ #category : #'private - primitive' }
RLangageExpression >> prim_add: anElement add: anOtherElement add: anThirdElement [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_lang3(SEXP anElement, SEXP anOtherElement, SEXP anThirdElement))

	
]

{ #category : #'private - primitive' }
RLangageExpression >> prim_addFirst: anElement [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_lang1(SEXP anElement))

	
]

{ #category : #'private - primitive' }
RLangageExpression >> prim_tryEval: env error: errorOccurred [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP R_tryEval(self,SEXP env, int * errorOccurred))
]

{ #category : #private }
RLangageExpression >> reset [
	size := 0
]

{ #category : #accessing }
RLangageExpression >> second [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP CADR (self))
]

{ #category : #accessing }
RLangageExpression >> second: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SETCADR(self, SEXP element))

]

{ #category : #accessing }
RLangageExpression >> size [
	handle isNull ifTrue: [ ^ 0 ].
	^ self prim_length
]

{ #category : #accessing }
RLangageExpression >> tag [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP TAG (self))
]

{ #category : #accessing }
RLangageExpression >> third [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP CADDR (self))
]

{ #category : #accessing }
RLangageExpression >> third: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SETCADDR(self, SEXP element))

]

{ #category : #private }
RLangageExpression >> transfertHandleFrom: aRObject [
	self handle: aRObject handle

]
