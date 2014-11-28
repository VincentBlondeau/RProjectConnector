"
A TRHelpers is a trait containing all the current function that can be used over any RObject.

The primitives should NOT be used directly unless you want to crash your image...

By the way, if you want to create a new primitive containing a String. Convert all 'char * ' into 'String'. because the String are null ternimated and 'char*' are not in every case
"
Trait {
	#name : #TRHelpers,
	#traits : 'TRLibrary',
	#classTraits : 'TRLibrary classTrait',
	#category : #'RConnector-Core'
}

{ #category : #'trait - private primitives' }
TRHelpers classSide >> Rf_findFun: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_findFun(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'trait - private primitives' }
TRHelpers classSide >> Rf_findVar: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_findVar(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'trait - private primitives' }
TRHelpers classSide >> Rf_install: aString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(String aString))
]

{ #category : #'as yet unclassified' }
TRHelpers classSide >> Rf_isBasicClass: aString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_isBasicClass(String aString))
]

{ #category : #'as yet unclassified' }
TRHelpers classSide >> SYMVALUE [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP (SYMVALUE)(self))
]

{ #category : #'trait - instance creation' }
TRHelpers classSide >> createNewObjectFrom: aRObject withClass: class [
	| instance |
	instance := class new: aRObject length.
	instance handle: aRObject handle.
	^ instance
]

{ #category : #'trait - function finding' }
TRHelpers classSide >> findClassOf: aRObject [
	| type classes |
	type := aRObject prim_typeOf.
	classes := (RObject allSubclasses union: RVector allSubclasses)
		select: [ :c | [ c type = type ] onDNU: #type do: [ false ] ].
	classes size = 1
		ifFalse: [ Error signal ].	"detect should be used"
	^ classes first
]

{ #category : #'trait - function finding' }
TRHelpers classSide >> findFun: aStringOfFunctionName [
	^ self Rf_findFun: (self Rf_install: aStringOfFunctionName) option: self R_GlobalEnv
]

{ #category : #'trait - function finding' }
TRHelpers classSide >> getRObjectFromGlobalVariable: varName [
	^ RObject new handle: (self nbGetGlobalVariable: varName)
]

{ #category : #'trait - instance creation' }
TRHelpers classSide >> newFromRObject: aRObject [
	| class |
	class := self findClassOf: aRObject.
	^ class createNewObjectFrom: aRObject 
]

{ #category : #'trait - testing' }
TRHelpers >> SYMVALUE [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SYMVALUE(self))
]

{ #category : #'trait - converting' }
TRHelpers >> asPureRObject [
	^ RObject createNewObjectFrom: self 
]

{ #category : #'trait - converting' }
TRHelpers >> asRObject [
	^ self class newFromRObject: self 
]

{ #category : #'as yet unclassified' }
TRHelpers >> char [
	self isString ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_char
]

{ #category : #'as yet unclassified' }
TRHelpers >> curErrorBuf [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(String R_curErrorBuf())
]

{ #category : #'trait - converting' }
TRHelpers >> int [
	self isInteger ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_int
]

{ #category : #'trait - testing' }
TRHelpers >> isComplex [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isComplex(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isEnvironment [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isEnvironment(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isExpression [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isExpression(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isInteger [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isInteger(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isList(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isLogical [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isLogical(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isNull [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNull(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isNumber [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNumber(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isNumeric [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNumeric(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isObject [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isObject(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isPairList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isPairList(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isReal [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isReal(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isString(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isSymbol [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isSymbol(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isValidString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isValidString(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isVector [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isVector(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isVectorList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isVectorList(self))
]

{ #category : #'trait - accessing' }
TRHelpers >> length [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_length(self))
]

{ #category : #'trait - converting' }
TRHelpers >> logical [
	self isLogical ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_logical
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_char [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(String R_CHAR(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_int [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ (self
        nbCall: #(ulong INTEGER(self))) 
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_logical [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong LOGICAL(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_real [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong REAL(self))
]

{ #category : #'as yet unclassified' }
TRHelpers >> prim_string_elm: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP STRING_ELT(self, int index))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_typeOf [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int TYPEOF(self))
]

{ #category : #'trait - not used' }
TRHelpers >> print [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void Rf_PrintValue(self))
]

{ #category : #'trait - memory protection' }
TRHelpers >> protect [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_protect(self))
]

{ #category : #'trait - not used' }
TRHelpers >> raw [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(uchar RAW(self))
]

{ #category : #'trait - converting' }
TRHelpers >> real [
	self isReal ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_real
]

{ #category : #'trait - accessing' }
TRHelpers >> typeOf [
	^ RLibTypes typeRelatedToNumber: self prim_typeOf

]

{ #category : #'trait - accessing' }
TRHelpers >> types [
	^ RObject selectors select: [ :s | ((s beginsWith: #is) and: [ self perform: s ] )] 
]

{ #category : #'trait - accessing' }
TRHelpers >> xlength [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_xlength(self))
]
