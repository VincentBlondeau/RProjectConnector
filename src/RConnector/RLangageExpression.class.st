"
A RLangageExpression is a language based list.  It is identical to the list, but the results can be evaluated.

"
Class {
	#name : #RLangageExpression,
	#superclass : #RList,
	#instVars : [
		'size'
	],
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RLangageExpression class >> newEmptyChainedList [
	^ self new
		reset;
		yourself
]

{ #category : #'as yet unclassified' }
RLangageExpression class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RLangageExpression Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RLangageExpression class >> type [ 
	^ LANGSXP 
]

{ #category : #'as yet unclassified' }
RLangageExpression >> add: anElement [
	size = 0
		ifTrue: [ self setHandleFrom: (self prim_addFirst: anElement asPureRObject) ]
		ifFalse: [ 
			self setHandleFrom: (self prim_add: anElement asPureRObject).
			size := size + 1 ].
	^ anElement
]

{ #category : #'as yet unclassified' }
RLangageExpression >> eval [
	| res error |
	error := NBExternalHandle new.
	self length < 1
		ifTrue: [ CannotExecuteRemoteCall signal ].
	res := self primR_tryEval: self class R_GlobalEnv error: error.
	res protect.
	res ifNil: [ Error signal: self curErrorBuf ].
	^ res asRObject
	

]

{ #category : #'as yet unclassified' }
RLangageExpression >> primR_tryEval: env error: errorOccurred [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP R_tryEval(self,SEXP env, int * errorOccurred))
]

{ #category : #'as yet unclassified' }
RLangageExpression >> prim_add: anElement [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_lcons(SEXP anElement, self))

	
]

{ #category : #'as yet unclassified' }
RLangageExpression >> prim_add: anElement add: anOtherElement add: anThirdElement [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_lang3(SEXP anElement, SEXP anOtherElement, SEXP anThirdElement))

	
]

{ #category : #'as yet unclassified' }
RLangageExpression >> prim_addFirst: anElement [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_lang1(SEXP anElement))

	
]

{ #category : #'as yet unclassified' }
RLangageExpression >> reset [
	size := 0
]

{ #category : #'as yet unclassified' }
RLangageExpression >> setHandleFrom: aRObject [
	self handle: aRObject handle

]
