Class {
	#name : #RLogical,
	#superclass : #RObject,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RLogical class >> newFrom: aBoolean [
	^ self primNewFrom: aBoolean asBit
]

{ #category : #'as yet unclassified' }
RLogical class >> primNewFrom: aBooleanAsInt [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RLogical Rf_ScalarLogical(int aBooleanAsInt))
]

{ #category : #'as yet unclassified' }
RLogical >> = anElement [
	^ self value = anElement value value
]

{ #category : #'as yet unclassified' }
RLogical >> asRLogical [
	^ self
]

{ #category : #'as yet unclassified' }
RLogical >> printOn: aStream [
	aStream << self value
]

{ #category : #'as yet unclassified' }
RLogical >> value [
	^ self logical asDereferencedPointer
]
