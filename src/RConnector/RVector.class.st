"
A RVector is is an abstract reprensentation of a vector in R. Its subclasses OrdreredCollection to use all the potential of the class. Some functions could be not working since the collection attached to the vector is a subclass of NBExternalArray instead of an Array.


Instance Variables
	handle:		a NBExternalHandle

handle
	- the handle represents (as in NBExternalObject) the pointer to the R external object. The array containing the data (is the vector elements) is included in the R external object and his pointer can be accessed by the firstPointer method (see subclasses for impl). This pointer should NOT be reallocated with the methods of NBExternalArray. A new RVector object  has to be created with the Rf_AllocVector primitive and the handles swapped (see growAtLast for impl).


"
Class {
	#name : #RVector,
	#superclass : #OrderedCollection,
	#traits : 'TRHelpers + TRClassExtension',
	#classTraits : 'TRHelpers classTrait + TRClassExtension classTrait',
	#instVars : [
		'handle'
	],
	#pools : [
		'RLibTypes'
	],
	#classInstVars : [
		'arrayType'
	],
	#category : #'RConnector-Core'
}

{ #category : #'trait - function finding' }
RVector class >> arrayType [
	"This value has to be cached or be a real subclass for performances issues."

	^ arrayType ifNil: [ arrayType := NBExternalArray ofType: self arrayTypePrimitiveType ]
]

{ #category : #'trait - function finding' }
RVector class >> arrayTypePrimitiveType [
	^ self subclassResponsibility
]

{ #category : #'trait - converting' }
RVector class >> asNBExternalType: gen [
	^ NBExternalObjectType objectClass: self
]

{ #category : #'instance creation' }
RVector class >> createNewObjectFrom: aRObject [
	| instance |
	instance := self basicNew handle: aRObject handle.
	instance
		setCollection:
			(self arrayType onAddress: (NBExternalAddress value: (aRObject perform: self firstPointer)) size: aRObject prim_length).
	instance initialize.
	^ instance
]

{ #category : #'trait - function finding' }
RVector class >> findClassOf: aRObject [
	| type  |
	type := aRObject prim_typeOf.
	^ RLibTypes implementationClassRelatedTo: type
]

{ #category : #'trait - function finding' }
RVector class >> findFun: aStringOfFunctionName [
	^ self prim_findFun: (self prim_install: aStringOfFunctionName) option: self rGlobalEnv
]

{ #category : #'trait - function finding' }
RVector class >> findVar: aStringOfFunctionName [
	^ self prim_findVar: (self prim_install: aStringOfFunctionName) option: self rGlobalEnv
]

{ #category : #'trait - function finding' }
RVector class >> getRObjectFromGlobalVariable: varName [
	^ RObject new handle: (self nbGetGlobalVariable: varName)
]

{ #category : #'trait - library path' }
RVector class >> nbLibraryNameOrHandle [
	^ #R
]

{ #category : #'instance creation' }
RVector class >> new [
	"If the array is not initialized at size 1 first. Then some synchronization problems with the external array can appears..."
	^ self new: 1
]

{ #category : #'instance creation' }
RVector class >> new: size [
	| instance |
	instance := self primNew: size.
	instance setCollection: (self arrayType onAddress: (NBExternalAddress value: instance firstPointer) size: size).
	instance resetToExternalCollection.
	^ instance
]

{ #category : #'trait - instance creation' }
RVector class >> newFromRObject: aRObject [
	| class |
	class := self findClassOf: aRObject.
	^ class createNewObjectFrom: aRObject 
]

{ #category : #'trait - private - instance creation' }
RVector class >> primNew: size [
	^ self primNew: size type: self type
]

{ #category : #'private - instance creation' }
RVector class >> primNew: size type: type [
	^ self subclassResponsibility  
]

{ #category : #'trait - private primitives' }
RVector class >> prim_findFun: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_findFun(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'trait - private primitives' }
RVector class >> prim_findVar: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_findVar(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'trait - private primitives' }
RVector class >> prim_install: aString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(String aString))
]

{ #category : #'trait - private primitives' }
RVector class >> prim_isBasicClass: aString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_isBasicClass(String aString))
]

{ #category : #'trait - global variables' }
RVector class >> rBaseEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_BaseEnv
]

{ #category : #'trait - global variables' }
RVector class >> rClassSymbol [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_ClassSymbol
]

{ #category : #'trait - global variables' }
RVector class >> rEmptyEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_EmptyEnv
]

{ #category : #'trait - global variables' }
RVector class >> rGlobalEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_GlobalEnv
]

{ #category : #'trait - global variables' }
RVector class >> rNamesSymbol [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_NamesSymbol
]

{ #category : #'trait - global variables' }
RVector class >> rNilValue [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_NilValue
]

{ #category : #accessing }
RVector class >> type [
	^ self subclassResponsibility
]

{ #category : #adding }
RVector >> addFirst: anElement [
	self shouldNotImplement
]

{ #category : #adding }
RVector >> addLast: anElement [
	[ super addLast: anElement ]
		on: NBFFICalloutError
		do: [ self error: 'Maybe you should check the value of ''anElement''' ].
	self setLength: self size	"((self size) min: self capacity)"
]

{ #category : #'trait - converting' }
RVector >> asPureRObject [
	^ RObject createNewObjectFrom: self 
]

{ #category : #converting }
RVector >> asRObject [
	^ self
]

{ #category : #'trait - converting' }
RVector >> char [
	self isChar
		ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_char
]

{ #category : #'trait - variable definition' }
RVector >> defineAsVarNamed: aRName [
	self assert: (aRName isKindOf: Symbol).	"Should be removed if the type is checked in the primitive"
	^ self defineAsVarNamed: aRName inEnv: self class rGlobalEnv
]

{ #category : #'trait - variable definition' }
RVector >> defineAsVarNamed: aRName inEnv: anEnvironment [
	^ self prim_defineAsVarNamed: aRName asRObject inEnv: anEnvironment
]

{ #category : #accessing }
RVector >> firstPointer [
	^ self subclassResponsibility 
]

{ #category : #private }
RVector >> growAtLast [
	"overridden to create external objects"

	"We should recreate a new instance because there is no reallocation in the RAPI. So we swap the handles"

	"Protect and unprotect methods should be added too"

	| newArray newInstance size |
	size := array size * 2 max: 1.
	newInstance := self class primNew: size.
	self handle: newInstance handle.
	newArray := self class arrayType onAddress: (NBExternalAddress value: newInstance firstPointer) size: size.
	newArray
		replaceFrom: firstIndex
		to: lastIndex
		with: array
		startingAt: firstIndex.
	array := newArray
]

{ #category : #accessing }
RVector >> handle [
	^ handle value


]

{ #category : #accessing }
RVector >> handle: aUint [
	handle value: aUint



]

{ #category : #initialization }
RVector >> initialize [
	firstIndex := 1.
	lastIndex := (self capacity)
]

{ #category : #initialization }
RVector >> initializeHandle [
	handle := NBExternalHandle new

	
]

{ #category : #'trait - converting' }
RVector >> int [
	self isInteger ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_int
]

{ #category : #'trait - testing' }
RVector >> isChar [
	^ self typeOf = #CHARSXP
  
]

{ #category : #'trait - testing' }
RVector >> isComplex [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isComplex(self))
]

{ #category : #'trait - testing' }
RVector >> isEnvironment [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isEnvironment(self))
]

{ #category : #'trait - testing' }
RVector >> isExpression [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isExpression(self))
]

{ #category : #'trait - testing' }
RVector >> isInteger [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isInteger(self))
]

{ #category : #'trait - testing' }
RVector >> isList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isList(self))
]

{ #category : #'trait - testing' }
RVector >> isLogical [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isLogical(self))
]

{ #category : #'trait - testing' }
RVector >> isNull [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNull(self))
]

{ #category : #'trait - testing' }
RVector >> isNumber [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNumber(self))
]

{ #category : #'trait - testing' }
RVector >> isNumeric [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNumeric(self))
]

{ #category : #'trait - testing' }
RVector >> isObject [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isObject(self))
]

{ #category : #'trait - testing' }
RVector >> isPairList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isPairList(self))
]

{ #category : #'trait - testing' }
RVector >> isReal [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isReal(self))
]

{ #category : #'trait - testing' }
RVector >> isS4Object [
	"int (IS_S4_OBJECT)(SEXP x); -> bool because it is the same in C"
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool IS_S4_OBJECT(self))
]

{ #category : #'trait - testing' }
RVector >> isString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isString(self))
]

{ #category : #'trait - testing' }
RVector >> isSymbol [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isSymbol(self))
]

{ #category : #'trait - testing' }
RVector >> isValidString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isValidString(self))
]

{ #category : #'trait - testing' }
RVector >> isVector [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isVector(self))
]

{ #category : #'trait - testing' }
RVector >> isVectorList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isVectorList(self))
]

{ #category : #'trait - converting' }
RVector >> logical [
	self isLogical ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_logical
]

{ #category : #'trait - library path' }
RVector >> nbLibraryNameOrHandle [
 ^ self class nbLibraryNameOrHandle
]

{ #category : #'trait - private primitives' }
RVector >> prim_char [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(String R_CHAR(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_copyVectorFrom: anOldString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void Rf_copyVector(SEXP self, SEXP anOldString))
]

{ #category : #'trait - private primitives' }
RVector >> prim_curErrorBuf [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(String R_curErrorBuf())
]

{ #category : #'trait - private primitives' }
RVector >> prim_defineAsVarNamed: name inEnv: anEnvironment [ 
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void Rf_defineVar(SEXP name, self, SEXP anEnvironment))
]

{ #category : #'trait - private primitives' }
RVector >> prim_dimgets: val [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_dimgets(self, SEXP val))
]

{ #category : #'trait - private primitives' }
RVector >> prim_dimnamesgets: val [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_dimnamesgets(self, SEXP val))
]

{ #category : #'trait - private primitives' }
RVector >> prim_getArrayDimnames [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_GetArrayDimnames(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_int [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ (self
        nbCall: #(ulong INTEGER(self))) 
]

{ #category : #'trait - private primitives' }
RVector >> prim_length [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_length(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_list_ptr [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong LIST_POINTER(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_logical [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong LOGICAL(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_named [
	"int -> bool because it is the same in C"
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool NAMED(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_ncols [
	"No type testing ...Should only use on the right type (Matrix)"
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_ncols(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_nrows [
"No type testing ...Should only use on the right type (Matrix)"
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_nrows(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_real [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong REAL(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_setVectorElement: element at: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SET_VECTOR_ELT(self, int index, SEXP element))
]

{ #category : #'trait - private primitives' }
RVector >> prim_stringElementAt: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP STRING_ELT(self, int index))
]

{ #category : #'trait - private primitives' }
RVector >> prim_string_ptr [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong STRING_PTR(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_symbolValue [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP SYMVALUE(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_typeOf [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int TYPEOF(self))
]

{ #category : #'trait - private primitives' }
RVector >> prim_vectorElementAt: index [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP VECTOR_ELT(self, int index))
]

{ #category : #'trait - private primitives' }
RVector >> prim_vector_ptr [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	self error: 'Must not be used !'.
    ^ self
        nbCall: #(ulong VECTOR_PTR(self))
]

{ #category : #'trait - not used' }
RVector >> prim_xlength [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_xlength(self))
]

{ #category : #'trait - not used' }
RVector >> print [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void Rf_PrintValue(self))
]

{ #category : #'trait - memory protection' }
RVector >> protect [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_protect(self))
]

{ #category : #'trait - not used' }
RVector >> raw [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(uchar RAW(self))
]

{ #category : #'trait - converting' }
RVector >> real [
	self isReal ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_real
]

{ #category : #private }
RVector >> resetToExternalCollection [
	lastIndex := self prim_length
]

{ #category : #private }
RVector >> setLength: length [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void SETLENGTH(self, int length))
]

{ #category : #'trait - converting' }
RVector >> string [
	self isString
		ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_string_ptr
]

{ #category : #'private - notused' }
RVector >> truelength [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int TRUELENGTH(self))
]

{ #category : #'trait - accessing' }
RVector >> typeOf [
	^ RLibTypes typeRelatedToNumber: self prim_typeOf

]

{ #category : #'trait - accessing' }
RVector >> types [
	^ RObject selectors select: [ :s | ((s beginsWith: #is) and: [ self perform: s ] )] 
]

{ #category : #'trait - converting' }
RVector >> vector [
	"A vector_ptr function exists but doesn't work on vectors..... So we use the string one."
	self isVector
		ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_string_ptr
]
