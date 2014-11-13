Class {
	#name : #RList,
	#superclass : #RObject,
	#traits : 'TRLibrary',
	#classTraits : 'TRLibrary classTrait',
	#pools : [
		'RLibTypes'
	],
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
RList class >> new: size [
	^ self primNew: size type: LANGSXP
]

{ #category : #'as yet unclassified' }
RList class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RList #Rf_allocVector #(#int #type #, #int #size))
]

{ #category : #'as yet unclassified' }
RList >> first [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(#RObject #CAR #(#RList #self))	"SEXP (TAG)(SEXP e);
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
RList >> setFirst: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(RList SETCAR(RList self, SEXP element))
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
RList >> setSecond: element [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(RList SETCADR(RList self, SEXP element))

]
