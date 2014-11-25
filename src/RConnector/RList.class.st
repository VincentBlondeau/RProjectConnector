"
A RList class is a representation of a list of type LANGSXP under R.
It is a kind of PairList
"
Class {
	#name : #RList,
	#superclass : #RCollection,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RList class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RList Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RList class >> type [
	^ VECSXP
]

{ #category : #'as yet unclassified' }
RList >> first [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(#RObject #CAR #(#RList #self))
]

{ #category : #'as yet unclassified' }
RList >> first: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(RList SETCAR(RList self, SEXP element))

]

{ #category : #'as yet unclassified' }
RList >> fourth [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(RList CADDDR(RList self, SEXP element))

]

{ #category : #'as yet unclassified' }
RList >> fourth: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(RList SETCADDDR(RList self, SEXP element))

]

{ #category : #'as yet unclassified' }
RList >> hop [
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
RList >> second [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RObject CADR (self))
]

{ #category : #'as yet unclassified' }
RList >> second: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(RList SETCADR(RList self, SEXP element))

]

{ #category : #'as yet unclassified' }
RList >> third [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RObject CADDR (self))
]

{ #category : #'as yet unclassified' }
RList >> third: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(RList SETCADDR(RList self, SEXP element))

]
