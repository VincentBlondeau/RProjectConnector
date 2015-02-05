"
A RObject is a standard object linked to a R external element. It is the SEXP type of R (a binding is done in RLibType (to see for details)).
|----------------------------------------------------------------------------------------------------------|
| !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Warning!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! |
|  As a external library is used, you should NOT use method primitives directly      |
|  except if they are not predecessed by 'prim_'.                                                                    | 
| By the way, you can use them for debugging, but at your own risks!                         |
|----------------------------------------------------------------------------------------------------------|

The handles are freed at each startup of the image. So you have to recreate the object if you want to continue to use it.

Why this type is it need?
---------------------------------
It is this kind of object that is used to do some wrapping to the NativeBoost primitives. 
Some primitives use self inside their code so you can call them on any object, e.g. :
self nbCall: #(bool Rf_isEnvironment(self))

However, other primitives have in argument a other object of the type SEXP, e.g (it is a method for adding in first place an element):
self nbCall: #(SEXP Rf_lcons(SEXP anElement, self))

The type SEXP is inevitably needed because you can puy any element in a list. So you have to convert the R* instances in SEXP to use as argument of the primitive.
You should use: asPureRObject. It convert (almost) any subclass of Object into a RObject.

Of course in the other way, the result of some functions are SEXPs so RObjects. If you want to use them completly, you should use asRObject to transform them.
It will create a new R* object, depending of the result of method typeOf. See newFromRObject: for the implementation.


How to create functions?
---------------------------------
See RFunction and tests to create them.


Memory protection
--------------------------
R system do some garbage collect on the allocated items.
To avoid the garbage collection of the objects, use the method protect of the object.
It is not implemented for now but should be...






"
Class {
	#name : #RObject,
	#superclass : #NBExternalObject,
	#traits : 'TRHelpers',
	#classTraits : 'TRHelpers classTrait',
	#pools : [
		'RLibTypes'
	],
	#category : #'RConnector-Core'
}

