Class {
	#name : #RCollectionTest,
	#superclass : #RAbstractTest,
	#category : #'RConnector-Tests'
}

{ #category : #'as yet unclassified' }
RCollectionTest >> testConversionRObjectToSubTypeOfRObject [
	| data  dataExternalArrayHandle rObject newData |
	data := RIntVector new.
	data
		addAll:
			{-1.
			1.
			0.
			51.
			-42}.
	dataExternalArrayHandle := data collector address.
	rObject := data asPureRObject.
	newData := rObject asRObject.
	self assert: data int equals: newData collector address value.
	self assert: data int equals: dataExternalArrayHandle value.
	self assert:  newData collector address value  equals: dataExternalArrayHandle value.
	
	
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testConversionRObjectToSubTypeOfRObject2 [
	| data  dataExternalArrayHandle rObject newData |
	data := RIntVector new.
	dataExternalArrayHandle := data collector address.
	rObject := data asPureRObject.
	newData := rObject asRObject.
	self assert: data int equals: newData collector address value.
	self assert: data int equals: dataExternalArrayHandle value.
	self assert:  newData collector address value  equals: dataExternalArrayHandle value.
	
	
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testDoubleVectorSet [
	| vector |
	vector := RDoubleVector new: 1.
	vector add: 1.2.
	self assert: (vector at: 1) equals: 1.2
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testIntVectorAddFirst [
	| vector |
	vector := RIntVector new: 1.
	vector add: 22.
	vector addFirst: 12.
	self assert: (vector at: 1) equals: 12.
	self assert: (vector at: 2) equals: 22.
	self assert: vector prim_length equals: 2."the true length for R"
	
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testIntVectorSet [
	| vector |
	vector := RIntVector new: 1.
	vector add: 12.
	self assert: (vector at: 1) equals: 12
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testIntVectorSetOverFlowCapacity [
	| vector |
	vector := RIntVector new: 1.
	vector add: 12.
	vector add: 22.
	self assert: (vector at: 1) equals: 12.
	self assert: (vector at: 2) equals: 22.
	self assert: vector prim_length equals: 2."the true length for R"
	
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testIntVectorSetWithAddAll [
	| data |
	data := RIntVector new.
	data
		addAll:
			{-1.
			1.
			0.
			51.
			-42}.
	self assert: data prim_length equals: 5.
	self assert: data size equals: 5
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testLangageListAddThreeElements [
	| langageList |
	"List = Last In First Out"
	langageList := RLangageExpression newEmptyChainedList.
	langageList add: 2.
	langageList add: (RObject findFun:'~').
	langageList add: 3.
	self assert: langageList size equals: 1.
	self assert: langageList first asRObject asOrderedCollection equals: #(3) asOrderedCollection
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testLangageListCreationFromNil [
	| langageList |
	langageList := RLangageExpression newEmptyChainedList.
	langageList add: 2.
	self assert: langageList size equals: 1.
	self assert: langageList first asRObject asOrderedCollection equals: #(2) asOrderedCollection
]

{ #category : #'as yet unclassified' }
RCollectionTest >> testStringAccess [
	| string |
	string := 'string' asRObject.
	self assert: (string isKindOf: RStringVector).
	self assert: string value equals: 'string'.
]
