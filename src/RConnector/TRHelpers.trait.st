"
A TRHelpers is a trait containing all the current function that can be used over any RObject.

The primitives should NOT be used directly unless you want to crash your image...

By the way, if you want to create a new primitive containing a String. Convert all 'char * ' into 'String'. because the String are null ternimated and 'char*' are not in every case
"
Trait {
	#name : #TRHelpers,
	#traits : 'TRLibrary + TRGlobals',
	#classTraits : 'TRLibrary classTrait + TRGlobals classTrait',
	#category : #'RConnector-Core'
}

{ #category : #'trait - instance creation' }
TRHelpers classSide >> createNewObjectFrom: aRObject [ 
	| instance  |
	instance := self new: aRObject prim_length.
	instance handle: aRObject handle.
	^ instance
]

{ #category : #'trait - library path' }
TRHelpers classSide >> ffiLibraryNameOrHandle [
	^ #R
]

{ #category : #'trait - function finding' }
TRHelpers classSide >> findClassOf: aRObject [
	| type  |
	type := aRObject prim_typeOf.
	^ RLibTypes implementationClassRelatedTo: type
]

{ #category : #'trait - function finding' }
TRHelpers classSide >> findFun: aStringOfFunctionName [
	^ self prim_findFun: (self prim_install: aStringOfFunctionName) option: self rGlobalEnv
]

{ #category : #'trait - function finding' }
TRHelpers classSide >> findVar: aStringOfFunctionName [
	^ self prim_findVar: (self prim_install: aStringOfFunctionName) option: self rGlobalEnv
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

{ #category : #'trait - private primitives' }
TRHelpers classSide >> prim_findFun: aNBSEXPfunction option: aNbSEXPoption [
    
    ^ self
        ffiCall: #(SEXP Rf_findFun(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'trait - private primitives' }
TRHelpers classSide >> prim_findVar: aNBSEXPfunction option: aNbSEXPoption [
    
    ^ self
        ffiCall: #(SEXP Rf_findVar(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'trait - private primitives' }
TRHelpers classSide >> prim_install: aString [
    
    ^ self
        ffiCall: #(SEXP Rf_install(String aString))
]

{ #category : #'trait - private primitives' }
TRHelpers classSide >> prim_isBasicClass: aString [
    
    ^ self
        ffiCall: #(int Rf_isBasicClass(String aString))
]

{ #category : #'trait - global variables' }
TRHelpers classSide >> rClassSymbol [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_ClassSymbol
]

{ #category : #'trait - global variables' }
TRHelpers classSide >> rDimSymbol [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_DimSymbol
]

{ #category : #'trait - converting' }
TRHelpers >> asPureRObject [
	^ RObject createNewObjectFrom: self 
]

{ #category : #'trait - converting' }
TRHelpers >> asRObject [
	^ self class newFromRObject: self 
]

{ #category : #'trait - converting' }
TRHelpers >> char [
	self isChar
		ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_char
]

{ #category : #'trait - variable definition' }
TRHelpers >> defineAsVarNamed: aRName [
	self assert: (aRName isKindOf: Symbol).	"Should be removed if the type is checked in the primitive"
	^ self defineAsVarNamed: aRName inEnv: self class rGlobalEnv 
]

{ #category : #'trait - variable definition' }
TRHelpers >> defineAsVarNamed: aRName inEnv: anEnvironment [
	^ self prim_defineAsVarNamed: aRName asRObject inEnv: anEnvironment
]

{ #category : #accessing }
TRHelpers >> dim [
	^ (self prim_attributeAt: self class rDimSymbol) asRObject
]

{ #category : #'trait - library path' }
TRHelpers >> ffiLibraryName [
 ^ self class ffiLibraryNameOrHandle
]

{ #category : #'trait - converting' }
TRHelpers >> int [
	(self typeOf = #INTSXP or: [ self isInteger ])
		ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_int
]

{ #category : #'trait - testing' }
TRHelpers >> isChar [
	^ self typeOf = #CHARSXP
  
]

{ #category : #'trait - testing' }
TRHelpers >> isComplex [
	^ self ffiCall: #(bool Rf_isComplex #(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isEnvironment [
	^ self ffiCall: #(bool Rf_isEnvironment #(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isExpression [
	^ self ffiCall: #(bool Rf_isExpression #(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isInteger [
	^ self ffiCall: #(bool Rf_isInteger #(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isList [
	^ self ffiCall: #(bool Rf_isList #(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isLogical [
	^ self ffiCall: #(bool Rf_isLogical #(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isMatrix [
	^ self ffiCall: #(bool Rf_isMatrix #(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isNumber [
    
    ^ self
        ffiCall: #(bool Rf_isNumber(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isNumeric [
    
    ^ self
        ffiCall: #(bool Rf_isNumeric(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isObject [
    
    ^ self
        ffiCall: #(bool Rf_isObject(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isPairList [
    
    ^ self
        ffiCall: #(bool Rf_isPairList(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isRNull [
    
    ^ self
        ffiCall: #(bool Rf_isNull(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isReal [
    
    ^ self
        ffiCall: #(bool Rf_isReal(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isS4Object [
	"int (IS_S4_OBJECT)(SEXP x); -> bool because it is the same in C"
    
    ^ self
        ffiCall: #(bool IS_S4_OBJECT(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isString [
    
    ^ self
        ffiCall: #(bool Rf_isString(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isSymbol [
    
    ^ self
        ffiCall: #(bool Rf_isSymbol(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isValidString [
    
    ^ self
        ffiCall: #(bool Rf_isValidString(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isVector [
    
    ^ self
        ffiCall: #(bool Rf_isVector(self))
]

{ #category : #'trait - testing' }
TRHelpers >> isVectorList [
    
    ^ self
        ffiCall: #(bool Rf_isVectorList(self))
]

{ #category : #'trait - converting' }
TRHelpers >> logical [
	self isLogical ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_logical
]

{ #category : #'private - primitive' }
TRHelpers >> prim_attributeAt: attributeName [
	
	^ self ffiCall: #(SEXP Rf_getAttrib(self, SEXP attributeName))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_char [
    
    ^ self
        ffiCall: #(String R_CHAR(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_copyVectorFrom: anOldString [
    
    ^ self
        ffiCall: #(void Rf_copyVector(SEXP self, SEXP anOldString))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_curErrorBuf [
	^ self ffiCall: #(String R_curErrorBuf #())
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_defineAsVarNamed: name inEnv: anEnvironment [ 
    
    ^ self
        ffiCall: #(void Rf_defineVar(SEXP name, self, SEXP anEnvironment))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_dimgets: val [
    
    ^ self
        ffiCall: #(SEXP Rf_dimgets(self, SEXP val))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_dimnamesgets: val [
    
    ^ self
        ffiCall: #(SEXP Rf_dimnamesgets(self, SEXP val))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_getArrayDimnames [
    
    ^ self
        ffiCall: #(SEXP Rf_GetArrayDimnames(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_int [
    
    ^ (self
        ffiCall: #(ulong INTEGER(self))) 
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_length [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        ffiCall: #(int Rf_length(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_list_ptr [
    
    ^ self
        ffiCall: #(ulong LIST_POINTER(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_logical [
    
    ^ self
        ffiCall: #(ulong LOGICAL(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_named [
	"int -> bool because it is the same in C"
    
    ^ self
        ffiCall: #(bool NAMED(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_ncols [
	"No type testing ...Should only use on the right type (Matrix)"
    
    ^ self
        ffiCall: #(int Rf_ncols(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_nrows [
	"No type testing ...Should only use on the right type (Matrix)"

	^ self ffiCall: #(int Rf_nrows #(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_real [
    
    ^ self
        ffiCall: #(ulong REAL(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_setVectorElement: element at: index [
	^ self
		ffiCall: #(SEXP SET_VECTOR_ELT #(self , int index , SEXP element))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_stringElementAt: index [
	^ self ffiCall: #(SEXP STRING_ELT #(self , int index))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_string_ptr [
	^ self ffiCall: #(ulong STRING_PTR #(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_symbolValue [
	^ self ffiCall: #(SEXP SYMVALUE #(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_typeOf [
	^ self ffiCall: #(int TYPEOF #(self))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_vectorElementAt: index [
	^ self ffiCall: #(SEXP VECTOR_ELT #(self , int index))
]

{ #category : #'trait - private primitives' }
TRHelpers >> prim_vector_ptr [
	self error: 'Must not be used !'.
	^ self ffiCall: #(ulong VECTOR_PTR #(self))
]

{ #category : #'trait - not used' }
TRHelpers >> prim_xlength [
	^ self ffiCall: #(int Rf_xlength #(self))
]

{ #category : #'trait - not used' }
TRHelpers >> print [
	^ self ffiCall: #(void Rf_PrintValue #(self))
]

{ #category : #'trait - memory protection' }
TRHelpers >> protect [
    
    ^ self
        ffiCall: #(SEXP Rf_protect(self))
]

{ #category : #accessing }
TRHelpers >> rClass [
	^ (self prim_attributeAt: self class rClassSymbol) asRObject
]

{ #category : #'trait - not used' }
TRHelpers >> raw [
    
    ^ self
        ffiCall: #(uchar RAW(self))
]

{ #category : #'trait - converting' }
TRHelpers >> real [
	self isReal ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_real
]

{ #category : #'trait - converting' }
TRHelpers >> string [
	self isString
		ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_string_ptr
]

{ #category : #'trait - accessing' }
TRHelpers >> typeOf [
	^ RLibTypes typeRelatedToNumber: self prim_typeOf

]

{ #category : #'trait - accessing' }
TRHelpers >> types [
	^ RObject selectors select: [ :s | ((s beginsWith: #is) and: [ self perform: s ] )] 
]

{ #category : #'trait - converting' }
TRHelpers >> vector [
	self error: 'Must not be used ! Not supported in the latest version.'.
	"A vector_ptr function exists but doesn't work on vectors..... So we use the string one."
	self halt.
	self isVector
		ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_vectorElementAt: 0
]
