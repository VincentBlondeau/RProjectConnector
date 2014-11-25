Class {
	#name : #RLangageExpression,
	#superclass : #RList,
	#category : #'RConnector-Core'
}

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
RLangageExpression >> eval [
	| res |
	self length < 1
		ifTrue: [ CannotExecuteRemoteCall signal ].
	res := self primR_tryEval: self class R_GlobalEnv error: NBExternalAddress null.
	^ res asRObject
]

{ #category : #'as yet unclassified' }
RLangageExpression >> primR_tryEval: env error: errorOccurred [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP R_tryEval(self,SEXP env, int * errorOccurred))
]
