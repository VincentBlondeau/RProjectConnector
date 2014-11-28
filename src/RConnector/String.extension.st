Extension { #name : #String }

{ #category : #'*RConnector' }
String >> asRObject [
	^ RString primNew: self
]
