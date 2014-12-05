"
A RLibTypes class is contains the principal variables to manage R objects.
The equivalence between the number of the type given by prim_typeOf and the related symbol is stored in initializeObjectTypes.

If you want to implement a not-aleready implemented class in RConnector, you should modify dictionaryOfImplementationClass to have the automatic object transformation when the asRObject is called.

RObject is the default type.
"
Class {
	#name : #RLibTypes,
	#superclass : #SharedPool,
	#classVars : [
		'ANYSXP',
		'BCODESXP',
		'BUILTINSXP',
		'CHARSXP',
		'CLOSXP',
		'CPLXSXP',
		'DOTSXP',
		'ENVSXP',
		'EXPRSXP',
		'EXTPTRSXP',
		'INTSXP',
		'LANGSXP',
		'LGLSXP',
		'LISTSXP',
		'NILSXP',
		'PROMSXP',
		'RAWSXP',
		'REALSXP',
		'S4SXP',
		'SEXP',
		'SPECIALSXP',
		'STRSXP',
		'SYMSXP',
		'VECSXP',
		'WEAKREFSXP'
	],
	#category : #'RConnector-Core'
}

{ #category : #accesing }
RLibTypes class >> dictionaryOfImplementationClass [
	^ { 
	NILSXP -> RNilValue.	"NULL"
	SYMSXP -> RSymbol.	"symbols"
	LISTSXP -> RObject."pairlists"
	CLOSXP -> RObject.	"closures"
	ENVSXP -> RObject.	"environments"
	PROMSXP -> RObject."promises"
	LANGSXP -> RLangageExpression."language objects"
	SPECIALSXP -> RObject."special functions"
	BUILTINSXP -> RObject."builtin functions"
	CHARSXP -> RChar."to confirm""internal character strings"
	LGLSXP -> RBoolVector."logical vectors"
	INTSXP -> RIntVector."integer vectors"
	REALSXP -> RDoubleVector."numeric vectors"
	CPLXSXP -> RObject."complex vectors"
	STRSXP -> RStringVector."character vectors"
	DOTSXP -> RObject."dot-dot-dot object"
	ANYSXP -> RObject."make “any” args work"
	VECSXP -> RList."list (generic vector)"
	EXPRSXP -> RObject."	expression vector"
	BCODESXP -> RObject.	"byte code"
	EXTPTRSXP -> RObject."external pointer"
	WEAKREFSXP -> RObject."weak reference"
	RAWSXP -> RObject."raw vector"
	S4SXP -> RObject"S4 classes not of simple type"
	} asDictionary
]

{ #category : #'retrieving symbols' }
RLibTypes class >> implementationClassRelatedTo: index [
	^ self dictionaryOfImplementationClass at: index ifAbsent: [ self error: 'All the types are already referenced !' ]
]

{ #category : #'class initialization' }
RLibTypes class >> initialize [
	SEXP := #RObject.
	self initializeObjectTypes
]

{ #category : #initialization }
RLibTypes class >> initializeObjectTypes [
	NILSXP := 0.	"NULL"
	SYMSXP := 1.	"symbols"
	LISTSXP := 2."pairlists"
	CLOSXP := 3.	"closures"
	ENVSXP := 4.	"environments"
	PROMSXP := 5."promises"
	LANGSXP := 6."language objects"
	SPECIALSXP := 7."special functions"
	BUILTINSXP := 8."builtin functions"
	CHARSXP := 9."internal character strings"
	LGLSXP := 10."logical vectors"
	INTSXP := 13."integer vectors"
	REALSXP := 14."numeric vectors"
	CPLXSXP := 15."complex vectors"
	STRSXP := 16."character vectors"
	DOTSXP := 17."dot-dot-dot object"
	ANYSXP := 18."make “any” args work"
	VECSXP := 19."list (generic vector)"
	EXPRSXP := 20."	expression vector"
	BCODESXP := 21.	"byte code"
	EXTPTRSXP := 22."external pointer"
	WEAKREFSXP := 23."weak reference"
	RAWSXP := 24."raw vector"
	S4SXP := 25"S4 classes not of simple type"
]

{ #category : #'retrieving symbols' }
RLibTypes class >> typeRelatedToNumber: index [
	^ self classVarNames detect: [ :classvarname | (self classVarNamed: classvarname) = index ]

]
