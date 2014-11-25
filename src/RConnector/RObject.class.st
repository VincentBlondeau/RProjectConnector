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

{ #category : #'library path' }
RObject class >> R_BaseEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_BaseEnv
]

{ #category : #'library path' }
RObject class >> R_EmptyEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_EmptyEnv
]

{ #category : #'library path' }
RObject class >> R_GlobalEnv [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_GlobalEnv
]

{ #category : #'library path' }
RObject class >> R_NilValue [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self getRObjectFromGlobalVariable: #R_NilValue
]

{ #category : #'library path' }
RObject class >> Rf_findFun: aNBSEXPfunction option: aNbSEXPoption [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_findFun(SEXP aNBSEXPfunction, SEXP aNbSEXPoption))
]

{ #category : #'library path' }
RObject class >> Rf_install: aString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_install(const char * aString))
]

{ #category : #'as yet unclassified' }
RObject class >> createNewObjectFrom: aRObject withClass: class [
	| instance |
	instance := class new: aRObject length.
	instance handle: aRObject handle.
	^ instance
]

{ #category : #'as yet unclassified' }
RObject class >> findClassOf: aRObject [
	| type classes |
	type := aRObject prim_typeOf.
	classes := RObject allSubclasses select: [ :c | [c type = type] onDNU: #type do: [ false ] ].
	classes size = 1 ifFalse: [ Error signal ]."detect should be used"
	^ classes first 
]

{ #category : #'as yet unclassified' }
RObject class >> findFun: aStringOfFunctionName [
	^ self Rf_findFun: (self Rf_install: aStringOfFunctionName) option: self R_GlobalEnv
]

{ #category : #'as yet unclassified' }
RObject class >> getRObjectFromGlobalVariable: varName [
	^ RObject new  handle: (self nbGetGlobalVariable: varName)
]

{ #category : #'as yet unclassified' }
RObject class >> new: size [
	^ self primNew: size type: self type
]

{ #category : #'as yet unclassified' }
RObject class >> newFromRObject: aRObject [
	| class |
	class := self findClassOf: aRObject.
	^ self createNewObjectFrom: aRObject withClass: class
]

{ #category : #'as yet unclassified' }
RObject class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(SEXP Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RObject class >> type [
	^ NILSXP
]

{ #category : #testing }
RObject >> asPureRObject [
	^ self class createNewObjectFrom: self withClass: RObject
]

{ #category : #testing }
RObject >> asRObject [
	^ self class newFromRObject: self 
]

{ #category : #'as yet unclassified' }
RObject >> int [
	self isInteger ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_int
]

{ #category : #testing }
RObject >> isComplex [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isComplex(self))
]

{ #category : #testing }
RObject >> isEnvironment [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isEnvironment(self))
]

{ #category : #testing }
RObject >> isExpression [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isExpression(self))
]

{ #category : #testing }
RObject >> isInteger [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isInteger(self))
]

{ #category : #testing }
RObject >> isList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isList(self))
]

{ #category : #testing }
RObject >> isLogical [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isLogical(self))
]

{ #category : #testing }
RObject >> isNull [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNull(self))
]

{ #category : #testing }
RObject >> isNumber [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNumber(self))
]

{ #category : #testing }
RObject >> isNumeric [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNumeric(self))
]

{ #category : #testing }
RObject >> isObject [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isObject(self))
]

{ #category : #testing }
RObject >> isPairList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isPairList(self))
]

{ #category : #testing }
RObject >> isReal [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isReal(self))
]

{ #category : #testing }
RObject >> isString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isString(self))
]

{ #category : #testing }
RObject >> isSymbol [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isSymbol(self))
]

{ #category : #testing }
RObject >> isValidString [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isValidString(self))
]

{ #category : #testing }
RObject >> isVector [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isVector(self))
]

{ #category : #testing }
RObject >> isVectorList [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isVectorList(self))
]

{ #category : #accessing }
RObject >> length [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_length(self))
]

{ #category : #'library path' }
RObject >> nbLibraryNameOrHandle [
 ^ self class nbLibraryNameOrHandle
]

{ #category : #private }
RObject >> prim_int [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ (self
        nbCall: #(ulong INTEGER(self))) 
]

{ #category : #'as yet unclassified' }
RObject >> prim_real [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(ulong REAL(self))
]

{ #category : #private }
RObject >> prim_typeOf [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int TYPEOF(self))
]

{ #category : #'as yet unclassified' }
RObject >> print [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(void Rf_PrintValue(self))
]

{ #category : #'as yet unclassified' }
RObject >> protect [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(SEXP Rf_protect(self))
]

{ #category : #'as yet unclassified' }
RObject >> raw [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(uchar RAW(self))
]

{ #category : #'as yet unclassified' }
RObject >> real [
	self isReal ifFalse: [ CannotBeConvertedToType signal ].
	^ self prim_real
]

{ #category : #'as yet unclassified' }
RObject >> typeOf [
	^ RLibTypes typeRelatedToNumber: self prim_typeOf

]

{ #category : #accessing }
RObject >> types [
	^ RObject selectors select: [ :s | ((s beginsWith: #is) and: [ self perform: s ] )] 
]

{ #category : #'as yet unclassified' }
RObject >> xlength [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(int Rf_xlength(self))
]
