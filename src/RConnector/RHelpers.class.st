Class {
	#name : #RHelpers,
	#superclass : #Object,
	#traits : 'TRLibrary',
	#classTraits : 'TRLibrary classTrait',
	#category : #RConnector
}

{ #category : #'as yet unclassified' }
RHelpers class >> Rf_isComplex: aPointerToSExp [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isComplex(ulong aPointerToSExp))
]

{ #category : #'as yet unclassified' }
RHelpers class >> Rf_isEnvironment: aPointerToSExp [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isEnvironment(ulong aPointerToSExp))
]

{ #category : #'as yet unclassified' }
RHelpers class >> Rf_isExpression: aPointerToSExp [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isExpression(ulong aPointerToSExp))
]

{ #category : #'as yet unclassified' }
RHelpers class >> Rf_isLogical: aPointerToSExp [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isLogical(ulong aPointerToSExp))
]

{ #category : #'as yet unclassified' }
RHelpers class >> Rf_isNull: aPointerToSExp [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isNull(ulong aPointerToSExp))
]

{ #category : #'as yet unclassified' }
RHelpers class >> Rf_isObject: aPointerToSExp [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isObject(ulong aPointerToSExp))
]

{ #category : #'as yet unclassified' }
RHelpers class >> Rf_isReal: aPointerToSExp [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isReal(ulong aPointerToSExp))
]

{ #category : #'as yet unclassified' }
RHelpers class >> Rf_isString: aPointerToSExp [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isString(ulong aPointerToSExp))
]

{ #category : #'as yet unclassified' }
RHelpers class >> Rf_isSymbol: aPointerToSExp [
    <primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
    ^ self
        nbCall: #(bool Rf_isSymbol(ulong aPointerToSExp))
]
