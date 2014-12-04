Class {
	#name : #RRealList,
	#superclass : #RList,
	#type : #variable,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RRealList class >> primNew: size type: type [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: #errorCode>
	^ self nbCall: #(RRealList Rf_allocVector (int type, int size))
]

{ #category : #'as yet unclassified' }
RRealList class >> type [
	^ LISTSXP
]
