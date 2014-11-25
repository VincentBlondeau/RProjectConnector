Class {
	#name : #RCollection,
	#superclass : #RObject,
	#category : #'RConnector-Core'
}

{ #category : #'as yet unclassified' }
RCollection >> addAll: aCollection [
	aCollection do: [ :item | self add: item asRObject ]

]
