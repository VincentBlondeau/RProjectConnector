Class {
	#name : #RConnectorTest,
	#superclass : #RAbstractTest,
	#category : #'RConnector-Tests'
}

{ #category : #'as yet unclassified' }
RConnectorTest >> testIfSessionIsValid [
	"If this test is not working, it means that the RConnector can be used because the session is not initialized"
	RSession checkWorking.
]

{ #category : #'as yet unclassified' }
RConnectorTest >> testInstallPackageShouldWork [
	| evn |
	self fail. "The following elements crash the image"
	evn := RSession Rf_install: 'forecast'.
	RObject findFun: 'forecast'.
	
	
	
]
