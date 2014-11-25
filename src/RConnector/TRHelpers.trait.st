"
A TRHelpers is a trait containing all the current function that can be used over a RObject.

"
Trait {
	#name : #TRHelpers,
	#traits : 'TRLibrary',
	#classTraits : 'TRLibrary classTrait',
	#category : #'RConnector-Core'
}

{ #category : #'library path' }
TRHelpers classSide >> Rf_findFun: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_findFun(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'library path' }
TRHelpers classSide >> Rf_install: aString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(const char * aString))
]

{ #category : #'as yet unclassified' }
TRHelpers classSide >> createNewObjectFrom: aRObject withClass: class [
	| instance |
	self halt.
	instance := class new: aRObject length.
	instance handle: aRObject handle.
	^ instance
]

{ #category : #'as yet unclassified' }
TRHelpers classSide >> findClassOf: aRObject [
	| type classes |
	type := aRObject prim_typeOf.
	classes := (RObject allSubclasses union: RVector allSubclasses)
		select: [ :c | [ c type = type ] onDNU: #type do: [ false ] ].
	classes size = 1
		ifFalse: [ Error signal ].	"detect should be used"
	^ classes first
]

{ #category : #'as yet unclassified' }
TRHelpers classSide >> findFun: aStringOfFunctionName [
	^ self Rf_findFun: (self Rf_install: aStringOfFunctionName) option: self R_GlobalEnv
]

{ #category : #'as yet unclassified' }
TRHelpers classSide >> getRObjectFromGlobalVariable: varName [
	^ RObject new  handle: (self nbGetGlobalVariable: varName)
]

{ #category : #'library path' }
TRHelpers classSide >> nbLibraryNameOrHandle [
 ^ #R
]

{ #category : #'as yet unclassified' }
TRHelpers classSide >> newFromRObject: aRObject [
	| class |
	class := self findClassOf: aRObject.
	^ self createNewObjectFrom: aRObject withClass: class
]

{ #category : #testing }
TRHelpers >> asPureRObject [
	^ self class createNewObjectFrom: self withClass: RObject
]

{ #category : #testing }
TRHelpers >> asRObject [
	^ self class newFromRObject: self 
]

{ #category : #'as yet unclassified' }
TRHelpers >> int [
	self isInteger ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_int
]

{ #category : #testing }
TRHelpers >> isComplex [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isComplex(self))
]

{ #category : #testing }
TRHelpers >> isEnvironment [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isEnvironment(self))
]

{ #category : #testing }
TRHelpers >> isExpression [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isExpression(self))
]

{ #category : #testing }
TRHelpers >> isInteger [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isInteger(self))
]

{ #category : #testing }
TRHelpers >> isList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isList(self))
]

{ #category : #testing }
TRHelpers >> isLogical [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isLogical(self))
]

{ #category : #testing }
TRHelpers >> isNull [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNull(self))
]

{ #category : #testing }
TRHelpers >> isNumber [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNumber(self))
]

{ #category : #testing }
TRHelpers >> isNumeric [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNumeric(self))
]

{ #category : #testing }
TRHelpers >> isObject [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isObject(self))
]

{ #category : #testing }
TRHelpers >> isPairList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isPairList(self))
]

{ #category : #testing }
TRHelpers >> isReal [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isReal(self))
]

{ #category : #testing }
TRHelpers >> isString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isString(self))
]

{ #category : #testing }
TRHelpers >> isSymbol [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isSymbol(self))
]

{ #category : #testing }
TRHelpers >> isValidString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isValidString(self))
]

{ #category : #testing }
TRHelpers >> isVector [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isVector(self))
]

{ #category : #testing }
TRHelpers >> isVectorList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isVectorList(self))
]

{ #category : #accessing }
TRHelpers >> length [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_length(self))
]

{ #category : #'library path' }
TRHelpers >> nbLibraryNameOrHandle [
 ^ self class nbLibraryNameOrHandle
]

{ #category : #private }
TRHelpers >> prim_int [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ (self
        nbCall: #(ulong INTEGER(self))) 
]

{ #category : #'as yet unclassified' }
TRHelpers >> prim_real [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong REAL(self))
]

{ #category : #private }
TRHelpers >> prim_typeOf [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int TYPEOF(self))
]

{ #category : #'as yet unclassified' }
TRHelpers >> print [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void Rf_PrintValue(self))
]

{ #category : #'as yet unclassified' }
TRHelpers >> protect [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_protect(self))
]

{ #category : #'as yet unclassified' }
TRHelpers >> raw [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(uchar RAW(self))
]

{ #category : #'as yet unclassified' }
TRHelpers >> real [
	self isReal ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_real
]

{ #category : #'as yet unclassified' }
TRHelpers >> typeOf [
	^ RLibTypes typeRelatedToNumber: self prim_typeOf

]

{ #category : #accessing }
TRHelpers >> types [
	^ RObject selectors select: [ :s | ((s beginsWith: #is) and: [ self perform: s ] )] 
]

{ #category : #'as yet unclassified' }
TRHelpers >> xlength [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_xlength(self))
]
