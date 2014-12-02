"
A RLangageExpression is a language based list.  It is like a linked chain and the results can be evaluated.
A RList class is a representation of a list of type LANGSXP under R.
"
Class {
	#name : #RLangageExpression,
	#superclass : #RCollection,
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

{ #category : #temp }
RLangageExpression class >> primR_tryEval: anobject env: env error: errorOccurred [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP R_tryEval(SEXP anobject,SEXP env, int * errorOccurred))
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
	self prim_length < 1
		ifTrue: [ CannotExecuteRemoteCall signal ].
	res := self primR_tryEval: self class R_GlobalEnv error: error.
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
        nbCall: #(RObject SETCAR(self, SEXP element))

]

{ #category : #'as yet unclassified' }
RLangageExpression >> fourth [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(RList CADDDR(RList self, SEXP element))

]

{ #category : #'as yet unclassified' }
RLangageExpression >> fourth: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SETCADDDR(self, SEXP element))

]

{ #category : #'as yet unclassified' }
RLangageExpression >> hop [
"SEXP (TAG)(SEXP e);
SEXP (CAR)(SEXP e);
SEXP (CDR)(SEXP e);
SEXP (CAAR)(SEXP e);
SEXP (CDAR)(SEXP e);
SEXP (CADR)(SEXP e);
SEXP (CDDR)(SEXP e);
SEXP (CADDR)(SEXP e);
SEXP (CADDDR)(SEXP e);
SEXP (CAD4R)(SEXP e);
int  (MISSING)(SEXP x);
void (SET_MISSING)(SEXP x, int v);
void SET_TAG(SEXP x, SEXP y);
SEXP SETCAR(SEXP x, SEXP y);
SEXP SETCDR(SEXP x, SEXP y);
SEXP SETCADR(SEXP x, SEXP y);
SEXP SETCADDR(SEXP x, SEXP y);
SEXP SETCADDDR(SEXP x, SEXP y);
SEXP SETCAD4R(SEXP e, SEXP y);
"
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
RLangageExpression >> second [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP CADR (self))
]

{ #category : #'as yet unclassified' }
RLangageExpression >> second: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SETCADR(self, SEXP element))

]

{ #category : #'as yet unclassified' }
RLangageExpression >> setHandleFrom: aRObject [
	self handle: aRObject handle

]

{ #category : #'as yet unclassified' }
RLangageExpression >> size [
	handle isNull ifTrue: [ ^ 0 ].
	^ self prim_length
]

{ #category : #'as yet unclassified' }
RLangageExpression >> tag [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP TAG (self))
]

{ #category : #'as yet unclassified' }
RLangageExpression >> third [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP CADDR (self))
]

{ #category : #'as yet unclassified' }
RLangageExpression >> third: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SETCADDR(self, SEXP element))

]