{ #category : #'trait - instance creation' }
RObject class >> createNewObjectFrom: aRObject [ 
	| instance  |
	instance := self new: aRObject prim_length.
	instance handle: aRObject handle.
	^ instance
]

{ #category : #accessing }
RObject class >> creationType [
	^ self = RObject ifTrue: [ NILSXP ] ifFalse: [ self type ]
]

{ #category : #'trait - function finding' }
RObject class >> findClassOf: aRObject [
	| type  |
	type := aRObject prim_typeOf.
	^ RLibTypes implementationClassRelatedTo: type
]

{ #category : #'trait - function finding' }
RObject class >> findFun: aStringOfFunctionName [
	^ self prim_findFun: (self prim_install: aStringOfFunctionName) option: self rGlobalEnv
]

{ #category : #'trait - function finding' }
RObject class >> findVar: aStringOfFunctionName [
	^ self prim_findVar: (self prim_install: aStringOfFunctionName) option: self rGlobalEnv
]

{ #category : #'trait - function finding' }
RObject class >> getRObjectFromGlobalVariable: varName [
	^ RObject new handle: (self nbGetGlobalVariable: varName)
]

{ #category : #'trait - library path' }
RObject class >> nbLibraryNameOrHandle [
	^ #R
]

{ #category : #'instance creation' }
RObject class >> new [
	^ self new: 1
]

{ #category : #'instance creation' }
RObject class >> new: size [
	^ self primNew: size type: self creationType
]

{ #category : #'trait - instance creation' }
RObject class >> newFromRObject: aRObject [
	| class |
	class := self findClassOf: aRObject.
	^ class createNewObjectFrom: aRObject 
]

{ #category : #'private - instance creation' }
RObject class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_allocVector(int type, int size))
]

{ #category : #'trait - private primitives' }
RObject class >> prim_findFun: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_findFun(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'trait - private primitives' }
RObject class >> prim_findVar: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_findVar(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'trait - private primitives' }
RObject class >> prim_install: aString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(String aString))
]

{ #category : #'trait - private primitives' }
RObject class >> prim_isBasicClass: aString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_isBasicClass(String aString))
]

{ #category : #'trait - global variables' }
RObject class >> rBaseEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_BaseEnv
]

{ #category : #'trait - global variables' }
RObject class >> rClassSymbol [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_ClassSymbol
]

{ #category : #'trait - global variables' }
RObject class >> rEmptyEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_EmptyEnv
]

{ #category : #'trait - global variables' }
RObject class >> rGlobalEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_GlobalEnv
]

{ #category : #'trait - global variables' }
RObject class >> rNamesSymbol [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_NamesSymbol
]

{ #category : #'trait - global variables' }
RObject class >> rNilValue [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_NilValue
]

{ #category : #accessing }
RObject class >> type [
	^ self shouldNotImplement 
]

{ #category : #'trait - converting' }
RObject >> asPureRObject [
	^ RObject createNewObjectFrom: self 
]

{ #category : #'trait - converting' }
RObject >> asRObject [
	^ self class newFromRObject: self 
]

{ #category : #'trait - converting' }
RObject >> char [
	self isChar
		ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_char
]

{ #category : #'trait - variable definition' }
RObject >> defineAsVarNamed: aRName [
	self assert: (aRName isKindOf: Symbol).	"Should be removed if the type is checked in the primitive"
	self defineAsVarNamed: aRName inEnv: self class rGlobalEnv.
	
]

{ #category : #'trait - variable definition' }
RObject >> defineAsVarNamed: aRName inEnv: anEnvironment [
	^ self prim_defineAsVarNamed: aRName asRObject inEnv: anEnvironment
]

{ #category : #'trait - converting' }
RObject >> int [
	self typeOf = #INTSXP ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_int
]

{ #category : #'trait - testing' }
RObject >> isChar [
	^ self typeOf = #CHARSXP
  
]

{ #category : #'trait - testing' }
RObject >> isComplex [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isComplex(self))
]

{ #category : #'trait - testing' }
RObject >> isEnvironment [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isEnvironment(self))
]

{ #category : #'trait - testing' }
RObject >> isExpression [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isExpression(self))
]

{ #category : #'trait - testing' }
RObject >> isInteger [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isInteger(self))
]

{ #category : #'trait - testing' }
RObject >> isList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isList(self))
]

{ #category : #'trait - testing' }
RObject >> isLogical [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isLogical(self))
]

{ #category : #'trait - testing' }
RObject >> isNull [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNull(self))
]

{ #category : #'trait - testing' }
RObject >> isNumber [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNumber(self))
]

{ #category : #'trait - testing' }
RObject >> isNumeric [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNumeric(self))
]

{ #category : #'trait - testing' }
RObject >> isObject [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isObject(self))
]

{ #category : #'trait - testing' }
RObject >> isPairList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isPairList(self))
]

{ #category : #'trait - testing' }
RObject >> isReal [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isReal(self))
]

{ #category : #'trait - testing' }
RObject >> isS4Object [
	"int (IS_S4_OBJECT)(SEXP x); -> bool because it is the same in C"
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool IS_S4_OBJECT(self))
]

{ #category : #'trait - testing' }
RObject >> isString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isString(self))
]

{ #category : #'trait - testing' }
RObject >> isSymbol [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isSymbol(self))
]

{ #category : #'trait - testing' }
RObject >> isValidString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isValidString(self))
]

{ #category : #'trait - testing' }
RObject >> isVector [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isVector(self))
]

{ #category : #'trait - testing' }
RObject >> isVectorList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isVectorList(self))
]

{ #category : #'trait - converting' }
RObject >> logical [
	self isLogical ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_logical
]

{ #category : #'trait - library path' }
RObject >> nbLibraryNameOrHandle [
 ^ self class nbLibraryNameOrHandle
]

{ #category : #'trait - private primitives' }
RObject >> prim_char [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(String R_CHAR(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_copyVectorFrom: anOldString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void Rf_copyVector(SEXP self, SEXP anOldString))
]

{ #category : #'trait - private primitives' }
RObject >> prim_curErrorBuf [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(String R_curErrorBuf())
]

{ #category : #'trait - private primitives' }
RObject >> prim_defineAsVarNamed: name inEnv: anEnvironment [ 
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void Rf_defineVar(SEXP name, self, SEXP anEnvironment))
]

{ #category : #'trait - private primitives' }
RObject >> prim_dimgets: val [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_dimgets(self, SEXP val))
]

{ #category : #'trait - private primitives' }
RObject >> prim_dimnamesgets: val [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_dimnamesgets(self, SEXP val))
]

{ #category : #'trait - private primitives' }
RObject >> prim_getArrayDimnames [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_GetArrayDimnames(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_int [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ (self
        nbCall: #(ulong INTEGER(self))) 
]

{ #category : #'trait - private primitives' }
RObject >> prim_length [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_length(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_list_ptr [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong LIST_POINTER(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_logical [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong LOGICAL(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_named [
	"int -> bool because it is the same in C"
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool NAMED(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_ncols [
	"No type testing ...Should only use on the right type (Matrix)"
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_ncols(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_nrows [
"No type testing ...Should only use on the right type (Matrix)"
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_nrows(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_real [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong REAL(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_setVectorElement: element at: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SET_VECTOR_ELT(self, int index, SEXP element))
]

{ #category : #'trait - private primitives' }
RObject >> prim_stringElementAt: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP STRING_ELT(self, int index))
]

{ #category : #'trait - private primitives' }
RObject >> prim_string_ptr [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong STRING_PTR(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_symbolValue [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SYMVALUE(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_typeOf [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int TYPEOF(self))
]

{ #category : #'trait - private primitives' }
RObject >> prim_vectorElementAt: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP VECTOR_ELT(self, int index))
]

{ #category : #'trait - private primitives' }
RObject >> prim_vector_ptr [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	self error: 'Must not be used !'.
    ^ self
        nbCall: #(ulong VECTOR_PTR(self))
]

{ #category : #'trait - not used' }
RObject >> prim_xlength [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_xlength(self))
]

{ #category : #'trait - not used' }
RObject >> print [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void Rf_PrintValue(self))
]

{ #category : #'trait - memory protection' }
RObject >> protect [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_protect(self))
]

{ #category : #'trait - not used' }
RObject >> raw [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(uchar RAW(self))
]

{ #category : #'trait - converting' }
RObject >> real [
	self isReal ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_real
]

{ #category : #'trait - converting' }
RObject >> string [
	self isString
		ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_string_ptr
]

{ #category : #'trait - accessing' }
RObject >> typeOf [
	^ RLibTypes typeRelatedToNumber: self prim_typeOf

]

{ #category : #'trait - accessing' }
RObject >> types [
	^ RObject selectors select: [ :s | ((s beginsWith: #is) and: [ self perform: s ] )] 
]

{ #category : #'trait - converting' }
RObject >> vector [
	"A vector_ptr function exists but doesn't work on vectors..... So we use the string one."
	self isVector
		ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_string_ptr
]
